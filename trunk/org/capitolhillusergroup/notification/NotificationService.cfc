<cfcomponent displayname="NotificationService" output="false" hint="Performs all notifications.">

	<cffunction name="init" access="public" returntype="NotificationService" output="false"
		hint="Initializes the service.">	
		<cfreturn this />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="sendEmailUsingRecipientQuery" access="public" output="false" returntype="void">
		<cfargument name="email" type="org.capitolhillusergroup.email.Email" required="true" />
		<cfargument name="recipients" type="query" required="true" />
		
		<cfloop query="arguments.recipients">
			<cfset arguments.email.setToEmail(arguments.recipients.email) />
			<cfset sendEmail(email) />
		</cfloop>
		
	</cffunction>
	
	<cffunction name="sendEmail" access="public" output="false" returntype="void" 
			hint="Sends an email using the EmailBean passed in">
		<cfargument name="email" type="org.capitolhillusergroup.email.Email" required="true" />
		<cftry>
		<cfmail from="#arguments.email.getFromEmail()#" 
				to="#arguments.email.getToEmail()#" 
				subject="#arguments.email.getSubject()#" 
				cc="#arguments.email.getCcEmail()#" 
				bcc="#arguments.email.getBccEmail()#" 
				replyto="#arguments.email.getReplyToEmail()#"
				type="#arguments.email.getEmailType()#">
#arguments.email.getBody()#
		</cfmail>
		<cfcatch type="any">
		</cfcatch>
		</cftry>
	</cffunction>
	
</cfcomponent>