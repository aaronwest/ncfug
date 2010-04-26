<cfcomponent 
	displayname="PhotoAlbumService" 
	output="false" 
	hint="PhotoAlbumService">

	<cffunction name="init" access="public" output="false" returntype="PhotoAlbumService">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setPhotoAlbumDAO" access="public" output="false" returntype="void">
		<cfargument name="photoAlbumDAO" type="PhotoAlbumDAO" required="true" />
		<cfset variables.photoAlbumDAO = arguments.photoAlbumDAO />
	</cffunction>
	<cffunction name="getPhotoAlbumDAO" access="public" output="false" returntype="PhotoAlbumDAO">
		<cfreturn variables.photoAlbumDAO />
	</cffunction>
	
	<cffunction name="setPhotoAlbumGateway" access="public" output="false" returntype="void">
		<cfargument name="photoAlbumGateway" type="PhotoAlbumGateway" required="true" />
		<cfset variables.photoAlbumGateway = arguments.photoAlbumGateway />
	</cffunction>
	<cffunction name="getPhotoAlbumGateway" access="public" output="false" returntype="PhotoAlbumGateway">
		<cfreturn variables.photoAlbumGateway />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getPhotoAlbumBean" access="public" output="false" returntype="PhotoAlbum">
		<cfreturn createObject("component", "PhotoAlbum").init() />
	</cffunction>
	<cffunction name="getPhotoAlbums" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		
		<cfreturn getPhotoAlbumGateway().getPhotoAlbums(arguments.activeOnly) />
	</cffunction>

	<cffunction name="getPhotoAlbumByID" access="public" output="false" returntype="PhotoAlbum">
		<cfargument name="photoAlbumID" type="string" required="true" />
		
		<cfset var album = getPhotoAlbumBean() />
		<cfset album.setPhotoAlbumID(arguments.photoAlbumID) />
		
		<cfif arguments.photoAlbumID is not "">
			<cfset getPhotoAlbumDAO().fetch(album) />
		</cfif>
		
		<cfreturn album />
	</cffunction>
	
	<cffunction name="savePhotoAlbum" access="public" output="false" returntype="void">
		<cfargument name="photoAlbum" type="PhotoAlbum" required="true" />
		
		<cfset getPhotoAlbumDAO().save(arguments.photoAlbum) />
	</cffunction>
	
	<cffunction name="deletePhotoAlbum" access="public" output="false" returntype="void">
		<cfargument name="photoAlbum" type="PhotoAlbum" required="true" />
		
		<cfset getPhotoAlbumDAO().delete(arguments.photoAlbum) />
	</cffunction>
</cfcomponent>