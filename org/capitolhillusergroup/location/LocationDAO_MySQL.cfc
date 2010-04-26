<cfcomponent 
	displayname="LocationDAO_MySQL" 
	output="false" 
	extends="LocationDAO" 
	hint="LocationDAO - MySQL">

	<cffunction name="init" access="public" output="false" returntype="LocationDAO" hint="Constructor for this CFC.">
		<cfreturn this />
	</cffunction>

	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates a location bean">
		<cfargument name="location" type="Location" required="true" />
		
		<cfset var getLocation = 0 />
		<cfset var dtModified = createDate(1900, 1, 1) />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var address = 0 />
		
		<cftry>
			<cfquery name="getLocation" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	location.location_id, 
						location.location, 
						location.map_link, 
						location.description, 
						location.address_id, 
						location.created_by_id, 
						location.dt_created, 
						location.ip_created, 
						location.modified_by_id, 
						location.dt_modified, 
						location.ip_modified, 
						location.is_active, 
						cb.first_name AS cbfn, 
						cb.last_name AS cbln, 
						mb.first_name AS mbfn, 
						mb.last_name AS mbln 
				FROM 	location 
				LEFT OUTER JOIN person AS cb 
					ON location.created_by_id = cb.person_id 
				LEFT OUTER JOIN person AS mb 
					ON location.modified_by_id = mb.person_id 
				WHERE 	location.location_id = <cfqueryparam value="#arguments.location.getLocationID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getLocation.recordCount eq 1>
			<cfif getLocation.dt_modified is not "">
				<cfset dtModified = getLocation.dt_modified />
			</cfif>
			
			<cfset audit.init(getLocation.created_by_id, getLocation.cbfn & " " & getLocation.cbln, getLocation.dt_created, getLocation.ip_created, 
								getLocation.modified_by_id, getLocation.mbfn & " " & getLocation.mbln, dtModified, getLocation.ip_modified, 
								getLocation.is_active) />
			
			<cfset address = getAddressService().getAddressByID(getLocation.address_id) />
			
			<cfset arguments.location.init(getLocation.location_id, getLocation.location, getLocation.map_link, getLocation.description, address, audit) />
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves a location">
		<cfargument name="location" type="Location" required="true" />
		
		<cfif arguments.location.getLocationID() is "">
			<cfset arguments.location.setLocationID(createUUID()) />
			<cfset create(arguments.location) />
		<cfelse>
			<cfset update(arguments.location) />
		</cfif>
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new location">
		<cfargument name="location" type="Location" required="true" />
		
		<cfset var insertLocation = 0 />
		<cfset var error = false />
		
		<!--- address is optional --->
		<cfif arguments.location.getAddress().getAddress1() is not "" 
				or arguments.location.getAddress().getAddress2() is not "" 
				or arguments.location.getAddress().getCity() is not "" 
				or arguments.location.getAddress().getStateID() is not "" 
				or arguments.location.getAddress().getPostalCode() is not "">
			<cftry>
				<cfset getAddressService().saveAddress(arguments.location.getAddress()) />
				<cfcatch type="any">
					<cfset error = true />
					<cfthrow type="application" message="Save Address Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
		</cfif>
		
		<cfif not error>
			<cftry>
				<cfquery name="insertLocation" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					INSERT INTO location (
						location_id, 
						location, 
						map_link, 
						description, 
						address_id, 
						created_by_id, 
						dt_created, 
						ip_created, 
						is_active
					) VALUES (
						<cfqueryparam value="#arguments.location.getLocationID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						<cfqueryparam value="#arguments.location.getLocation()#" cfsqltype="cf_sql_varchar" maxlength="250" />, 
						<cfqueryparam value="#arguments.location.getMapLink()#" cfsqltype="cf_sql_varchar" maxlength="250" 
										null="#not len(arguments.location.getMapLink())#" />, 
						<cfqueryparam value="#arguments.location.getDescription()#" cfsqltype="cf_sql_varchar" maxlength="500" 
								null="#not len(arguments.location.getDescription())#" />, 
						<cfqueryparam value="#arguments.location.getAddress().getAddressID()#" cfsqltype="cf_sql_char" maxlength="35" 
								null="#not len(arguments.location.getAddress().getAddressID())#" />, 
						<cfqueryparam value="#arguments.location.getAudit().getCreatedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						<cfqueryparam value="#arguments.location.getAudit().getDTCreated()#" cfsqltype="cf_sql_bigint" />, 
						<cfqueryparam value="#arguments.location.getAudit().getIPCreated()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
						<cfqueryparam value="#arguments.location.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
					)
				</cfquery>
				<cfcatch type="database">
					<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
		</cfif>
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates a location">
		<cfargument name="location" type="Location" required="true" />
		
		<cfset var updateLocation = 0 />
		<cfset var error = false />
		
		<!--- if we have an address id but all the fields are blank, delete the address --->
		<cfif arguments.location.getAddress().getAddressID() is not "" and 
				(arguments.location.getAddress().getAddress1() is "" 
					and arguments.location.getAddress().getAddress2() is "" 
					and arguments.location.getAddress().getCity() is "" 
					and arguments.location.getAddress().getStateID() is "" 
					and arguments.location.getAddress().getPostalCode() is "")>
			<cftry>
				<cfset getAddressService().deleteAddress(arguments.location.getAddress()) />
				<cfset arguments.location.getAddress().init() />
				<cfcatch type="any">
					<cfset error = true />
					<cfthrow type="application" message="Delete Address Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
		<!--- otherwise save it if we have data --->
		<cfelseif arguments.location.getAddress().getAddressID is not "" 
					and arguments.location.getAddress().getAddress1() is not "">
			<cftry>
				<cfset getAddressService().saveAddress(arguments.location.getAddress()) />
				<cfcatch type="any">
					<cfset error = true />
					<cfthrow type="application" message="Update Address Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
		</cfif>
		
		<cftry>
			<cfquery name="updateLocation" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				UPDATE 	location 
				SET 	location = <cfqueryparam value="#arguments.location.getLocation()#" cfsqltype="cf_sql_varchar" maxlength="250" />, 
						map_link = <cfqueryparam value="#arguments.location.getMapLink()#" cfsqltype="cf_sql_varchar" maxlength="250" 
												null="#not len(arguments.location.getMapLink())#" />, 
						description = <cfqueryparam value="#arguments.location.getDescription()#" cfsqltype="cf_sql_varchar" maxlength="500" 
											null="#not len(arguments.location.getDescription())#" />, 
						address_id = <cfqueryparam value="#arguments.location.getAddress().getAddressID()#" cfsqltype="cf_sql_char" maxlength="35" 
											null="#not len(arguments.location.getAddress().getAddressID())#" />, 
						modified_by_id = <cfqueryparam value="#arguments.location.getAudit().getModifiedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						dt_modified = <cfqueryparam value="#arguments.location.getAudit().getDTModified()#" cfsqltype="cf_sql_bigint" />, 
						ip_modified = <cfqueryparam value="#arguments.location.getAudit().getIPModified()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
						is_active = <cfqueryparam value="#arguments.location.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" /> 
				WHERE 	location_id = <cfqueryparam value="#arguments.location.getLocationID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes a location">
		<cfargument name="location" type="Location" required="true" />
		
		<cfset var deleteLocation = 0 />
		<cfset var error = false />
		
		<cftry>
			<cfset getAddressService().deleteAddressByID(arguments.location.getAddress().getAddressID()) />
			<cfcatch type="any">
				<cfset error = true />
				<cfthrow type="application" message="Error Deleting Addresses" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif not error>
			<cftransaction action="begin">
				<cftry>
					<cfquery name="deleteLocation" datasource="#getDatasource().getDSN()#" 
							username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
						DELETE FROM location 
						WHERE location_id = <cfqueryparam value="#arguments.location.getLocationID()#" cfsqltype="cf_sql_char" maxlength="35" />
					</cfquery>
					<cfcatch type="database">
						<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
					</cfcatch>
				</cftry>
			</cftransaction>
		</cfif>
	</cffunction>
	
</cfcomponent>