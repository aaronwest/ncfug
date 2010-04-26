<cfsilent>
	<cfset role = event.getArg("role") />
	
	<cfif role.getRoleID() is "">
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("addrole") />
	<cfelse>
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("updaterole") />
	</cfif>
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/roleForm.cfm" />