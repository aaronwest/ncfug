<cfset categories = event.getArg("categories", queryNew("id")) />
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/categoryMenu.cfm" />