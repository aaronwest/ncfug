<cfcomponent 
	displayname="MeetingListener" 
	output="false" 
	extends="MachII.framework.Listener">

	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- don't need anything here for now --->
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setMeetingService" access="public" output="false" returntype="void">
		<cfargument name="meetingService" type="org.capitolhillusergroup.meeting.MeetingService" required="true" />
		<cfset variables.meetingService = arguments.meetingService />
	</cffunction>
	<cffunction name="getMeetingService" access="public" output="false" returntype="org.capitolhillusergroup.meeting.MeetingService">
		<cfreturn variables.meetingService />
	</cffunction>
	
	<cffunction name="setPresentationService" access="public" output="false" returntype="void">
		<cfargument name="presentationService" type="org.capitolhillusergroup.presentation.PresentationService" required="true" />
		<cfset variables.presentationService = arguments.presentationService />
	</cffunction>
	<cffunction name="getPresentationService" access="public" output="false" returntype="org.capitolhillusergroup.presentation.PresentationService">
		<cfreturn variables.presentationService />
	</cffunction>
	
	<cffunction name="setSessionService" access="public" output="false" returntype="void">
		<cfargument name="sessionService" type="org.capitolhillusergroup.session.SessionService" required="true" />
		<cfset variables.sessionService = arguments.sessionService />
	</cffunction>
	<cffunction name="getSessionService" access="public" output="false" returntype="org.capitolhillusergroup.session.SessionService">
		<cfreturn variables.sessionService />
	</cffunction>
	
	<!--- listener methods --->
	<cffunction name="getMeetings" access="public" output="false" returntype="query">
		<cfreturn getMeetingService().getMeetings() />
	</cffunction>
	
	<cffunction name="getActiveMeetingsAsArray" access="public" output="false" returntype="array">
		<cfreturn getMeetingService().getActiveMeetingsAsArray() />
	</cffunction>
	
	<cffunction name="getUpcomingMeetings" access="public" output="false" returntype="array">
		
		<cfset var numToGet = getProperty("numUpcomingMeetingItems",-1)>
		<cfset var meetings = ArrayNew(1)>
		
		<cfset meetings = getMeetingService().getUpcomingMeetings( numToGet ) />
		
		<cfreturn meetings>
	</cffunction>
	
	<cffunction name="getPreviousMeetings" access="public" output="false" returntype="array">
		
		<cfset var numToGet = getProperty("numPreviousMeetingItems",-1)>
		<cfset var meetings = ArrayNew(1)>
		
		<cfif numToGet GT 0>
			<cfset meetings = getMeetingService().getPreviousMeetings( numToGet ) />
		</cfif>
		
		<cfreturn meetings>
	</cffunction>
	
	<cffunction name="getMeetingByID" access="public" output="false" returntype="org.capitolhillusergroup.meeting.Meeting">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getMeetingService().getMeetingByID(arguments.event.getArg("meetingID", "")) />
	</cffunction>
	
	<cffunction name="processMeetingForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var meeting = arguments.event.getArg("meeting") />
		<cfset var location = arguments.event.getArg("location") />
		<cfset var presentations = arrayNew(1) />
		<cfset var presentation = 0 />
		<cfset var presentationID = "" />
		<cfset var action = "" />
		<cfset var message = "" />
		<cfset var exitEvent = "success" />
		
		<cfset meeting.setLocation(location) />
		<cfset meeting.getAudit().setIsActive(arguments.event.getArg("isActive", 0)) />
		<cfset meeting.setDTMeeting(getProperty("resourceBundleService").getLocaleUtils().i18nDateTimeParse(arguments.event.getArg("dtMeeting"))) />
		
		<!--- get the presentations if needed --->
		<cfif arguments.event.getArg("presentationIDs", "") is not "">
			<cfloop list="#arguments.event.getArg('presentationIDs')#" index="presentationID">
				<cfset presentation = getPresentationService().getPresentationByID(presentationID) />
				<cfset arrayAppend(presentations, presentation) />
			</cfloop>
		</cfif>
		
		<cfset meeting.setPresentations(presentations) />
		
		<cfif meeting.getMeetingID() is "">
			<cfset action = "add" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addmeetingsuccessful") />
			<cfset meeting.getAudit().setCreatedByID(getSessionService().getUser().getPersonID()) />
			<cfset meeting.getAudit().setDTCreated(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset meeting.getAudit().setIPCreated(CGI.REMOTE_ADDR) />
		<cfelse>
			<cfset action = "update" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("updatemeetingsuccessful") />
			<cfset meeting.getAudit().setModifiedByID(getSessionService().getUser().getPersonID()) />
			<cfset meeting.getAudit().setDTModified(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset meeting.getAudit().setIPModified(CGI.REMOTE_ADDR) />
		</cfif>

		<cftry>
			<cfset getMeetingService().saveMeeting(meeting) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addupdatemeetingfailed") />
				
				<cfif action is "add">
					<cfset meeting.setMeetingID("") />
				</cfif>
				
				<cfset arguments.event.setArg("meeting", meeting) />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="deleteMeeting" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var exitEvent = "success" />
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("deletemeetingsuccessful") />
		<cfset var meeting = getMeetingService().getMeetingByID(arguments.event.getArg("meetingID")) />
		
		<cftry>
			<cfset getMeetingService().deleteMeeting(meeting) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("deletemeetingfailed") />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>

</cfcomponent>