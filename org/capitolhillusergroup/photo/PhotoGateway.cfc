<cfcomponent 
	displayname="PhotoGateway" 
	output="false" 
	hint="Base PhotoGateway">
	
	<cffunction name="init" access="public" output="false" returntype="PhotoGateway">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setDatasource" access="public" output="false" returntype="void"
		hint="Dependency: injected">
		<cfargument name="datasource" type="org.capitolhillusergroup.datasource.Datasource" required="true" />
		<cfset variables.datasource = arguments.datasource />
	</cffunction>	
	<cffunction name="getDatasource" access="private" output="false" returntype="org.capitolhillusergroup.datasource.Datasource">
		<cfreturn variables.datasource />
	</cffunction>
	
	<!--- gateway methods --->
	<cffunction name="getPhotosByPhotoAlbumID" access="public" output="false" returntype="query">
		<cfargument name="photoAlbumID" type="uuid" required="true" />
		
		<cfset var photos = 0 />
		
		<cftry>
			<cfquery name="photos" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	photo_album_photo.photo_id 
						photo.title, 
						photo.caption, 
						photo.file_name, 
						photo.created_by_id, 
						photo.dt_created, 
						photo.ip_created, 
						photo.modified_by_id, 
						photo.dt_modified, 
						photo.ip_modified, 
						photo.is_active 
						cb.first_name AS cbfn, 
						cb.last_name AS cbln, 
						mb.first_name AS mbfn, 
						mb.last_name AS mbln 
				FROM 	photo_album 
				INNER JOIN photo ON photo_album.photo_id = photo.photo_id 
				LEFT OUTER JOIN person AS cb ON photo.created_by_id = cb.person_id 
				LEFT OUTER JOIN person AS mb ON photo.modified_by_id = mb.person_id 
				WHERE 	photo_album.photo_album_id = <cfqueryparam value="#arguments.photoAlbumID#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn photos />
	</cffunction>
	
</cfcomponent>