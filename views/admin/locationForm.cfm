<cfsilent>
	<cfset location = event.getArg("location") />
	<cfset states = event.getArg("states") />
	
	<cfif location.getLocationID() is "">
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("addnewlocation") />
	<cfelse>
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("updatelocation") />
	</cfif>
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/locationForm.cfm" />