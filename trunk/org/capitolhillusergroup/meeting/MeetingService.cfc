<cfcomponent 
	displayname="MeetingService" 
	output="false" 
	hint="MeetingService">

	<cffunction name="init" access="public" output="false" returntype="MeetingService">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setMeetingDAO" access="public" output="false" returntype="void">
		<cfargument name="meetingDAO" type="MeetingDAO" required="true" />
		<cfset variables.meetingDAO = arguments.meetingDAO />
	</cffunction>
	<cffunction name="getMeetingDAO" access="public" output="false" returntype="MeetingDAO">
		<cfreturn variables.meetingDAO />
	</cffunction>
	
	<cffunction name="setMeetingGateway" access="public" output="false" returntype="void">
		<cfargument name="meetingGateway" type="MeetingGateway" required="true" />
		<cfset variables.meetingGateway = arguments.meetingGateway />
	</cffunction>
	<cffunction name="getMeetingGateway" access="public" output="false" returntype="MeetingGateway">
		<cfreturn variables.meetingGateway />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getMeetingBean" access="public" output="false" returntype="Meeting">
		<cfreturn createObject("component", "Meeting").init() />
	</cffunction>

	<cffunction name="getMeetings" access="public" output="false" returntype="query">
		<cfreturn getMeetingGateway().getMeetings(false) />
	</cffunction>
	
	<cffunction name="getMeetingsAsArray" access="public" output="false" returntype="array">
		<cfreturn getMeetingGateway().getMeetingsAsArray(false) />
	</cffunction>
	
	<cffunction name="getActiveMeetings" access="public" output="false" returntype="query">
		<cfreturn getMeetingGateway().getMeetings(true) />
	</cffunction>
	
	<cffunction name="getActiveMeetingsAsArray" access="public" output="false" returntype="array">
		<cfreturn getMeetingGateway().getMeetingsAsArray(true) />
	</cffunction>
	
	<cffunction name="getAllMeetings" access="public" output="false" returntype="query">
		<cfreturn getMeetingGateway().getMeetings(false) />
	</cffunction>
	
	<cffunction name="getUpcomingMeetings" access="public" output="false" returntype="array">
		<cfargument name="numToGet" type="numeric" required="false" default="-1" />
		
		<cfreturn getMeetingGateway().getUpcomingMeetings( arguments.numToGet ) />
	</cffunction>
	
	<cffunction name="getPreviousMeetings" access="public" output="false" returntype="array">
		<cfargument name="numToGet" type="numeric" required="false" default="-1" />
		
		<cfreturn getMeetingGateway().getPreviousMeetings( arguments.numToGet ) />
	</cffunction>
	
	<cffunction name="getMeetingByID" access="public" output="false" returntype="Meeting">
		<cfargument name="meetingID" type="string" required="true" />
		
		<cfset var meeting = getMeetingBean() />
		<cfset meeting.setMeetingID(arguments.meetingID) />
		
		<cfif arguments.meetingID is not "">
			<cfset getMeetingDAO().fetch(meeting) />
		<cfelse>
			<cfset getMeetingDAO().fetchDefaults(meeting) />
		</cfif>
		
		<cfreturn meeting />
	</cffunction>
	
	<cffunction name="saveMeeting" access="public" output="false" returntype="void">
		<cfargument name="meeting" type="Meeting" required="true" />
		<cfset getMeetingDAO().save(arguments.meeting) />
	</cffunction>
	
	<cffunction name="deleteMeeting" access="public" output="false" returntype="void">
		<cfargument name="meeting" type="Meeting" required="true" />
		<cfset getMeetingDAO().delete(arguments.meeting) />
	</cffunction>
	
</cfcomponent>