<cfcomponent 
	displayname="LocationGateway_MySQL" 
	output="false" 
	extends="LocationGateway" 
	hint="LocationGateway - MySQL">
	
	<cffunction name="init" access="public" output="false" returntype="LocationGateway">
		<cfreturn this />
	</cffunction>
	
	<!--- gateway methods --->
	<cffunction name="getLocations" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="false" />
		
		<cfset var locations = 0 />
		
		<cftry>
			<cfquery name="locations" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	location.location_id, 
						location.location, 
						location.map_link, 
						location.is_active,
						address.address_id, 
						address.address_1, 
						address.address_2, 
						address.city, 
						address.postal_code, 
						state.state_abbr 
				FROM 	location 
				LEFT OUTER JOIN address ON location.address_id = address.address_id 
				LEFT OUTER JOIN state ON address.state_id = state.state_id 
			<cfif arguments.activeOnly>
				WHERE 	location.is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" /> 
			</cfif>
				ORDER BY location ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn locations />
	</cffunction>
	
</cfcomponent>