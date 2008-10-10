<cfcomponent 
	displayname="AddressGateway_MySQL" 
	output="false" 
	extends="AddressGateway" 
	hint="AddressGateway - MySQL">
	
	<cffunction name="init" access="public" output="false" returntype="AddressGateway" hint="constructor">
		<cfreturn this />
	</cffunction>

	<!--- gateway methods --->
	<cffunction name="getStates" access="public" output="false" returntype="query">
		<cfset var states = 0 />
		
		<cftry>
			<cfquery name="states" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 
				state_id
				, state
				, state_abbr
				FROM state 
				ORDER BY state ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn states />
	</cffunction>
	
	<cffunction name="getCountries" access="public" output="false" returntype="query">
		<cfset var countries = 0 />
		
		<cftry>
			<cfquery name="countries" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 
				country_id
				, country
				, country_abbr
				, is_active
				FROM country 
				ORDER BY country ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn countries />
	</cffunction>

	<cffunction name="getStateAbbreviations" access="public" output="false" returntype="query">
		<cfset var states = 0 />
		
		<cftry>
			<cfquery name="states" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT state_id, state_abbr 
				FROM state 
				ORDER BY state_abbr ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn states />
	</cffunction>
	
</cfcomponent>