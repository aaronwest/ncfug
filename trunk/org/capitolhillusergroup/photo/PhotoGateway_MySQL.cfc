<cfcomponent 
	displayname="PhotoGateway_MySQL" 
	output="false" 
	extends="PhotoGateway"
	hint="PhotoGateway - MySQL">
	
	<cffunction name="init" access="public" output="false" returntype="PhotoGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getPhotos" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		
		<cfset var photos = 0 />
		
		<cfquery name="photos" datasource="#getDatasource().getDSN()#" 
				username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
			SELECT 	photo_id
					, title
					, caption
					, file_name
					, is_active
			FROM 	photo
			<cfif arguments.activeOnly>
			WHERE 	is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" /> 
			</cfif>
			ORDER BY title ASC
		</cfquery>
		
		<cfreturn photos />
	</cffunction>
</cfcomponent>