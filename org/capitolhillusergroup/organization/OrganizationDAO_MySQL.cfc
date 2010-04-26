<cfcomponent 
	displayname="OrganizationDAO_MySQL" 
	output="false" 
	extends="OrganizationDAO" 
	hint="OrganizationDAO - MySQL">

	<cffunction name="init" access="public" output="false" returntype="OrganizationDAO" hint="Constructor for this CFC.">
		<cfreturn this />
	</cffunction>

	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates an organization bean">
		<cfargument name="organization" type="Organization" required="true" />
		
		<cfset var getOrganization = 0 />
		<cfset var dtModified = 0 />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		
		<cftry>
			<cfquery name="getOrganization" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	organization.organization_id, 
						organization.organization, 
						organization.created_by_id, 
						organization.dt_created, 
						organization.ip_created, 
						organization.modified_by_id, 
						organization.dt_modified, 
						organization.ip_modified, 
						organization.is_active, 
						cb.first_name AS cbfn, 
						cb.last_name AS cbln, 
						mb.first_name AS mbfn, 
						mb.last_name AS mbln 
				FROM 	organization 
				LEFT OUTER JOIN person AS cb 
					ON organization.created_by_id = cb.person_id 
				LEFT OUTER JOIN person AS mb 
					ON organization.modified_by_id = mb.person_id 
				WHERE 	organization.organization_id = <cfqueryparam value="#arguments.organization.getOrganizationID()#" cfsqltype="cf_sql_char" 
																maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getOrganization.recordCount eq 1>
			<cfif getOrganization.dt_modified is not "">
				<cfset dtModified = getOrganization.dt_modified />
			</cfif>
			
			<cfset audit.init(getOrganization.created_by_id, getOrganization.cbfn & " " & getOrganization.cbln, getOrganization.dt_created, 
								getOrganization.ip_created, getOrganization.modified_by_id, getOrganization.mbfn & " " & getOrganization.mbln, 
								dtModified, getOrganization.ip_modified, getOrganization.is_active) />
			
			<cfset arguments.organization.init(getOrganization.organization_id, getOrganization.organization, audit) />
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves an organization">
		<cfargument name="organization" type="Organization" required="true" />
		
		<cfif arguments.organization.getOrganizationID() is "">
			<cfset arguments.organization.setOrganizationID(createUUID()) />
			<cfset create(arguments.organization) />
		<cfelse>
			<cfset update(arguments.organization) />
		</cfif>
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new organization">
		<cfargument name="organization" type="Organization" required="true" />
		
		<cfset var insertOrganization = 0 />
		
		<cftry>
			<cfquery name="insertOrganization" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				INSERT INTO organization (
					organization_id, 
					organization, 
					created_by_id, 
					dt_created, 
					ip_created, 
					is_active
				) VALUES (
					<cfqueryparam value="#arguments.organization.getOrganizationID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.organization.getOrganization()#" cfsqltype="cf_sql_varchar" maxlength="500" />, 
					<cfqueryparam value="#arguments.organization.getAudit().getCreatedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.organization.getAudit().getDTCreated()#" cfsqltype="cf_sql_bigint" />, 
					<cfqueryparam value="#arguments.organization.getAudit().getIPCreated()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
					<cfqueryparam value="#arguments.organization.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
				)
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates an organization">
		<cfargument name="organization" type="Organization" required="true" />
		
		<cfset var updateOrganization = 0 />
		
		<cftry>
			<cfquery name="updateOrganization" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				UPDATE 	organization 
				SET 	organization = <cfqueryparam value="#arguments.organization.getOrganization()#" cfsqltype="cf_sql_varchar" maxlength="500" />, 
						modified_by_id = <cfqueryparam value="#arguments.organization.getAudit().getModifiedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						dt_modified = <cfqueryparam value="#arguments.organization.getAudit().getDTModified()#" cfsqltype="cf_sql_bigint" />, 
						ip_modified = <cfqueryparam value="#arguments.organization.getAudit().getIPModified()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
						is_active = <cfqueryparam value="#arguments.organization.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
				WHERE 	organization_id = <cfqueryparam value="#arguments.organization.getOrganizationID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes an organization">
		<cfargument name="organization" type="Organization" required="true" />
		
		<cfset var deleteOrganization = 0 />
		<cfset var updatePerson = 0 />
		<cfset var error = false />
		<cfset var errorDetail = "" />
		
		<!--- need to set all the organization ids in the person table to null for this organization --->
		<cftransaction action="begin">
			<cftry>
				<cfquery name="updatePerson" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					UPDATE 	person 
					SET 	organization_id = null 
					WHERE 	organization_id = <cfqueryparam value="#arguments.organization.getOrganizationID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfset error = true />
					<cfset errorDetail = CFCATCH.Detail />
				</cfcatch>
			</cftry>
			
			<cftry>
				<cfquery name="deleteOrganization" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM organization 
					WHERE 	organization_id = <cfqueryparam value="#arguments.organization.getOrganizationID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfset error = true />
					<cfset errorDetail = CFCATCH.Detail />
				</cfcatch>
			</cftry>
			
			<cfif not error>
				<cftransaction action="commit" />
			<cfelse>
				<cftransaction action="rollback" />
				<cfthrow type="application" message="Database Error" detail="#errorDetail#" />
			</cfif>
		</cftransaction>
	</cffunction>
	
</cfcomponent>