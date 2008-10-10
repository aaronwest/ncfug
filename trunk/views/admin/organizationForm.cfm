<cfsilent>
	<cfset organization = event.getArg("organization") />
	
	<cfif organization.getOrganizationID() is "">
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("addorganization") />
	<cfelse>
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("updateorganization") />
	</cfif>
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/organizationForm.cfm" />