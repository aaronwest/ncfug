<cfsilent>
	<cfset meetings = event.getArg("meetings") />
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/meetings.cfm" />