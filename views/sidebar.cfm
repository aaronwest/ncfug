<cfsilent>
	<cfset news = event.getArg("news") />
	<cfset upcomingMeetings = event.getArg("upcomingMeetings") />
	<cfset previousMeetings = event.getArg("previousMeetings") />
	<cfif arrayLen(upcomingMeetings) gt 0>
		<cfset nextMeeting = upcomingMeetings[1] />
	</cfif>
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/#getProperty('skin')#/sidebar.cfm" />