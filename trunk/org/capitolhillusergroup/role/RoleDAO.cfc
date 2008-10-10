<cfcomponent 
	displayname="RoleDAO" 
	output="false" 
	hint="Base RoleDAO">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" output="false" returntype="RoleDAO" hint="Constructor for this CFC.">
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
	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates a role bean">
		<cfargument name="role" type="Role" required="true" />
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves a role">
		<cfargument name="role" type="Role" required="true" />
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="void" hint="Creates a new role">
		<cfargument name="role" type="Role" required="true" />
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="void" hint="Updates a role">
		<cfargument name="role" type="Role" required="true" />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes a role">
		<cfargument name="role" type="Role" required="true" />
	</cffunction>
	
</cfcomponent>