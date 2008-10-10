<cfcomponent 
	displayname="ContactListener" 
	output="false" 
	extends="MachII.framework.Listener">

	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- don't need anything here for now --->
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setContactService" access="public" output="false" returntype="void">
		<cfargument name="contactService" type="org.capitolhillusergroup.contact.ContactService" required="true" />
		<cfset variables.contactService = arguments.contactService />
	</cffunction>
	<cffunction name="getContactService" access="public" output="false" returntype="org.capitolhillusergroup.contact.ContactService">
		<cfreturn variables.contactService />
	</cffunction>
	
	<!--- listener methods --->
	<cffunction name="processContactForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var emailSubject = getProperty("resourceBundleService").getResourceBundle().getResource("contactformsubmission") & " - " &
									getProperty("siteName") />
		<cfset var nextEvent = "success" />
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("contactformsuccessmessage") />
		
		<cftry>
			<cfif getProperty("useCaptcha") AND ARGUMENTS.event.isArgDefined("captchaMessage")>
				<cfset nextEvent =  "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("captchafail") />
			<cfelse>	
				<cfset getContactService().sendContactFormViaEmail(arguments.event.getArg("contact"),getProperty("contactEmail"),emailSubject,getProperty("emailServer")) />
			</cfif>
			
			<cfcatch type="any">
				<cfset nextEvent =  "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("contactformerrormessage") />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(nextEvent, arguments.event.getArgs()) />
	</cffunction>
</cfcomponent>