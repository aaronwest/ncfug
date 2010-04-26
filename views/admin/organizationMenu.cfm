<cfset organizations = event.getArg("organizations", queryNew("id")) />
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/organizationMenu.cfm" />