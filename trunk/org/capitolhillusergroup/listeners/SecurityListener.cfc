<cfcomponent displayname="SecurityListener" output="false" extends="MachII.framework.Listener" hint="Security Listener for CHUG">
	
	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- do nothing for now --->
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setSecurityService" access="public" output="false" returntype="void">
		<cfargument name="securityService" type="org.capitolhillusergroup.security.SecurityService" required="true" />
		<cfset variables.securityService = arguments.securityService />
	</cffunction>
	<cffunction name="getSecurityService" access="public" output="false" returntype="org.capitolhillusergroup.security.SecurityService">
		<cfreturn variables.securityService />
	</cffunction>
	
	<!--- listener methods --->
	<cffunction name="validateLoginAttempt" access="public" output="false" returntype="void" hint="Validates a login attempt and announces the next event">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var user = getSecurityService().authenticate(arguments.event.getArg("email"), arguments.event.getArg("password")) />
		<cfset var exitEvent = "failure" />
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("loginfailedmessage") />
		
		<cfif getSecurityService().isAuthenticated()>
			<cfif getSecurityService().getAuthenticationType() is "admin">
				<cfset exitEvent = "admin.showMainMenu_redirect" />
			<cfelseif getSecurityService().getAuthenticationType() is "member">
				<cfset exitEvent="member.showMainMenu_redirect" />
			</cfif>
			<cfset message = "" />
		</cfif>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="processForgotPassword" access="public" output="false" returntype="void" hint="Validates a user email and sends an email">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var user = getSecurityService().forgotPassword(arguments.event.getArg("email")) />
		<cfset var exitEvent = "failure" />
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("forgotpasswordfailed") />
		
		<cfif user.getPersonID() is not "" AND user.getAudit().getIsActive()>
			<cfset exitEvent = "forgotpassword_redirect" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("forgotpasswordsuccessful") />
		</cfif>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="logout" access="public" output="false" returntype="void" hint="Kills the user session">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset getSecurityService().removeUserSession() />
		<cfset arguments.event.setArg("message", getProperty("resourceBundleService").getResourceBundle().getResource("logoutmessage")) />
	</cffunction>
	
</cfcomponent>