<cfsilent>
	<cfset boardMembers = event.getArg("boardMembers") />
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/board.cfm" />
