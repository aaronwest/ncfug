<cfcomponent 
	displayname="PhotoAlbumDAO" 
	output="false" 
	hint="Base PhotoAlbumDAO">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" output="false" returntype="PhotoAlbumDAO" hint="Constructor for this CFC.">
		<cfreturn this />
	</cffunction>

	<cffunction name="setDatasource" access="public" output="false" returntype="void"
		hint="Dependency: injected">
		<cfargument name="datasource" type="org.capitolhillusergroup.datasource.Datasource" required="true" />
		<cfset variables.datasource = arguments.datasource />
	</cffunction>	
	<cffunction name="getDatasource" access="private" output="false" returntype="org.capitolhillusergroup.datasource.Datasource">
		<cfreturn variables.datasource />
	</cffunction>
	
	<cffunction name="setPhotoService" access="public" output="false" returntype="void">
		<cfargument name="photoService" type="org.capitolhillusergroup.photo.PhotoService" required="true" />
		<cfset variables.photoService = arguments.photoService />
	</cffunction>
	<cffunction name="getPhotoService" access="public" output="false" returntype="org.capitolhillusergroup.photo.PhotoService">
		<cfreturn variables.photoService />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS - CRUD - DATABASE SPECIFIC OBJECTS THAT EXTEND THIS OBJECT MUST OVERRIDE THESE METHODS
	--->
	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates a photo album bean">
		<cfargument name="photoAlbum" type="PhotoAlbum" required="true" />
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves a photo album">
		<cfargument name="photoAlbum" type="PhotoAlbum" required="true" />
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new photo album">
		<cfargument name="photoAlbum" type="PhotoAlbum" required="true" />
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates a photo album">
		<cfargument name="photoAlbum" type="PhotoAlbum" required="true" />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes a photo album">
		<cfargument name="photoAlbum" type="PhotoAlbum" required="true" />
	</cffunction>
	
</cfcomponent>