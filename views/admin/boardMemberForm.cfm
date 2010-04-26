<cfset boardPositions = event.getArg("boardPositions", queryNew("id")) />
<cfset members = event.getArg("members", queryNew("id")) />
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/boardMemberForm.cfm" />