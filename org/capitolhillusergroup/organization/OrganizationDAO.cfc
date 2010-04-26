<cfcomponent 
	displayname="OrganizationDAO" 
	output="false" 
	hint="Base OrganizationDAO">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" output="false" returntype="OrganizationDAO" hint="Constructor for this CFC.">
		<cfreturn this />
	</cffunction>

	<cffunction name="setDatasource" access="public" output="false" returntype="void"
		hint="Dependency: injected">
		<cfargument name="datasource" type="org.capitolhillusergroup.datasource.Datasource" required="true" />
		<cfset variables.datasource = arguments.datasource />
	</cffunction>	
	<cffunction name="getDatasource" access="private" output="false" returntype="org.capitolhillusergroup.datasource.Datasource">
		<cfreturn variables.datasource />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS - CRUD - DATABASE SPECIFIC OBJECTS THAT EXTEND THIS OBJECT MUST OVERRIDE THESE METHODS
	--->
	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates an organization bean">
		<cfargument name="organization" type="Organization" required="true" />
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves an organization">
		<cfargument name="organization" type="Organization" required="true" />
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new organization">
		<cfargument name="organization" type="Organization" required="true" />
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates an organization">
		<cfargument name="organization" type="Organization" required="true" />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes an organization">
		<cfargument name="organization" type="Organization" required="true" />
	</cffunction>
	
</cfcomponent>