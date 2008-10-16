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
	<cffunction name="setEmailService" access="public" output="false" returntype="void">
		<cfargument name="emailService" type="org.capitolhillusergroup.email.EmailService" required="true" />
		<cfset variables.emailService = arguments.emailService />
	</cffunction>
	<cffunction name="getEmailService" access="public" output="false" returntype="org.capitolhillusergroup.email.EmailService">
		<cfreturn variables.emailService />
	</cffunction>
	<cffunction name="setNotificationService" access="public" output="false" returntype="void">
		<cfargument name="notificationService" type="org.capitolhillusergroup.notification.NotificationService" required="true" />
		<cfset variables.notificationService = arguments.notificationService />
	</cffunction>
	<cffunction name="getNotificationService" access="public" output="false" returntype="org.capitolhillusergroup.notification.NotificationService">
		<cfreturn variables.notificationService />
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
		<cfset var email = getEmailService().getEmailBean() />
		
		<cfif user.getPersonID() is not "" AND user.getAudit().getIsActive()>
			<!--- ASW: 10.15.2008 Adding the e-mail sending portion as if was magically left out in the original chug app. --->
			<cfset email.setFromEmail(getProperty("contactName") & "<" & getProperty("notificationFromAddress") & ">") />
			<cfset email.setToEmail(user.getEmail()) />
			<cfset email.setSubject("Forgotten Password for site: " & getProperty("siteName")) />
			<cfset email.setBody("Oooh snap! You forgot your password for site: " & getProperty("siteName") & ". Well, here it is: " & user.getPassword()) />
			
			<cfset getNotificationService().sendEmail(email) />
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