<cfcomponent 
	displayname="OrganizationGateway" 
	output="false" 
	hint="Base OrganizationGateway">
	
	<cffunction name="init" access="public" output="false" returntype="OrganizationGateway">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setDatasource" access="public" output="false" returntype="void"
		hint="Dependency: injected">
		<cfargument name="datasource" type="org.capitolhillusergroup.datasource.Datasource" required="true" />
		<cfset variables.datasource = arguments.datasource />
	</cffunction>	
	<cffunction name="getDatasource" access="private" output="false" returntype="org.capitolhillusergroup.datasource.Datasource">
		<cfreturn variables.datasource />
	</cffunction>
	
	<!--- gateway methods --->
	<cffunction name="getOrganizations" access="public" output="false" returntype="query" hint="Returns a query object with all organizations">
		<cfset var getOrganizations = 0 />
		
		<cftry>
			<cfquery name="getOrganizations" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	organization_id, organization
				FROM 	organization 
				ORDER BY organization
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn getOrganizations />
	</cffunction>
	
</cfcomponent>