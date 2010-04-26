<cfcomponent 
	displayname="PhotoDAO_MySQL" 
	output="false" 
	extends="PhotoDAO" 
	hint="PhotoDAO - MySQL">

	<cffunction name="init" access="public" output="false" returntype="PhotoDAO" hint="Constructor for this CFC.">
		<cfreturn this />
	</cffunction>

	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates a photo bean">
		<cfargument name="photo" type="Photo" required="true" />
		
		<cfset var getPhoto = 0 />
		<cfset var dtModified = createDate(1900, 1, 1) />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		
		<cftry>
			<cfquery name="getPhoto" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	photo.photo_id, 
						photo.title, 
						photo.caption, 
						photo.file_name, 
						photo.created_by_id, 
						photo.dt_created, 
						photo.ip_created, 
						photo.modified_by_id, 
						photo.dt_modified, 
						photo.ip_modified, 
						photo.is_active,
						cb.first_name AS cbfn, 
						cb.last_name AS cbln, 
						mb.first_name AS mbfn, 
						mb.last_name AS mbln 
				FROM 	photo 
				LEFT OUTER JOIN person AS cb 
					ON photo.created_by_id = cb.person_id 
				LEFT OUTER JOIN person AS mb 
					ON photo.modified_by_id = mb.person_id 
				WHERE 	photo.photo_id = <cfqueryparam value="#arguments.photo.getPhotoID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getPhoto.recordCount eq 1>
			<cfif getPhoto.dt_modified is not "">
				<cfset dtModified = getPhoto.dt_modified />
			</cfif>
			
			<cfset audit.init(getPhoto.created_by_id, getPhoto.cbfn & " " & getPhoto.cbln, getPhoto.dt_created, getPhoto.ip_created, 
								getPhoto.modified_by_id, getPhoto.mbfn & " " & getPhoto.mbln, dtModified, getPhoto.ip_modified, 
								getPhoto.is_active) />
			
			<cfset arguments.photo.init(getPhoto.photo_id, getPhoto.title, getPhoto.caption, getPhoto.file_name, audit) />
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves a photo">
		<cfargument name="photo" type="Photo" required="true" />
		
		<cfif arguments.photo.getPhotoID() is "">
			<cfset arguments.photo.setPhotoID(createUUID()) />
			<cfset create(arguments.photo) />
		<cfelse>
			<cfset update(arguments.photo) />
		</cfif>
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new photo">
		<cfargument name="photo" type="Photo" required="true" />
		
		<cfset var insertPhoto = 0 />
		
		<cftry>
			<cfquery name="insertPhoto" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				INSERT INTO photo (
					photo_id, 
					title, 
					caption, 
					file_name, 
					created_by_id, 
					dt_created, 
					ip_created, 
					is_active
				) VALUES (
					<cfqueryparam value="#arguments.photo.getPhotoID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.photo.getTitle()#" cfsqltype="cf_sql_varchar" maxlength="250" />, 
					<cfqueryparam value="#arguments.photo.getCaption()#" cfsqltype="cf_sql_varchar" maxlength="500" 
									null="#not len(arguments.photo.getCaption())#" />, 
					<cfqueryparam value="#arguments.photo.getFileName()#" cfsqltype="cf_sql_varchar" maxlength="500" />, 
					<cfqueryparam value="#arguments.photo.getAudit().getCreatedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.photo.getAudit().getDTCreated()#" cfsqltype="cf_sql_bigint" />, 
					<cfqueryparam value="#arguments.photo.getAudit().getIPCreated()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
					<cfqueryparam value="#arguments.photo.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
				)
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates a photo">
		<cfargument name="photo" type="Photo" required="true" />
		
		<cfset var updatePhoto = 0 />
		
		<cftry>
			<cfquery name="updatePhoto" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				UPDATE 	photo 
				SET 	title = <cfqueryparam value="#arguments.photo.getTitle()#" cfsqltype="cf_sql_varchar" maxlength="250" />, 
						caption = <cfqueryparam value="#arguments.photo.getCaption()#" cfsqltype="cf_sql_varchar" maxlength="500" 
												null="#not len(arguments.photo.getCaption())#" />, 
						file_name = <cfqueryparam value="#arguments.photo.getFileName()#" cfsqltype="cf_sql_varchar" maxlength="500" />, 
						modified_by_id = <cfqueryparam value="#arguments.photo.getAudit().getModifiedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						dt_modified = <cfqueryparam value="#arguments.photo.getAudit().getDTModified()#" cfsqltype="cf_sql_bigint" />, 
						ip_modified = <cfqueryparam value="#arguments.photo.getAudit().getIPModified()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
						is_active = <cfqueryparam value="#arguments.photo.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
				WHERE 	photo_id = <cfqueryparam value="#arguments.photo.getPhotoID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes a photo">
		<cfargument name="photo" type="Photo" required="true" />
		
		<cfset var deleteFromPhotoAlbum = 0 />
		<cfset var deletePhoto = 0 />
		<cfset var error = false />
		
		<cftransaction action="begin">
			<cftry>
				<cfquery name="deleteFromPhotoAlbum" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM photo_album_photo 
					WHERE photo_id = <cfqueryparam value="#arguments.photo.getPhotoID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfset error = true />
				</cfcatch>
			</cftry>
			
			<cftry>
				<cfquery name="deletePhoto" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM photo 
					WHERE photo_id = <cfqueryparam value="#arguments.photo.getPhotoID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfset error = true />
				</cfcatch>
			</cftry>
			
			<cfif error>
				<cftransaction action="rollback" />
			<cfelse>
				<cftransaction action="commit" />
			</cfif>
		</cftransaction>
	</cffunction>
	
</cfcomponent>