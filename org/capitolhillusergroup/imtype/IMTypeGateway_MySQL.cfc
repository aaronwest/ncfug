<cfcomponent 
	displayname="IMTypeGateway_MySQL" 
	output="false" 
	extends="IMTypeGateway" 
	hint="IMTypeGateway - MySQL">
	
	<cffunction name="init" access="public" output="false" returntype="IMTypeGateway">
		<cfreturn this />
	</cffunction>
	
	<!--- gateway methods --->
	<cffunction name="getIMTypes" access="public" output="false" returntype="query">
		<cfargument name="getActiveOnly" type="boolean" required="false" default="false" />
		
		<cfset var getIMTypes = 0 />
		
		<cftry>
			<cfquery name="getIMTypes" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	im_type_id, im_type 
				FROM 	im_type 
				<cfif arguments.getActiveOnly>
					WHERE is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" /> 
				</cfif>
				ORDER BY im_type ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn getIMTypes />
	</cffunction>
	
</cfcomponent>