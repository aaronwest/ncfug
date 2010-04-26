<cfset articles = event.getArg("articles", queryNew("id")) />
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/articleMenu.cfm" />