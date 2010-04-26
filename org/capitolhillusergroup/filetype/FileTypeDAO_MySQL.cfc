<cfcomponent 
	displayname="FileTypeDAO_MySQL" 
	output="false" 
	extends="FileTypeDAO" 
	hint="FileTypeDAO - MySQL">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" output="false" returntype="FileTypeDAO" hint="Constructor for this CFC.">
		<cfreturn this />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void" hint="Populates a fileType bean">
		<cfargument name="fileType" type="FileType" required="true" />
		
		<cfset var getFileType = 0 />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var dtModified = createDate(1900, 1, 1) />
		
		<cftry>
			<cfquery name="getFileType" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	file_type.file_type_id, 
						file_type.file_type, 
						file_type.file_extension, 
						file_type.created_by_id, 
						file_type.dt_created, 
						file_type.ip_created, 
						file_type.modified_by_id, 
						file_type.dt_modified, 
						file_type.ip_modified, 
						file_type.is_active, 
						cb.first_name AS cbfn, 
						cb.last_name AS cbln, 
						mb.first_name AS mbfn, 
						mb.last_name AS mbln 
				FROM 	file_type 
				LEFT OUTER JOIN person AS cb 
					ON file_type.created_by_id = cb.person_id 
				LEFT OUTER JOIN person AS mb 
					ON file_type.modified_by_id = mb.person_id 
				WHERE 	file_type.file_type_id = <cfqueryparam value="#arguments.fileType.getFileTypeID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getFileType.recordCount eq 1>
			<cfif getFileType.dt_modified is not "">
				<cfset dtModified = getFileType.dt_modified />
			</cfif>
			
			<cfset audit.init(getFileType.created_by_id, getFileType.cbfn & " " & getFileType.cbln, getFileType.dt_created, getFileType.ip_created, 
								getFileType.modified_by_id, getFileType.mbfn & " " & getFileType.mbln, dtModified, getFileType.ip_modified, 
								getFileType.is_active) />
			
			<cfset arguments.fileType.init(getFileType.file_type_id, getFileType.file_type, getFileType.file_type_extension, audit) />
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves a fileType">
		<cfargument name="fileType" type="FileType" required="true" />
		
		<cfif arguments.fileType.getFileTypeID() is "">
			<cfset arguments.fileType.setFileTypeID(createUUID()) />
			<cfset create(arguments.fileType) />
		<cfelse>
			<cfset update(arguments.fileType) />
		</cfif>
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new fileType">
		<cfargument name="fileType" type="FileType" required="true" />
		
		<cfset var insertFileType = 0 />
		
		<cftry>
			<cfquery name="insertFileType" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				INSERT INTO file_type (
					file_type_id, 
					file_type, 
					file_extension, 
					created_by_id, 
					dt_created, 
					ip_created, 
					is_active
				) VALUES (
					<cfqueryparam value="#arguments.fileType.getFileTypeID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.fileType.getFileType()#" cfsqltype="cf_sql_varchar" maxlength="100" />, 
					<cfqueryparam value="#arguments.fileType.getFileExtension()#" cfsqltype="cf_sql_varchar" maxlength="20" />, 
					<cfqueryparam value="#arguments.fileType.getAudit().getCreatedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.fileType.getAudit().getDTCreated()#" cfsqltype="cf_sql_timestamp" />, 
					<cfqueryparam value="#arguments.fileType.getAudit().getIPCreated()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
					<cfqueryparam value="#arguments.fileType.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
				)
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates a fileType">
		<cfargument name="fileType" type="FileType" required="true" />
		
		<cfset var updateFileType = 0 />
		
		<cftry>
			<cfquery name="updateFileType" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				UPDATE 	file_type 
				SET 	file_type = <cfqueryparam value="#arguments.fileType.getFileType()#" cfsqltype="cf_sql_varchar" maxlength="100" />, 
						file_extension = <cfqueryparam value="#arguments.fileType.getFileExtension()#" cfsqltype="cf_sql_varchar" maxlength="20" />, 
						modified_by_id = <cfqueryparam value="#arguments.fileType.getAudit().getModifiedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						dt_modified = <cfqueryparam value="#arguments.fileType.getAudit().getDTModified()#" cfsqltype="cf_sql_timestamp" />, 
						ip_modified = <cfqueryparam value="#arguments.fileType.getAudit().getIPModified()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
						is_active = <cfqueryparam value="#arguments.fileType.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" /> 
				WHERE 	file_type_id = <cfqueryparam value="#arguments.fileType.getFileTypeID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes a fileType">
		<cfargument name="fileType" type="FileType" required="true" />
		
		<!--- we'll just deactivate the file type as opposed to deleting it --->
		<cfset var deactivateFileType = 0 />
		
		<cftry>
			<cfquery name="deactivateFileType" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getDSN()#" password="#getDatasource().getPassword()#">
				UPDATE file_type 
				SET is_active = <cfqueryparam value="0" cfsqltype="cf_sql_tinyint" /> 
				WHERE file_type_id = <cfqueryparam value="#arguments.fileType.getFileTypeID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>
	
</cfcomponent>