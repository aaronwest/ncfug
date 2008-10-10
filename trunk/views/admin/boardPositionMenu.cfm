<cfset boardPositions = event.getArg("boardPositions", queryNew("id")) />
<cfset boardMembers = event.getArg("boardMembers", queryNew("id")) />
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/boardPositionMenu.cfm" />