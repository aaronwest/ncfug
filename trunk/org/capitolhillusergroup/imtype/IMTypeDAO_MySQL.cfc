<cfcomponent 
	displayname="IMTypeDAO_MySQL" 
	output="false" 
	extends="IMTypeDAO" 
	hint="IMTypeDAO - MySQL">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" output="false" returntype="IMTypeDAO" hint="Constructor for this CFC.">
		<cfreturn this />
	</cffunction>

	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates an imType bean">
		<cfargument name="imType" type="IMType" required="true" />
		
		<cfset var getIMType = 0 />
		<cfset var dtModified = 0 />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		
		<cftry>
			<cfquery name="getIMType" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	im_type.im_type_id, 
						im_type.im_type, 
						im_type.created_by_id, 
						im_type.dt_created, 
						im_type.ip_created, 
						im_type.modified_by_id, 
						im_type.dt_modified, 
						im_type.ip_modified, 
						im_type.is_active, 
						cb.first_name AS cbfn, 
						cb.last_name AS cbln, 
						mb.first_name AS mbfn, 
						mb.last_name AS mbln 
				FROM 	im_type 
				LEFT OUTER JOIN person AS cb 
					ON im_type.created_by_id = cb.person_id 
				LEFT OUTER JOIN person AS mb 
					ON im_type.modified_by_id = mb.person_id 
				WHERE im_type.im_type_id = <cfqueryparam value="#arguments.imType.getIMTypeID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getIMType.recordCount eq 1>
			<cfif getIMType.dt_modified is not "">
				<cfset dtModified = getIMType.dt_modified />
			</cfif>
			
			<cfset audit.init(getIMType.created_by_id, getIMType.cbfn & " " & getIMType.cbln, getIMType.dt_created, getIMType.ip_created, 
								getIMType.modified_by_id, getIMType.mbfn & " " & getIMType.mbln, dtModified, getIMType.ip_modified, 
								getIMType.is_active) />
			
			<cfset arguments.imType.init(getIMType.im_type_id, getIMType.im_type, audit) />
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves an im type">
		<cfargument name="imType" type="IMType" required="true" />
		
		<cfif arguments.imType.getIMTypeID() is "">
			<cfset arguments.imType.setIMTypeID(createUUID()) />
			<cfset create(arguments.imType) />
		<cfelse>
			<cfset update(arguments.imType) />
		</cfif>
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new imType">
		<cfargument name="imType" type="IMType" required="true" />
		
		<cfset var insertIMType = 0 />
		
		<cftry>
			<cfquery name="insertIMType" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				INSERT INTO im_type (
					im_type_id, 
					im_type, 
					created_by_id, 
					dt_created, 
					ip_created, 
					is_active
				) VALUES (
					<cfqueryparam value="#arguments.imType.getIMTypeID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.imType.getIMType()#" cfsqltype="cf_sql_varchar" maxlength="100" />, 
					<cfqueryparam value="#arguments.imType.getAudit().getCreatedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.imType.getAudit().getDTCreated()#" cfsqltype="cf_sql_bigint" />, 
					<cfqueryparam value="#arguments.imType.getAudit().getIPCreated()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
					<cfqueryparam value="#arguments.imType.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
				)
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates an imType">
		<cfargument name="imType" type="IMType" required="true" />
		
		<cfset var updateIMType = 0 />
		
		<cftry>
			<cfquery name="updateIMType" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				UPDATE 	im_type 
				SET 	im_type = <cfqueryparam value="#arguments.imType.getIMType()#" cfsqltype="cf_sql_varchar" maxlength="100" />, 
						modified_by_id = <cfqueryparam value="#arguments.imType.getAudit().getModifiedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						dt_modified = <cfqueryparam value="#arguments.imType.getAudit().getDTModified()#" cfsqltype="cf_sql_bigint" />, 
						ip_modified = <cfqueryparam value="#arguments.imType.getAudit().getIPModified()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
						is_active = <cfqueryparam value="#arguments.imType.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" /> 
				WHERE 	im_type_id = <cfqueryparam value="#arguments.imType.getIMTypeID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes an imType">
		<cfargument name="imType" type="IMType" required="true" />
		
		<cfset var deleteIMType = 0 />
		
		<!--- delete all the im handles for this type --->
		<cftry>
			<cfset getPersonService().deleteIMsByIMTypeID(arguments.imType.getIMTypeID()) />
			<cfcatch type="any">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cftry>
			<cfquery name="deleteIMType" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				DELETE FROM im_type 
				WHERE im_type_id = <cfqueryparam value="#arguments.imType.getIMTypeID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>
	
</cfcomponent>