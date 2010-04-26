<cfset people = event.getArg("people", queryNew("id")) />
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/peopleMenu.cfm" />