<cfcomponent 
	displayname="RoleDAO_MySQL" 
	output="false" 
	extends="RoleDAO" 
	hint="RoleDAO - MySQL">

	<cffunction name="init" access="public" output="false" returntype="RoleDAO" hint="Constructor for this CFC.">
		<cfreturn this />
	</cffunction>

	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates a role bean">
		<cfargument name="role" type="Role" required="true" />
		
		<cfset var getRole = 0 />
		<cfset var dtModified = 0 />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		
		<cftry>
			<cfquery name="getRole" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	role.role_id, 
						role.role, 
						role.description, 
						role.created_by_id, 
						role.dt_created, 
						role.ip_created, 
						role.modified_by_id, 
						role.dt_modified, 
						role.ip_modified, 
						role.is_active, 
						cb.first_name AS cbfn, 
						cb.last_name AS cbln, 
						mb.first_name AS mbfn, 
						mb.last_name AS mbln 
				FROM 	role 
				LEFT OUTER JOIN person AS cb 
					ON role.created_by_id = cb.person_id 
				LEFT OUTER JOIN person AS mb 
					ON role.modified_by_id = mb.person_id 
				WHERE 	role.role_id = <cfqueryparam value="#arguments.role.getRoleID()#" cfsqltype="cf_sql_char" 
																maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getRole.recordCount eq 1>
			<cfif getRole.dt_modified is not "">
				<cfset dtModified = getRole.dt_modified />
			</cfif>
			
			<cfset audit.init(getRole.created_by_id, getRole.cbfn & " " & getRole.cbln, getRole.dt_created, 
								getRole.ip_created, getRole.modified_by_id, getRole.mbfn & " " & getRole.mbln, 
								dtModified, getRole.ip_modified, getRole.is_active) />
			
			<cfset arguments.role.init(getRole.role_id, getRole.role, getRole.description, audit) />
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves a role">
		<cfargument name="role" type="Role" required="true" />
		
		<cfif arguments.role.getRoleID() is "">
			<cfset arguments.role.setRoleID(createUUID()) />
			<cfset create(arguments.role) />
		<cfelse>
			<cfset update(arguments.role) />
		</cfif>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="void" hint="Creates a new role">
		<cfargument name="role" type="Role" required="true" />
		
		<cfset var insertRole = 0 />
		
		<cftry>
			<cfquery name="insertRole" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				INSERT INTO role (
					role_id, 
					role, 
					description, 
					created_by_id, 
					dt_created, 
					ip_created, 
					is_active
				) VALUES (
					<cfqueryparam value="#arguments.role.getRoleID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.role.getRole()#" cfsqltype="cf_sql_varchar" maxlength="100" />, 
					<cfqueryparam value="#arguments.role.getDescription()#" cfsqltype="cf_sql_varchar" maxlength="500" 
									null="#not len(arguments.role.getDescription())#" />, 
					<cfqueryparam value="#arguments.role.getAudit().getCreatedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.role.getAudit().getDTCreated()#" cfsqltype="cf_sql_bigint" />, 
					<cfqueryparam value="#arguments.role.getAudit().getIPCreated()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
					<cfqueryparam value="#arguments.role.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
				)
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="void" hint="Updates a role">
		<cfargument name="role" type="Role" required="true" />
		
		<cfset var updateRole = 0 />
		
		<cftry>
			<cfquery name="updateRole" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				UPDATE 	role 
				SET 	role = <cfqueryparam value="#arguments.role.getRole()#" cfsqltype="cf_sql_varchar" maxlength="100" />, 
						description = <cfqueryparam value="#arguments.role.getDescription()#" cfsqltype="cf_sql_varchar" maxlength="500" 
												null="#not len(arguments.role.getDescription())#" />, 
						modified_by_id = <cfqueryparam value="#arguments.role.getAudit().getModifiedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						dt_modified = <cfqueryparam value="#arguments.role.getAudit().getDTModified()#" cfsqltype="cf_sql_bigint" />, 
						ip_modified = <cfqueryparam value="#arguments.role.getAudit().getIPModified()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
						is_active = <cfqueryparam value="#arguments.role.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" /> 
				WHERE	role_id = <cfqueryparam value="#arguments.role.getRoleID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes a role">
		<cfargument name="role" type="Role" required="true" />
		
		<cfset var deleteRole = 0 />
		<cfset var updatePerson = 0 />
		<cfset var error = false />
		<cfset var errorDetail = "" />
		
		<cftransaction action="begin">
			<cftry>
				<cfquery name="updatePerson" datasource="#getDatasource().getDSN()#" 
							username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					UPDATE person 
					SET role_id = null 
					WHERE role_id = <cfqueryparam value="#arguments.role.getRoleID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfset error = true />
					<cfset errorDetail = CFCATCH.Detail />
				</cfcatch>
			</cftry>
			
			<cftry>
				<cfquery name="deleteRole" datasource="#getDatasource().getDSN()#" 
							username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM role 
					WHERE role_id = <cfqueryparam value="#arguments.role.getRoleID()#" cfsqltype="cf_sql_char" maxlength="35" />
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