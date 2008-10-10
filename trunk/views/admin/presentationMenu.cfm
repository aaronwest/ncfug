<cfset presentations = event.getArg("presentations", queryNew("id")) />
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/presentationMenu.cfm" />