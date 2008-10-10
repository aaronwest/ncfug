<cfcomponent 
	displayname="PersonDAO_MySQL" 
	output="false" 
	extends="PersonDAO" 
	hint="PersonDAO - MySQL">

	<cffunction name="init" access="public" output="false" returntype="PersonDAO" hint="Constructor for this CFC.">
		<cfreturn this />
	</cffunction>

	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates a person bean">
		<cfargument name="person" type="Person" required="true" />
		
		<cfset var getPerson = 0 />
		<cfset var dtModified = 0 />
		<cfset var organization = createObject("component", "org.capitolhillusergroup.organization.Organization").init() />
		<cfset var role = createObject("component", "org.capitolhillusergroup.role.Role").init() />
		<cfset var address = createObject("component","org.capitolhillusergroup.address.Address").init() />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var ims = arrayNew(2) />
		
		<cftry>
			<cfquery name="getPerson" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	person.person_id, 
						person.first_name, 
						person.last_name, 
						person.title, 
						person.organization_id, 
						person.phone, 
						person.email, 
						person.url, 
						person.image, 
						person.password, 
						person.is_admin, 
						person.role_id, 
						person.created_by_id, 
						person.dt_created, 
						person.ip_created, 
						person.modified_by_id, 
						person.dt_modified, 
						person.ip_modified, 
						person.is_active, 
						<cfif getDatasource().getColumnExists("person.bio")>person.bio,</cfif>
						cb.first_name AS cbfn, 
						cb.last_name AS cbln, 
						mb.first_name AS mbfn, 
						mb.last_name AS mbln 
				FROM 	person 
				LEFT OUTER JOIN person AS cb 
					ON person.created_by_id = cb.person_id 
				LEFT OUTER JOIN person AS mb 
					ON person.modified_by_id = mb.person_id 
				WHERE 	person.person_id = <cfqueryparam value="#arguments.person.getPersonID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getPerson.recordCount eq 1>
			<cfif getPerson.dt_modified is not "">
				<cfset dtModified = getPerson.dt_modified />
			</cfif>
			
			<cfset organization = getOrganizationService().getOrganizationByID(getPerson.organization_id) />
			<cfset role = getRoleService().getRoleByID(getPerson.role_id) />
			<cfset ims = getIMService().getIMsByPersonID(getPerson.person_id) />
			<cfset address = getAddressService().getAddressByPersonID(getPerson.person_id) />
			
			<cfset audit.init(getPerson.created_by_id, getPerson.cbfn & " " & getPerson.cbln, getPerson.dt_created, getPerson.ip_created, 
								getPerson.modified_by_id, getPerson.mbfn & " " & getPerson.mbln, dtModified, getPerson.ip_modified, 
								getPerson.is_active) />
			
			
			<cfset arguments.person.init(getPerson.person_id, getPerson.first_name, getPerson.last_name, 
										getPerson.title, organization, getPerson.phone, 
										getPerson.email, getPerson.url, getPerson.image, 
										getPerson.password, getPerson.is_admin, ims, address, role, 
										audit) />
										
			<cfif getDatasource().getColumnExists("person.bio")>
				<cfset arguments.person.setBio(getPersion.bio)>
			</cfif>						
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves a person">
		<cfargument name="person" type="Person" required="true" />
		
		<cfif arguments.person.getPersonID() is "">
			<cfset arguments.person.setPersonID(createUUID()) />
			<cfset create(arguments.person) />
		<cfelse>
			<cfset update(arguments.person) />
		</cfif>
		
		<!--- Save IMs --->
		<cfset getIMService().savePersonIMs(arguments.person.getPersonID(), arguments.person.getIMs()) />
		
		<!--- Save Address --->
		<cfset getAddressService().saveAddress(ARGUMENTS.person.getAddress())>
		<cfset getAddressService().savePersonAddress(ARGUMENTS.person.getPersonID(),ARGUMENTS.person.getAddress().getAddressID())>
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new person">
		<cfargument name="person" type="Person" required="true" />
		
		<cfset var insertPerson = 0 />
		
		<cftry>
			<cfquery name="insertPerson" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				INSERT INTO person (
					person_id, 
					first_name, 
					last_name, 
					title, 
					organization_id, 
					phone, 
					email, 
					url, 
					image, 
					password, 
					is_admin, 
					role_id, 
					created_by_id, 
					dt_created, 
					ip_created, 
					is_active
					<cfif getDatasource().getColumnExists("person.bio")>
						, bio
					</cfif>
				) VALUES (
					<cfqueryparam value="#arguments.person.getPersonID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.person.getFirstName()#" cfsqltype="cf_sql_varchar" maxlength="250" />, 
					<cfqueryparam value="#arguments.person.getLastName()#" cfsqltype="cf_sql_varchar" maxlength="250" />, 
					<cfqueryparam value="#arguments.person.getTitle()#" cfsqltype="cf_sql_varchar" maxlength="250" />, 
					<cfqueryparam value="#arguments.person.getOrganization().getOrganizationID()#" cfsqltype="cf_sql_char" maxlength="35" 
									null="#not len(arguments.person.getOrganization().getOrganizationID())#" />, 
					<cfqueryparam value="#arguments.person.getPhone()#" cfsqltype="cf_sql_varchar" maxlength="50" 
									null="#not len(arguments.person.getPhone())#" />, 
					<cfqueryparam value="#arguments.person.getEmail()#" cfsqltype="cf_sql_varchar" maxlength="250" />, 
					<cfqueryparam value="#arguments.person.getURL()#" cfsqltype="cf_sql_varchar" maxlength="255" />, 
					<cfqueryparam value="#arguments.person.getImage()#" cfsqltype="cf_sql_varchar" maxlength="255" 
									null="#not len(arguments.person.getImage())#" />, 
					<cfqueryparam value="#arguments.person.getPassword()#" cfsqltype="cf_sql_varchar" maxlength="50" 
									null="#not len(arguments.person.getPassword())#" />, 
					<cfqueryparam value="#arguments.person.getIsAdmin()#" cfsqltype="cf_sql_tinyint" />, 
					<cfqueryparam value="#arguments.person.getRole().getRoleID()#" cfsqltype="cf_sql_char" maxlength="35" 
									null="#not len(arguments.person.getRole().getRoleID())#" />, 
					<cfqueryparam value="#arguments.person.getAudit().getCreatedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.person.getAudit().getDTCreated()#" cfsqltype="cf_sql_bigint" />, 
					<cfqueryparam value="#arguments.person.getAudit().getIPCreated()#" cfsqltype="cf_sql_char" maxlength="15" />, 
					<cfqueryparam value="#arguments.person.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
					<cfif getDatasource().getColumnExists("person.bio")>
						, <cfqueryparam value="#arguments.person.getBio()#" cfsqltype="cf_sql_clob" />
					</cfif>
				)
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates a person">
		<cfargument name="person" type="Person" required="true" />
		
		<cfset var updatePerson = 0 />
		
		<cftry>
			<cfquery name="updatePerson" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				UPDATE 	person 
				SET 	first_name = <cfqueryparam value="#arguments.person.getFirstName()#" cfsqltype="cf_sql_varchar" maxlength="250" />, 
						last_name = <cfqueryparam value="#arguments.person.getLastName()#" cfsqltype="cf_sql_varchar" maxlength="250" />, 
						title = <cfqueryparam value="#arguments.person.getTitle()#" cfsqltype="cf_sql_varchar" maxlength="250" />, 
						organization_id = <cfqueryparam value="#arguments.person.getOrganization().getOrganizationID()#" cfsqltype="cf_sql_char" 
													maxlength="35" null="#not len(arguments.person.getOrganization().getOrganizationID())#" />, 
						phone = <cfqueryparam value="#arguments.person.getPhone()#" cfsqltype="cf_sql_varchar" maxlength="50" 
											null="#not len(arguments.person.getPhone())#" />, 
						email = <cfqueryparam value="#arguments.person.getEmail()#" cfsqltype="cf_sql_varchar" maxlength="250" />, 
						url = <cfqueryparam value="#arguments.person.getURL()#" cfsqltype="cf_sql_varchar" maxlength="255" />, 
						image = <cfqueryparam value="#arguments.person.getImage()#" cfsqltype="cf_sql_varchar" maxlength="255" 
										null="#not len(arguments.person.getImage())#" />, 
						password = <cfqueryparam value="#arguments.person.getPassword()#" cfsqltype="cf_sql_varchar" maxlength="50" 
												null="#not len(arguments.person.getPassword())#" />, 
						is_admin = <cfqueryparam value="#arguments.person.getIsAdmin()#" cfsqltype="cf_sql_tinyint" />, 
						role_id = <cfqueryparam value="#arguments.person.getRole().getRoleID()#" cfsqltype="cf_sql_char" maxlength="35" 
												null="#not len(arguments.person.getRole().getRoleID())#" />, 
						modified_by_id = <cfqueryparam value="#arguments.person.getAudit().getModifiedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						dt_modified = <cfqueryparam value="#arguments.person.getAudit().getDTModified()#" cfsqltype="cf_sql_bigint" />, 
						ip_modified = <cfqueryparam value="#arguments.person.getAudit().getIPModified()#" cfsqltype="cf_sql_char" maxlength="15" />, 
						is_active = <cfqueryparam value="#arguments.person.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" /> 
				<cfif getDatasource().getColumnExists("person.bio")>
					, bio = <cfqueryparam value="#arguments.person.getBio()#" cfsqltype="cf_sql_clob" />
				</cfif>
				WHERE 	person_id = <cfqueryparam value="#arguments.person.getPersonID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="updateStatus" access="public" output="false" returntype="void" hint="Deactivates a person">
		<cfargument name="person" type="Person" required="true" />
		<cfargument name="status" type="boolean" required="false" default="0" />
		<!--- change is_active status of person --->
		
		<cftry>
			<cfquery name="deactivatePerson" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				UPDATE 	person 
				SET 	is_active = <cfqueryparam value="#arguments.status#" cfsqltype="cf_sql_tinyint" /> 
				WHERE 	person_id = <cfqueryparam value="#arguments.person.getPersonID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes a person">
		<cfargument name="person" type="Person" required="true" />
		
		<!--- delete the person altogether --->
		<cfset var deletePerson = 0 />
		
		<cftry>
			<cfquery name="deletePerson" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				DELETE 	FROM person 
				WHERE 	person_id = <cfqueryparam value="#arguments.person.getPersonID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>
	
</cfcomponent>