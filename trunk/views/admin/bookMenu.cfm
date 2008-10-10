<cfset books = event.getArg("books", queryNew("id")) />
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/bookMenu.cfm" />