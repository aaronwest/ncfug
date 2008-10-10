<cfset photos = event.getArg("photos", queryNew("id")) />
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/photoMenu.cfm" />