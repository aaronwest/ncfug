<cfsilent>
	<cfset photo = event.getArg("photo") />
	
	<cfif photo.getPhotoID() is "">
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("addnewphoto") />
	<cfelse>
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("updatephoto") />
	</cfif>

</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/photoForm.cfm" />