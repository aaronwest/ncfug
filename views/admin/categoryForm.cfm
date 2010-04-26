<cfsilent>
	<cfset category = event.getArg("category") />
	
	<cfif category.getCategoryID() is "">
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("addnewcategory") />
	<cfelse>
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("updatecategory") />
	</cfif>
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/categoryForm.cfm" />