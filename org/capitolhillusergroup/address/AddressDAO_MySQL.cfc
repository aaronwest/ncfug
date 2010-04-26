<cfcomponent 
	displayname="AddressDAO_MySQL" 
	output="false" 
	extends="AddressDAO" 
	hint="AddressDAO for MySQL">

	<cffunction name="init" access="public" output="false" returntype="AddressDAO">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates an address bean">
		<cfargument name="address" type="org.capitolhillusergroup.address.Address" required="true" />

		<cfset var getAddress = 0 />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var dtModified = createDate(1900, 1, 1) />
		
		<cftry>
			<cfquery name="getAddress" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	address.address_id,
						address.address_1,
						address.address_2,
						address.city,
						address.state_id,
						address.postal_code,
						address.country_id,
						address.created_by_id,
						address.dt_created,
						address.ip_created,
						address.modified_by_id,
						address.dt_modified,
						address.ip_modified,
						address.is_active, 
						state.state, 
						country.country, 
						cb.first_name AS cbfn, 
						cb.last_name AS cbln, 
						mb.first_name AS mbfn, 
						mb.last_name AS mbln 
				FROM	address 
				LEFT OUTER JOIN state 
					ON address.state_id = state.state_id 
				LEFT OUTER JOIN country 
					ON address.country_id = country.country_id 
				LEFT OUTER JOIN person AS cb 
					ON address.created_by_id = cb.person_id 
				LEFT OUTER JOIN person AS mb 
					ON address.modified_by_id = mb.person_id 
				<cfif Len(ARGUMENTS.address.getAddressID()) GT 0>
					WHERE address.address_id = <cfqueryparam value="#ARGUMENTS.address.getAddressID()#" cfsqltype="cf_sql_char" maxlength="35" />
				<cfelse>
					WHERE address.address_id IN (SELECT address_id FROM person_address WHERE person_id = <cfqueryparam value="#ARGUMENTS.address.getPersonID()#" cfsqltype="cf_sql_char" maxlength="35" />)
				</cfif>
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>

		<cfif getAddress.recordCount eq 1>
			<cfif getAddress.dt_modified is not "">
				<cfset dtModified = getAddress.dt_modified />
			</cfif>
			
			<cfset audit.init(getAddress.created_by_id, getAddress.cbfn & " " & getAddress.cbln, getAddress.dt_created, getAddress.ip_created, 
								getAddress.modified_by_id, getAddress.mbfn & " " & getAddress.mbln, dtModified, getAddress.ip_modified, 
								getAddress.is_active) />
			
			<cfset arguments.address.init(getAddress.address_id, getAddress.address_1, getAddress.address_2, getAddress.city, getAddress.state_id, 
											getAddress.state, getAddress.postal_code, getAddress.country_id, getAddress.country, audit) />
		</cfif>
	</cffunction>
	
	<cffunction name="getAddressByPersonID" access="public" output="false" returntype="void" hint="Populates an address bean">
		<cfargument name="personID" type="string" required="true" />
		<cfargument name="address" type="Address" required="true" />
		
		<cfset var getAddress = 0 />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var dtModified = createDate(1900, 1, 1) />
		
		<cftry>
			<cfquery name="getAddress" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	address.address_id,
						address.address_1,
						address.address_2,
						address.city,
						address.state_id,
						address.postal_code,
						address.country_id,
						address.created_by_id,
						address.dt_created,
						address.ip_created,
						address.modified_by_id,
						address.dt_modified,
						address.ip_modified,
						address.is_active, 
						state.state, 
						country.country, 
						cb.first_name AS cbfn, 
						cb.last_name AS cbln, 
						mb.first_name AS mbfn, 
						mb.last_name AS mbln 
				FROM	address 
				LEFT OUTER JOIN state 
					ON address.state_id = state.state_id 
				LEFT OUTER JOIN country 
					ON address.country_id = country.country_id 
				LEFT OUTER JOIN person AS cb 
					ON address.created_by_id = cb.person_id 
				LEFT OUTER JOIN person AS mb 
					ON address.modified_by_id = mb.person_id 
				WHERE address.address_id IN (SELECT address_id FROM person_address WHERE person_id = <cfqueryparam value="#ARGUMENTS.personID#" cfsqltype="cf_sql_char" maxlength="35" />)
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>

		<cfif getAddress.recordCount eq 1>
			<cfif getAddress.dt_modified is not "">
				<cfset dtModified = getAddress.dt_modified />
			</cfif>
			
			<cfset audit.init(getAddress.created_by_id, getAddress.cbfn & " " & getAddress.cbln, getAddress.dt_created, getAddress.ip_created, 
								getAddress.modified_by_id, getAddress.mbfn & " " & getAddress.mbln, dtModified, getAddress.ip_modified, 
								getAddress.is_active) />
			
			<cfset ARGUMENTS.address.init(getAddress.address_id, getAddress.address_1, getAddress.address_2, getAddress.city, getAddress.state_id, 
											getAddress.state, getAddress.postal_code, getAddress.country_id, getAddress.country, audit) />
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves an address">
		<cfargument name="address" type="Address" required="true" />
		
		<cfif arguments.address.getAddressID() is "">
			<cfset arguments.address.setAddressID(createUUID()) />
			<cfset create(arguments.address) />
		<cfelse>
			<cfset update(arguments.address) />
		</cfif>
	</cffunction>
	
	<cffunction name="uploadStates" access="public" output="false" returntype="void">
		<cfargument name="states" type="Array" required="true" />
		
		<cfset var qInsert = 0>
		<cfset var qDelete = 0>
		<cfset var qAddress = 0>
		<cfset var qUpdate = 0>
		<cfset var i = 0>
		<cfset var addressStates = StructNew()>
		
		<cfquery name="qAddress" datasource="#getDatasource().getDSN()#" 
			username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
			SELECT DISTINCT a.state_id, s.state, s.state_abbr
			FROM address a
			INNER JOIN state s ON a.state_id = s.state_id
		</cfquery>
		
		<cfloop query="qAddress">
			<cfset addressStates[qAddress.state] = StructNew()>
			<cfset addressStates[qAddress.state].state_id = qAddress.state_id>
			<cfset addressStates[qAddress.state].state_abbr = qAddress.state_abbr>
		</cfloop>
				
		<cfquery name="qDelete" datasource="#getDatasource().getDSN()#" 
			username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
			DELETE FROM state
		</cfquery>
		
		<cfloop from="1" to="#ArrayLen(ARGUMENTS.states)#" index="i">
			<cfquery name="qInsert" datasource="#getDatasource().getDSN()#" 
				username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				INSERT INTO state
				(state_id
				, state
				, state_abbr
				)VALUES(
				<cfqueryparam value="#ARGUMENTS.states[i].state_id#" cfsqltype="cf_sql_char" maxlength="35">
				, <cfqueryparam value="#ARGUMENTS.states[i].state#" cfsqltype="cf_sql_char" maxlength="50">
				, <cfqueryparam value="#ARGUMENTS.states[i].state_abbr#" cfsqltype="cf_sql_char" maxlength="2">
				)
			</cfquery>
			
			<cfif StructKeyExists(addressStates,ARGUMENTS.states[i].state)>
				<cfquery name="qUpdate" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					UPDATE address
					SET state_id = <cfqueryparam value="#ARGUMENTS.states[i].state_id#" cfsqltype="cf_sql_char" maxlength="35">
					WHERE state_id = <cfqueryparam value="#addressStates[ARGUMENTS.states[i].state].state_id#" cfsqltype="cf_sql_char" maxlength="35">
				</cfquery>
				<cfset StructDelete(addressStates,ARGUMENTS.states[i].state)>
			</cfif>
		</cfloop>
		
		<cfloop collection="#addressStates#" item="i">
			<cfquery name="qInsert" datasource="#getDatasource().getDSN()#" 
				username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				INSERT INTO state
				(state_id
				, state
				, state_abbr
				)VALUES(
				<cfqueryparam value="#addressStates[i].state_id#" cfsqltype="cf_sql_char" maxlength="35">
				, <cfqueryparam value="#i#" cfsqltype="cf_sql_char" maxlength="50">
				, <cfqueryparam value="#addressStates[i].state_abbr#" cfsqltype="cf_sql_char" maxlength="2">
				)
			</cfquery>
		</cfloop>

	</cffunction>

	<cffunction name="uploadCountries" access="public" output="false" returntype="void">
		<cfargument name="countries" type="Array" required="true" />
		
		<cfset var qInsert = 0>
		<cfset var qDelete = 0>
		<cfset var qAddress = 0>
		<cfset var qUpdate = 0>
		<cfset var i = 0>
		<cfset var addressCountries = StructNew()>
		
		<cfquery name="qAddress" datasource="#getDatasource().getDSN()#" 
			username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
			SELECT DISTINCT a.country_id, s.country, s.country_abbr, s.is_active
			FROM address a
			INNER JOIN country s ON a.country_id = s.country_id
		</cfquery>
		
		<cfloop query="qAddress">
			<cfset addressCountries[qAddress.country] = StructNew()>
			<cfset addressCountries[qAddress.country].country_id = qAddress.country_id>
			<cfset addressCountries[qAddress.country].country_abbr = qAddress.country_abbr>
		</cfloop>
				
		<cfquery name="qDelete" datasource="#getDatasource().getDSN()#" 
			username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
			DELETE FROM country
		</cfquery>
		
		<cfloop from="1" to="#ArrayLen(ARGUMENTS.countries)#" index="i">
			<cfquery name="qInsert" datasource="#getDatasource().getDSN()#" 
				username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				INSERT INTO country
				(country_id
				, country
				, country_abbr
				, is_active
				)VALUES(
				<cfqueryparam value="#ARGUMENTS.countries[i].country_id#" cfsqltype="cf_sql_char" maxlength="35">
				, <cfqueryparam value="#ARGUMENTS.countries[i].country#" cfsqltype="cf_sql_char" maxlength="50">
				, <cfqueryparam value="#ARGUMENTS.countries[i].country_abbr#" cfsqltype="cf_sql_char" maxlength="2">
				, <cfqueryparam value="#ARGUMENTS.countries[i].is_active#" cfsqltype="cf_sql_smallint" maxlength="2">
				)
			</cfquery>
			
			<cfif StructKeyExists(addressCountries,ARGUMENTS.countries[i].country)>
				<cfquery name="qUpdate" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					UPDATE address
					SET country_id = <cfqueryparam value="#ARGUMENTS.countries[i].country_id#" cfsqltype="cf_sql_char" maxlength="35">
					WHERE country_id = <cfqueryparam value="#addressCountries[ARGUMENTS.states[i].state].country_id#" cfsqltype="cf_sql_char" maxlength="35">
				</cfquery>
				<cfset StructDelete(addressCountries,ARGUMENTS.countries[i].country)>
			</cfif>
		</cfloop>
		
		<cfloop collection="#addressCountries#" item="i">
			<cfquery name="qInsert" datasource="#getDatasource().getDSN()#" 
				username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				INSERT INTO country
				(country_id
				, country
				, country_abbr
				, is_active
				)VALUES(
				<cfqueryparam value="#addressCountries[i].country_id#" cfsqltype="cf_sql_char" maxlength="35">
				, <cfqueryparam value="#i#" cfsqltype="cf_sql_char" maxlength="50">
				, <cfqueryparam value="#addressCountries[i].country_abbr#" cfsqltype="cf_sql_char" maxlength="2">
				, <cfqueryparam value="#addressCountries[i].is_active#" cfsqltype="cf_sql_smallint" maxlength="2">
				)
			</cfquery>
		</cfloop>

	</cffunction>
	
	<cffunction name="savePersonAddress" access="public" output="false" returntype="void">
		<cfargument name="personID" type="string" required="true" />
		<cfargument name="addressID" type="string" required="true" />
		
		<cfset var qDelete = 0>
		<cfset var qInsert = 0>
		
		
		<cftry>
			<cfif Len(ARGUMENTS.personID) GT 0>
				<cfquery name="qDelete" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM person_address
					WHERE person_id = <cfqueryparam value="#ARGUMENTS.personID#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				
				<cfif Len(ARGUMENTS.addressID) GT 0>
					<cfquery name="qInsert" datasource="#getDatasource().getDSN()#" 
							username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
						INSERT INTO person_address
						(person_id
						, address_id 
						)VALUES(
						<cfqueryparam value="#ARGUMENTS.personID#" cfsqltype="cf_sql_char" maxlength="35" />
						, <cfqueryparam value="#ARGUMENTS.addressID#" cfsqltype="cf_sql_char" maxlength="35" />
						)
					</cfquery>
				</cfif>
			</cfif>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>

	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void">
		<cfargument name="address" type="Address" required="true" />

		<cfset var insertAddress = 0 />
		
		<cftry>
			<cfquery name="insertAddress" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				INSERT INTO address (
					address_id,
					address_1,
					address_2,
					city,
					state_id,
					postal_code,
					country_id,
					created_by_id,
					dt_created,
					ip_created,
					is_active
				) VALUES (
					<cfqueryparam value="#arguments.address.getAddressID()#" cfsqltype="cf_sql_char" maxlength="35" />,
					<cfqueryparam value="#arguments.address.getAddress1()#" cfsqltype="cf_sql_varchar" maxlength="250" />,
					<cfqueryparam value="#arguments.address.getAddress2()#" cfsqltype="cf_sql_varchar" 
							maxlength="250" null="#not len(arguments.address.getAddress2())#" />,
					<cfqueryparam value="#arguments.address.getCity()#" cfsqltype="cf_sql_varchar" maxlength="250" />,
					<cfqueryparam value="#arguments.address.getStateID()#" cfsqltype="cf_sql_char" 
							maxlength="35" null="#not len(arguments.address.getStateID())#" />,
					<cfqueryparam value="#arguments.address.getPostalCode()#" cfsqltype="cf_sql_varchar" 
							maxlength="100" null="#not len(arguments.address.getPostalCode())#" />,
					<cfqueryparam value="#arguments.address.getCountryID()#" cfsqltype="cf_sql_char" maxlength="35" />,
					<cfqueryparam value="#arguments.address.getAudit().getCreatedByID()#" cfsqltype="cf_sql_char" maxlength="35" />,
					<cfqueryparam value="#arguments.address.getAudit().getDTCreated()#" cfsqltype="cf_sql_bigint" />,
					<cfqueryparam value="#arguments.address.getAudit().getIPCreated()#" cfsqltype="cf_sql_varchar" maxlength="15" />,
					<cfqueryparam value="#arguments.address.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
				)
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void">
		<cfargument name="address" type="org.capitolhillusergroup.address.Address" required="true" />

		<cfset var updateAddress = 0 />
		
		<cftry>
			<cfquery name="updateAddress" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				UPDATE	address
				SET		address_1 = <cfqueryparam value="#arguments.address.getAddress1()#" cfsqltype="cf_sql_varchar" maxlength="250" />,
						address_2 = <cfqueryparam value="#arguments.address.getAddress2()#" cfsqltype="cf_sql_varchar" 
											maxlength="250" null="#not len(arguments.address.getAddress2())#" />,
						city = <cfqueryparam value="#arguments.address.getCity()#" cfsqltype="cf_sql_varchar" maxlength="250" />,
						state_id = <cfqueryparam value="#arguments.Address.getStateID()#" cfsqltype="cf_sql_char" 
											maxlength="35" null="#not len(arguments.address.getStateID())#" />,
						postal_code = <cfqueryparam value="#arguments.address.getPostalCode()#" cfsqltype="cf_sql_varchar" 
											maxlength="100" null="#not len(arguments.address.getPostalCode())#" />,
						country_id = <cfqueryparam value="#arguments.address.getCountryID()#" cfsqltype="cf_sql_char" maxlength="35" />,
						modified_by_id = <cfqueryparam value="#arguments.address.getAudit().getModifiedByID()#" cfsqltype="cf_sql_char" 
											maxlength="35" null="#not len(arguments.address.getAudit().getModifiedByID())#" />,
						dt_modified = <cfqueryparam value="#arguments.address.getAudit().getDTModified()#" cfsqltype="cf_sql_bigint" 
											null="#not len(arguments.address.getAudit().getDTModified())#" />,
						ip_modified = <cfqueryparam value="#arguments.address.getAudit().getIPModified()#" cfsqltype="cf_sql_varchar" 
											maxlength="15" null="#not len(arguments.address.getAudit().getIPModified())#" />,
						is_active = <cfqueryparam value="#arguments.address.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
				WHERE	address_id = <cfqueryparam value="#arguments.address.getAddressID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes an address and the address_person records">
		<cfargument name="address" type="org.capitolhillusergroup.address.Address" required="true" />
		
		<cfset var deletePersonAddress = 0 />
		<cfset var deleteAddress = 0 />
		<cfset var error = false />
		
		<cftransaction action="begin">
			<cftry>
				<cfquery name="deletePersonAddress" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM person_address 
					WHERE address_id = <cfqueryparam value="#arguments.address.getAddressID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfset error = true />
				</cfcatch>
			</cftry>
			
			<cftry>
				<cfquery name="deleteAddress" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM address 
					WHERE address_id = <cfqueryparam value="#arguments.address.getAddressID()#" cfsqltype="cf_sql_char" maxlength="35" />
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