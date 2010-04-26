<cfset photoalbums = event.getArg("photoAlbums", queryNew("id")) />
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/photoAlbumMenu.cfm" />