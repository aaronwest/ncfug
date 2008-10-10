<cfsilent>
	<cfset imType = event.getArg("imType") />
	
	<cfif imType.getIMTypeID() is "">
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("addnewimtype") />
	<cfelse>
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("updateimtype") />
	</cfif>
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/imTypeForm.cfm" />