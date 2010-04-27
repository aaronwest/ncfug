<!---
License:
Copyright 2008 GreatBizTools, LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Copyright: GreatBizTools, LLC
Author: Peter J. Farrell (peter@mach-ii.com)
$Id: Logger.cfc 932 2008-07-31 06:41:20Z peterfarrell $

Created version: 1.6.0
Updated version: 1.6.0

Notes:
--->
<cfcomponent
	displayname="ExceptionLog.Logger"
	extends="MachII.logging.loggers.AbstractLogger"
	output="false"
	hint="A logger for exceptions.">
	
	<!---
	PROPERTIES
	--->
	<cfset variables.instance.loggerTypeName = "Exception" />
	<cfset variables.instance.snapshotLevel = "Error" />
	<cfset variables.instance.dashboardModuleName = "" />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the logger.">
		
		<cfset var filter = CreateObject("component", "MachII.logging.filters.GenericChannelFilter").init(getParameter("filter", "")) />
		<cfset var adapter = CreateObject("component", "MachII.logging.adapters.ScopeAdapter").init(getParameters()) />
		
		<!--- Set the filter to the adapter --->
		<cfset adapter.setFilter(filter) />
		
		<!--- Configure and set the adapter --->
		<cfset adapter.configure()>
		<cfset setLogAdapter(adapter) />
		
		<!--- Add the adapter to the log factory --->
		<cfset getLogFactory().addLogAdapter(adapter) />

		<!--- Setup the parameters --->
		<cfset setSnapshotLevel(getParameter("snapshotLevel", "error")) />
		<cfset setDashboardModuleName(getParameter("dashboardModuleName")) />
		
		<!--- Flush the data storage --->
		<cfset getDataStorage(true) />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="onRequestEnd" access="public" returntype="void" output="false"
		hint="Peforms the saving of data for this logger.">
		
		<cfset var requestInfo = StructNew() />
		<cfset var dataStorage = StructNew() />
		<cfset var snapshotLevelNumber = getSnapshotLevelNumber() />
		<cfset var i = 0 />
		
		<!--- Only display output if logging is enabled --->
		<cfif getLogAdapter().getLoggingEnabled()
			AND getLogAdapter().isLoggingDataDefined()>

			<!--- Do not save exceptions that happen in the dashboard module --->
			<cfif arguments.appManager.getRequestHandler().getRequestModuleName() NEQ getDashboardModuleName()>
				<cfset dataStorage = getDataStorage() />
				<cfset requestInfo.messages = getLogAdapter().getLoggingData().data />
				
				<cfloop from="1" to="#ArrayLen(requestInfo.messages)#" index="i">
					<cfif requestInfo.messages[i].logLevel GTE snapshotLevelNumber>
						<cfset requestInfo.timestamp = Now() />
						<cfset requestInfo.requestEventName = arguments.appManager.getRequestHandler().getRequestEventName() />
						<cfif Len(arguments.appManager.getRequestHandler().getRequestModuleName())>
							<cfset requestInfo.requestModuleName = arguments.appManager.getRequestHandler().getRequestModuleName() />
						<cfelse>
							<cfset requestInfo.requestModuleName = "base" />
						</cfif>
						<cfset requestInfo.logLevelName = requestInfo.messages[i].logLevelName />
						<cfset ArrayPrepend(dataStorage.data, requestInfo) />
						<cfbreak />
					</cfif>
				</cfloop>
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction name="preRedirect" access="public" returntype="void" output="false"
		hint="Pre-redirect logic for this logger.">
		<cfargument name="data" type="struct" required="true"
			hint="Redirect persist data struct." />
		
		<cfif getLogAdapter().getLoggingEnabled() AND getLogAdapter().isLoggingDataDefined()>
			<cfset arguments.data[getLoggerId()] = getLogAdapter().getLoggingData() />
		</cfif>
	</cffunction>

	<cffunction name="postRedirect" access="public" returntype="void" output="false"
		hint="Post-redirect logic for this logger.">
		<cfargument name="data" type="struct" required="true"
			hint="Redirect persist data struct." />

		<cfset var loggingData = "" />
		
		<cfif getLogAdapter().getLoggingEnabled() AND getLogAdapter().isLoggingDataDefined()>
			<cftry>
				<cfset loggingData = getLogAdapter().getLoggingData() />
				<cfset loggingData.data = arrayConcat(arguments.data[getLoggerId()].data, loggingData.data) />
				<cfcatch type="any">
					<!--- Do nothing as the configuration may have changed between start of
					the redirect and now --->
				</cfcatch>
			</cftry>
		</cfif>
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS - UTILS
	--->
	<cffunction name="getConfigurationData" access="public" returntype="struct" output="false"
		hint="Gets the configuration data for this logger including adapter and filter.">
		
		<cfset var data = StructNew() />
		
		<cfset data["Logging Enabled"] = YesNoFormat(isLoggingEnabled()) />
		<cfset data["Snapshot Level"] = getSnapshotLevel() />
		
		<cfreturn data />
	</cffunction>
	
	<cffunction name="getDataStorage" access="public" returntype="struct" output="false"
		hint="Gets a reference to the data storage and creates it if is not available.">
		<cfargument name="flush" type="boolean" required="false" default="false" />
		
		<cfif NOT StructKeyExists(application, "_MachIIExceptionLoggerData") 
			OR arguments.flush>
			<cfset application._MachIIExceptionLoggerData = StructNew() />
			<cfset application._MachIIExceptionLoggerData.data = ArrayNew(1) />
		</cfif>
		
		<cfreturn application._MachIIExceptionLoggerData />
	</cffunction>

	<!---
	PROTECTED FUNCTIONS
	--->
	<cffunction name="arrayConcat" access="private" returntype="array" output="false"
		hint="Concats two arrays together.">
		<cfargument name="array1" type="array" required="true" />
		<cfargument name="array2" type="array" required="true" />
		
		<cfset var result = arguments.array1 />
		<cfset var i = 0 />
		
		<cfloop from="1" to="#ArrayLen(arguments.array2)#" index="i">
			<cfset ArrayAppend(result, arguments.array2[i]) />
		</cfloop>
		
		<cfreturn result />
	</cffunction>
	
	<cffunction name="getSnapshotLevelNumber" access="private" returntype="numeric" output="false"
		hint="Gets the snapshot level number.">
		
		<cfset var snapshotLevel = getSnapshotLevel() />
		
		<cfif snapshotLevel EQ "trace">
			<cfreturn 1 />
		<cfelseif  snapshotLevel EQ "debug">
			<cfreturn 2 />
		<cfelseif  snapshotLevel EQ "info">
			<cfreturn 3 />
		<cfelseif  snapshotLevel EQ "warn">
			<cfreturn 4 />
		<cfelseif  snapshotLevel EQ "error">
			<cfreturn 5 />
		<cfelseif  snapshotLevel EQ "fatal">
			<cfreturn 6 />
		<cfelseif  snapshotLevel EQ "all">
			<cfreturn 0 />
		<cfelseif  snapshotLevel EQ "off">
			<cfreturn 7 />
		</cfif>
	</cffunction>
	
	<!---
	ACCESSORS
	--->
	<cffunction name="setSnapshotLevel" access="public" returntype="void" output="false">
		<cfargument name="snapshotLevel" type="string" required="true" />
		
		<cfif NOT ListFindNoCase("all,trace,debug,info,warn,error,fatal,none", arguments.snapshotLevel)>
			<cfthrow 
				type="MachIIDashboard.logging.loggers.ExceptionLog.Logger"
				message="Snapshot level is not of value 'all', 'trace', 'debug', 'info', 'warn', 'error', 'fatal' or 'none'."
				detail="Passed value: '#arguments.snapshotLevel#" />
		</cfif>
		
		<cfset variables.instance.snapshotLevel = arguments.snapshotLevel />
	</cffunction>
	<cffunction name="getSnapshotLevel" access="public" returntype="string" output="false">
		<cfreturn variables.instance.snapshotLevel />
	</cffunction>

	<cffunction name="setDashboardModuleName" access="private" returntype="void" output="false">
		<cfargument name="dashboardModuleName" type="string" required="true" />
		<cfset variables.instance.dashboardModuleName = arguments.dashboardModuleName />
	</cffunction>
	<cffunction name="getDashboardModuleName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.dashboardModuleName />
	</cffunction>
	
</cfcomponent>