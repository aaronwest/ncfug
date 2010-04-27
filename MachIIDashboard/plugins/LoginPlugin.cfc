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
$Id: LoginPlugin.cfc 1037 2008-09-14 05:43:43Z peterfarrell $

Created version: 1.0.0
Updated version: 1.0.0

Notes:
--->
<cfcomponent 
	displayname="LoginPlugin" 
	extends="MachII.framework.Plugin" 
	output="false" 
	hint="">

	<!---
	PROPERTIES
	--->
	<cfset variables.unprotectedEvents = ArrayNew(1) />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false" 
		hint="Performs configuration logic.">
			
		<cfset var unprotectedEvents = getParameter("unprotectedEvents") />
		
		<!--- Add the exception event --->
		<cfset ArrayAppend(unprotectedEvents, getProperty("exceptionEvent")) />
		<cfset setUnprotectedEvents(unprotectedEvents) />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS - PLUGIN POINTS
	--->
	<cffunction name="preProcess" access="public" returntype="void" output="false"
		hint="PreProcess plugin point that checks if the user is logged in.">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		
		<cfset var event = arguments.eventContext.getNextEvent() />
		<cfset var requestEventName = event.getRequestName() />
		<cfset var message = "You must login before you can gain access to this feature." />

		<cfif event.isArgDefined("password")> 
			<cfif event.getArg("password") EQ getProperty("password")>
				<cfset setLoggedIn(true) />
			<cfelse>
				<cfset message = "Incorrect password. Please try again." />
			</cfif>
		</cfif>
		
		<cfif event.isArgDefined("logout")>
			<cfset setLoggedIn(false) />
			<cfset message = "You have been logged out." />
		</cfif>
		
		<cfif NOT isLoggedIn() AND isProtectedEvent(requestEventName)>
			<cfset arguments.eventContext.clearEventQueue() />
			<cfset event.setArg("message", message) />
			<cfset announceEvent("sys.login", event.getArgs()) />				
		</cfif>
	</cffunction>
	
	<!---
	PROTECTED FUNCTIONS
	--->
	<cffunction name="isLoggedIn" access="private" returntype="boolean" output="false"
		hint="Checks if the user is logged in.">
		
		<cfset var scope = StructGet(getProperty("sessionManagementScope")) />
		
		<cfif NOT StructKeyExists(scope, "_MachIIDashboard_loginStatus")>
			<cfset scope._MachIIDashboard_loginStatus = false />
		</cfif>
		
		<cfreturn scope._MachIIDashboard_loginStatus />
	</cffunction>
	
	<cffunction name="setLoggedIn" access="private" returntype="void" output="false"
		hint="Checks if the user is logged in.">
		<cfargument name="loggedIn" type="boolean" required="true" />
		
		<cfset var scope = StructGet(getProperty("sessionManagementScope")) />
		
		<cfset scope._MachIIDashboard_loginStatus = arguments.loggedIn />
	</cffunction>
	
	<cffunction name="isProtectedEvent" access="private" returntype="boolean" output="false"
		hint="Checks if the passed event is protected and requires login.">
		<cfargument name="requestEventName" type="string" required="true" />
		
		<cfset var unprotectedEvents = getUnprotectedEvents() />
		<cfset var i = "" />
		<cfset var result = true />
		
		<cfloop from="1" to="#ArrayLen(unprotectedEvents)#" index="i">
			<cfif arguments.requestEventName EQ unprotectedEvents[i]>
				<cfset result = false />
				<cfbreak />
			</cfif>
		</cfloop>
		
		<cfreturn result />
	</cffunction>
	
	<!---
	ACCESSORS
	--->
	<cffunction name="setUnprotectedEvents" access="private" returntype="void" output="false">
		<cfargument name="unprotectedEvents" type="array" required="true" />
		<cfset variables.unprotectedEvents = arguments.unprotectedEvents />
	</cffunction>
	<cffunction name="getUnprotectedEvents" access="private" returntype="array" output="false">
		<cfreturn variables.unprotectedEvents />
	</cffunction>

</cfcomponent>