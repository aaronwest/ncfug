<cfsilent>
	<cfset meeting = event.getArg("meeting") />
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/meeting.cfm" />