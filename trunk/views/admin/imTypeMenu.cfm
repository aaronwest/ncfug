<cfset imTypes = event.getArg("imTypes", queryNew("id")) />
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/imTypeMenu.cfm" />