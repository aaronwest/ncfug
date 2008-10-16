<cfcomponent displayname="ContactService" output="false" hint="ContactService for CHUG">

	<cffunction name="init" access="public" output="false" returntype="ContactService">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
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
	
	<!--- service methods --->
	<cffunction name="sendContactFormViaEmail" access="public" output="false" returntype="void">
		<cfargument name="contact" type="Contact" required="true" />
		<cfargument name="toEmail" type="string" required="true" />
		<cfargument name="emailSubject" type="string" required="true" />
		
		<cfset var email = getEmailService().getEmailBean() />
		
		<cfset email.setFromEmail("#arguments.contact.getName()# <#arguments.contact.getEmail()#>") />
		<cfset email.setToEmail(arguments.toEmail) />
		<cfset email.setSubject(arguments.emailSubject) />
		<cfset email.setEmailType("html")>
		<cfset email.setBody("Contact reason:<br/>" & arguments.contact.getReason() & "<br/><br/>" & "Comments:<br/>" & arguments.contact.getComments()) />
		
		<cfset getNotificationService().sendEmail(email) />
	</cffunction>
	
</cfcomponent>