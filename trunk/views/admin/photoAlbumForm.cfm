<cfsilent>
	<cfset photoalbum = event.getArg("photoalbum") />
	
	<cfif photoalbum.getPhotoAlbumID() is "">
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("addnewphotoalbum") />
	<cfelse>
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("updatephotoalbum") />
	</cfif>
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/photoAlbumForm.cfm" />