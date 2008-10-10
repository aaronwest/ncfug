<cfcomponent 
	displayname="RoleGateway_MySQL" 
	output="false" 
	extends="RoleGateway" 
	hint="RoleGateway - MySQL">
	
	<cffunction name="init" access="public" output="false" returntype="RoleGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getRoles" access="public" output="false" returntype="query">
		<cfargument name="getActiveOnly" type="boolean" required="false" default="false" />
		
		<cfset var getRoles = 0 />
		
		<cftry>
			<cfquery name="getRoles" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT role_id, role 
				FROM role 
				<cfif arguments.getActiveOnly>
				WHERE is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" /> 
				</cfif>
				ORDER BY role ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn getRoles />
	</cffunction>
	
</cfcomponent>