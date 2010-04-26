<cfset locations = event.getArg("locations", queryNew("id")) />
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/locationMenu.cfm" />