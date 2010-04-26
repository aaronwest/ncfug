<cfcomponent 
	displayname="PhotoAlbumGateway_MySQL" 
	output="false" 
	extends="PhotoAlbumGateway" 
	hint="PhotoAlbumGateway - MySQL">
	
	<cffunction name="init" access="public" output="false" returntype="PhotoAlbumGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getPhotoAlbums" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		
		<cfset var photoAlbums = 0 />
		
		<cfquery name="photoAlbums" datasource="#getDatasource().getDSN()#" 
				username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
			SELECT 	photo_album_id
					, title
					, description
					, is_active
			FROM 	photo_album
			<cfif arguments.activeOnly>
			WHERE 	is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" /> 
			</cfif>
			ORDER BY title ASC
		</cfquery>
		
		<cfreturn photoAlbums />
	</cffunction>
	
</cfcomponent>