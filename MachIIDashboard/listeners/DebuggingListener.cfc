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
$Id: DebuggingListener.cfc 1072 2008-09-16 23:12:17Z peterfarrell $

Created version: 1.0.0
Updated version: 1.0.0

Notes:
--->
<cfcomponent
	displayname="FrameworkListener"
	extends="MachII.framework.Listener"	
	output="false"
	hint="Basic interface for base framework structures.">

	<!---
	PROPERTIES
	--->
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Initializes the listener.">
		<!--- Does nothing --->
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="enableDisableExceptionViewer" access="public" returntype="void" output="false"
		hint="Enables/disables a exception viewer.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var logger = getExceptionViewer(arguments.event) />
		<cfset var mode = arguments.event.getArg("mode") />		
		
		<cfif mode EQ "enable">
			<cfset logger.setLoggingEnabled(true) />
			<cfset arguments.event.setArg("message", "Enabled exception viewer.") />
		<cfelse>
			<cfset logger.setLoggingEnabled(false) />
			<cfset arguments.event.setArg("message", "Disabled exception viewer.") />
		</cfif>
	</cffunction>
	
	<cffunction name="getExceptionViewerDataStorage" access="public" returntype="struct" output="false"
		hint="Enables/disables a exception viewer.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfreturn getExceptionViewer(arguments.event).getDataStorage() />
	</cffunction>

	<cffunction name="flushExceptionViewerDataStorage" access="public" returntype="void" output="false"
		hint="Changes snapshot level for the exception viewer.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfset getExceptionViewer(arguments.event).getDataStorage(true) />
		<cfset arguments.event.setArg("message", "Flushed exception viewer data storage.") />
	</cffunction>

	<cffunction name="changeSnapshotLevel" access="public" returntype="void" output="false"
		hint="Changes snapshot level for the exception viewer.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfset getExceptionViewer(arguments.event).setSnapshotLevel(arguments.event.getArg("level")) />
		<cfset arguments.event.setArg("message", "Changed snapshot level to '#level#'.") />
	</cffunction>
	
	<cffunction name="getExceptionViewer" access="public" returntype="any" output="false"
		hint="Gets the exception viewer.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfreturn getProperty("logging").getLoggerByName("exception") />
	</cffunction>

</cfcomponent>