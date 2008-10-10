<cfsilent>
	<cfset welcome = event.getArg("welcome",ArrayNew(1)) />
	<cfset upcomingMeetings = event.getArg("upcomingMeetings",ArrayNew(1)) />
	<cfif ArrayLen(upcomingMeetings) gt 0>
		<cfset nextMeeting = upcomingMeetings[1] />
	</cfif>
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/#getProperty('skin')#/home.cfm" />