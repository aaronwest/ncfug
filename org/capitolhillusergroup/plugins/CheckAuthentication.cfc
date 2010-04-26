<cfcomponent 
		displayname="CheckAuthentication" 
		output="false" 
		extends="MachII.framework.Plugin">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
			hint="Configures the plugin.">
	</cffunction>
	
	<cffunction name="setSecurityService" access="public" output="false" returntype="void"
			hint="Dependency: injected">
		<cfargument name="securityService" type="org.capitolhillusergroup.security.SecurityService" required="true" />
		<cfset variables.securityService = arguments.securityService />
	</cffunction>
	<cffunction name="getSecurityService" access="public" output="false" returntype="org.capitolhillusergroup.security.SecurityService">
		<cfreturn variables.securityService />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="preProcess" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		
		<!--- since we're in preProcess we need to get the name of the first event --->
		<cfset var firstEvent = arguments.eventContext.getNextEvent() />
		<!--- struct to hold any data we may need to pass along to the next event --->
		<cfset var eventArgs = structNew() />
		
		<!--- set authentication type --->
		<cfset firstEvent.setArg("authType", getSecurityService().getAuthenticationType()) />
		
		<!--- handle admin events --->
		<cfif listFirst(firstEvent.getName(), ".") is "admin" and firstEvent.getArg("authType") is not "admin">
			<!--- not an admin user; clear the event queue and route them to the home page --->
			<cfset eventArgs.authType = getSecurityService().getAuthenticationType() />
			<cfset arguments.eventContext.clearEventQueue() />
			<cfset eventArgs.message = getProperty("resourceBundleService").getResourceBundle().getResource("notadminerror") />
			<cfset arguments.eventContext.announceEvent("showHome", eventArgs) />
		<!--- handle other events--the only publicly-accessible page is the home page and login pages --->
		<cfelseif listFirst(firstEvent.getName(), ".") is "member" and firstEvent.getArg("authType") is "none">
			<!--- user is trying to hit a non-public event and they aren't logged in --->
			<cfset eventArgs.authType = "none" />
			<cfset arguments.eventContext.clearEventQueue() />
			<cfset eventArgs.message = getProperty("resourceBundleService").getResourceBundle().getResource("notloggedinerror") />
			<cfset arguments.eventContext.announceEvent("showHome", eventArgs) />
		</cfif>
		
	</cffunction>
	
	<!--- <cffunction name="preEvent" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
	</cffunction>
	
	<cffunction name="postEvent" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
	</cffunction>
	
	<cffunction name="preView" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
	</cffunction>
	
	<cffunction name="postView" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
	</cffunction>
	
	<cffunction name="postProcess" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
	</cffunction> --->
	
	<cffunction name="handleException" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfargument name="exception" type="MachII.util.Exception" required="true" />
	</cffunction>

</cfcomponent>