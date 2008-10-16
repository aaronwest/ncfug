<cfcomponent 
	displayname="RSVPListener" 
	output="false" 
	extends="MachII.framework.Listener">

	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- don't need anything here for now --->
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
	
	<cffunction name="setPersonService" access="public" output="false" returntype="void">
		<cfargument name="personService" type="org.capitolhillusergroup.person.PersonService" required="true" />
		<cfset variables.personService = arguments.personService />
	</cffunction>
	<cffunction name="getPersonService" access="public" output="false" returntype="org.capitolhillusergroup.person.PersonService">
		<cfreturn variables.personService />
	</cffunction>
	
	<cffunction name="setRSVPService" access="public" output="false" returntype="void">
		<cfargument name="rsvpService" type="org.capitolhillusergroup.rsvp.RSVPService" required="true" />
		<cfset variables.rsvpService = arguments.rsvpService />
	</cffunction>
	<cffunction name="getRSVPService" access="public" output="false" returntype="org.capitolhillusergroup.rsvp.RSVPService">
		<cfreturn variables.rsvpService />
	</cffunction>
	
	<cffunction name="setSessionService" access="public" output="false" returntype="void">
		<cfargument name="sessionService" type="org.capitolhillusergroup.session.SessionService" required="true" />
		<cfset variables.sessionService = arguments.sessionService />
	</cffunction>
	<cffunction name="getSessionService" access="public" output="false" returntype="org.capitolhillusergroup.session.SessionService">
		<cfreturn variables.sessionService />
	</cffunction>
	
	<!--- listener methods --->
	<cffunction name="getRSVPByID" access="public" output="false" returntype="org.capitolhillusergroup.rsvp.RSVP">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfreturn getRSVPService().getRSVPByID(arguments.event.getArg("rsvpID", "")) />
	</cffunction>
	
	<cffunction name="processRSVPForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var rsvp = arguments.event.getArg("rsvp") />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var message = "" />
		<cfset var action = "" />
		<cfset var exitEvent = "success" />
		
		<!--- check to see if this email address has already RSVPed for this meeting --->
		<cfif getProperty("useCaptcha") AND ARGUMENTS.event.isArgDefined("captchaMessage")>
			<cfset exitEvent = "failure" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("captchafail") />
		<cfelseif Len(Trim(rsvp.getRSVPID())) LTE 0 AND getRSVPService().rsvpExists(rsvp.getMeetingID(), rsvp.getEmail())>
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("youhavealreadyrsvped") />
		<cfelse>
			<!--- haven't already RSVPed, so save it --->
			<cfset audit.setIsActive(arguments.event.getArg("isActive", 1)) />
			
			<!--- if this person's email address is in the database, grab their person id --->
			<cfset rsvp.setPersonID(getPersonService().getPersonIDByEmail(rsvp.getEmail()))>
			
			<cfif Len(Trim(rsvp.getRSVPID())) GT 0>
				<cfset action = "add" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addrsvpsuccessful") />
				<cfif getSessionService().isAuthenticated()>
					<cfset audit.setCreatedByID(getSessionService().getUser().getPersonID()) />
				</cfif>
				<cfset audit.setDTCreated(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
				<cfset audit.setIPCreated(CGI.REMOTE_ADDR) />
			<cfelse>
				<cfset action = "update" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("updatersvpsuccessful") />
				<cfset audit.setModifiedByID(getSessionService().getUser().getPersonID()) />
				<cfset audit.setDTModified(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
				<cfset audit.setIPModified(CGI.REMOTE_ADDR) />
			</cfif>
			
			<cfset rsvp.setAudit(audit) />
			
			<cftry>
				<cfset getRSVPService().saveRSVP(rsvp) />
				<cfcatch type="any">
					<cfset exitEvent = "failure" />
					<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addupdatersvpfailed") />
					<cfif action is "add">
						<cfset rsvp.setRSVPID("") />
					</cfif>
					<cfset arguments.event.setArg("rsvp", rsvp) />
				</cfcatch>
			</cftry>
		</cfif>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset arguments.event.setArg("meetingID", rsvp.getMeetingID()) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="processRSVPNotificationForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var email = getEmailService().getEmailBean() />
		<cfset var rsvps = arguments.event.getArg("rsvps") />
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("emailrsvpssucceeded") />
		
		<cfset email.setFromEmail(getProperty("contactName") & "<" & getProperty("notificationFromAddress") & ">") />
		<cfset email.setBccEmail(getProperty("contactEmail")) />
		<cfset email.setSubject(arguments.event.getArg("subject")) />
		<cfset email.setEmailType("html")>
		<cfset email.setBody(arguments.event.getArg("emailBody")) />
		
		<cftry>
			<cfset getNotificationService().sendEmailUsingRecipientQuery(email, rsvps) />
			<cfcatch type="any">
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("emailrsvpsfailed") />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		
		<cfset announceEvent("admin.showRSVPs", arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="getRSVPsByMeetingID" access="public" output="false" returntype="query">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getRSVPService().getRSVPsByMeetingID(arguments.event.getArg("meetingID")) />
	</cffunction>
	
	<cffunction name="deleteRSVP" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("rsvpdeletesucceeded") />
		
		<cftry>
			<cfset getRSVPService().deleteRSVP(arguments.event.getArg("rsvp")) />
			<cfcatch type="any">
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("rsvpdeletefailed") />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset arguments.event.setArg("meetingID", arguments.event.getArg("rsvp").getMeetingID()) />
		<cfset arguments.event.removeArg("rsvp") />
		
		<cfset announceEvent("admin.showRSVPs", arguments.event.getArgs()) />
	</cffunction>

</cfcomponent>