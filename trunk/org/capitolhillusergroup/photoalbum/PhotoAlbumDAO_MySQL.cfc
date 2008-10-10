<cfcomponent 
	displayname="PhotoAlbumDAO_MySQL" 
	output="false" 
	extends="PhotoAlbumDAO" 
	hint="PhotoAlbumDAO - MySQL">

	<cffunction name="init" access="public" output="false" returntype="PhotoAlbumDAO" hint="Constructor for this CFC.">
		<cfreturn this />
	</cffunction>

	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates a photo album bean">
		<cfargument name="photoAlbum" type="PhotoAlbum" required="true" />
		
		<cfset var getPhotoAlbum = 0 />
		<cfset var dtModified = createDate(1900, 1, 1) />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var photos = 0 />
		
		<cftry>
			<cfquery name="getPhotoAlbum" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	photo_album.photo_album_id, 
						photo_album.title, 
						photo_album.description, 
						photo_album.created_by_id, 
						photo_album.dt_created, 
						photo_album.ip_created, 
						photo_album.modified_by_id, 
						photo_album.dt_modified, 
						photo_album.ip_modified, 
						photo_album.is_active, 
						cb.first_name AS cbfn, 
						cb.last_name AS cbln, 
						mb.first_name AS mbfn, 
						mb.last_name AS mbln 
				FROM 	photo_album 
				LEFT OUTER JOIN person AS cb 
					ON photo_album.created_by_id = cb.person_id 
				LEFT OUTER JOIN person AS mb 
					ON photo_album.modified_by_id = mb.person_id 
				WHERE 	photo_album.photo_album_id = <cfqueryparam value="#arguments.photoAlbum.getPhotoAlbumID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getPhotoAlbum.recordCount eq 1>
			<cfif getPhotoAlbum.dt_modified is not "">
				<cfset dtModified = getPhotoAlbum.dt_modified />
			</cfif>
			
			<!--- <cfset photos = getPhotoService().getPhotosByPhotoAlbumID(arguments.photoAlbum.getPhotoAlbumID()) /> --->
			<cfset photos = QueryNew("photo_id")>
			<cfset audit.init(getPhotoAlbum.created_by_id, getPhotoAlbum.cbfn & " " & getPhotoAlbum.cbln, getPhotoAlbum.dt_created, getPhotoAlbum.ip_created, 
								getPhotoAlbum.modified_by_id, getPhotoAlbum.mbfn & " " & getPhotoAlbum.mbln, dtModified, getPhotoAlbum.ip_modified, 
								getPhotoAlbum.is_active) />
			
			<cfset arguments.photoAlbum.init(getPhotoAlbum.photo_album_id, getPhotoAlbum.title, getPhotoAlbum.description, photos, audit) />
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves a photo album">
		<cfargument name="photoAlbum" type="PhotoAlbum" required="true" />
		
		<cfif arguments.photoAlbum.getPhotoAlbumID() is "">
			<cfset arguments.photoAlbum.setPhotoAlbumID(createUUID()) />
			<cfset create(arguments.photoAlbum) />
		<cfelse>
			<cfset update(arguments.photoAlbum) />
		</cfif>
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new photo album">
		<cfargument name="photoAlbum" type="PhotoAlbum" required="true" />
		
		<cfset var insertPhotoAlbum = 0 />
		
		<cftry>
			<cfquery name="insertPhotoAlbum" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				INSERT INTO photo_album (
					photo_album_id, 
					title, 
					description, 
					created_by_id, 
					dt_created, 
					ip_created, 
					is_active
				) VALUES (
					<cfqueryparam value="#arguments.photoAlbum.getPhotoAlbumID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.photoAlbum.getTitle()#" cfsqltype="cf_sql_varchar" maxlength="250" />, 
					<cfqueryparam value="#arguments.photoAlbum.getDescription()#" cfsqltype="cf_sql_varchar" maxlength="500" 
										null="#not len(arguments.photoAlbum.getDescription())#" />, 
					<cfqueryparam value="#arguments.photoAlbum.getAudit().getCreatedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.photoAlbum.getAudit().getDTCreated()#" cfsqltype="cf_sql_bigint" />, 
					<cfqueryparam value="#arguments.photoAlbum.getAudit().getIPCreated()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
					<cfqueryparam value="#arguments.photoAlbum.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
				)
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates a photo album">
		<cfargument name="photoAlbum" type="PhotoAlbum" required="true" />
		
		<cfset var updatePhotoAlbum = 0 />
		
		<cftry>
			<cfquery name="updatePhotoAlbum" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				UPDATE 	photo_album 
				SET		title = <cfqueryparam value="#arguments.photoAlbum.getTitle()#" cfsqltype="cf_sql_varchar" maxlength="250" />, 
						description = <cfqueryparam value="#arguments.photoAlbum.getDescription()#" cfsqltype="cf_sql_varchar" maxlength="500" 
													null="#not len(arguments.photoAlbum.getDescription())#" />, 
						modified_by_id = <cfqueryparam value="#arguments.photoAlbum.getAudit().getModifiedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						dt_modified = <cfqueryparam value="#arguments.photoAlbum.getAudit().getDTModified()#" cfsqltype="cf_sql_bigint" />, 
						ip_modified = <cfqueryparam value="#arguments.photoAlbum.getAudit().getIPModified()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
						is_active = <cfqueryparam value="#arguments.photoAlbum.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" /> 
				WHERE	photo_album_id = <cfqueryparam value="#arguments.photoAlbum.getPhotoAlbumID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes a photo album">
		<cfargument name="photoAlbum" type="PhotoAlbum" required="true" />
		
		<cfset var deletePhotos = 0 />
		<cfset var deletePhotoAlbum = 0 />
		<cfset var error = false />
		
		<cftransaction action="begin">
			<cftry>
				<cfquery name="deletePhotos" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM photo_album_photo 
					WHERE photo_album_id = <cfqueryparam value="#arguments.photoAlbum.getPhotoAlbumID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfset error = true />
				</cfcatch>
			</cftry>
			
			<cftry>
				<cfquery name="deletePhotos" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM photo_album 
					WHERE photo_album_id = <cfqueryparam value="#arguments.photoAlbum.getPhotoAlbumID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfset error = true />
				</cfcatch>
			</cftry>
			
			<cfif error>
				<cftransaction action="rollback" />
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			<cfelse>
				<cftransaction action="commit" />
			</cfif>
		</cftransaction>
	</cffunction>
	
</cfcomponent>