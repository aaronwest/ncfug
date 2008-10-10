<cfset roles = event.getArg("roles", queryNew("id")) />
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/roleMenu.cfm" />