<cfcomponent 
	displayname="OrganizationGateway_MySQL" 
	output="false" 
	extends="OrganizationGateway"
	hint="OrganizationGateway - MySQL">
	
	<cffunction name="init" access="public" output="false" returntype="OrganizationGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getOrganizations" access="public" output="false" returntype="query" hint="Returns all organizations">
		<cfargument name="getActiveOnly" type="boolean" required="false" default="false" />
		
		<cfset var getOrgs = 0 />
		
		<cftry>
			<cfquery name="getOrgs" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	organization_id, organization, is_active
				FROM 	organization 
			<cfif arguments.getActiveOnly>
				WHERE 	is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" /> 
			</cfif>
				ORDER BY organization ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn getOrgs />
	</cffunction>
	
</cfcomponent>