<cfset news = event.getArg("news", queryNew("id")) />
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/newsMenu.cfm" />