<cfcomponent 
	displayname="PersonDAO" 
	output="false" 
	hint="Base PersonDAO">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" output="false" returntype="PersonDAO" hint="Constructor for this CFC.">
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
	
	<cffunction name="setIMService" access="public" output="false" returntype="void">
		<cfargument name="imService" type="org.capitolhillusergroup.im.IMService" required="true" />
		<cfset variables.imService = arguments.imService />
	</cffunction>
	<cffunction name="getIMService" access="public" output="false" returntype="org.capitolhillusergroup.im.IMService">
		<cfreturn variables.imService />
	</cffunction>
	
	<cffunction name="setOrganizationService" access="public" output="false" returntype="void">
		<cfargument name="organizationService" type="org.capitolhillusergroup.organization.OrganizationService" required="true" />
		<cfset variables.organizationService = arguments.organizationService />
	</cffunction>
	<cffunction name="getOrganizationService" access="public" output="false" returntype="org.capitolhillusergroup.organization.OrganizationService">
		<cfreturn variables.organizationService />
	</cffunction>
	
	<cffunction name="setAddressService" access="public" output="false" returntype="void">
		<cfargument name="addressService" type="org.capitolhillusergroup.address.AddressService" required="true" />
		<cfset variables.addressService = ARGUMENTS.addressService />
	</cffunction>
	<cffunction name="getAddressService" access="public" output="false" returntype="org.capitolhillusergroup.address.AddressService">
		<cfreturn variables.addressService />
	</cffunction>
	
	<cffunction name="setRoleService" access="public" output="false" returntype="void">
		<cfargument name="roleService" type="org.capitolhillusergroup.role.RoleService" required="true" />
		<cfset variables.roleService = arguments.roleService />
	</cffunction>
	<cffunction name="getRoleService" access="public" output="false" returntype="org.capitolhillusergroup.role.RoleService">
		<cfreturn variables.roleService />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS - CRUD - DATABASE SPECIFIC OBJECTS THAT EXTEND THIS OBJECT MUST OVERRIDE THESE METHODS
	--->
	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates a person bean">
		<cfargument name="person" type="Person" required="true" />
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves a person">
		<cfargument name="person" type="Person" required="true" />
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new person">
		<cfargument name="person" type="Person" required="true" />
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates a person">
		<cfargument name="person" type="Person" required="true" />
	</cffunction>
	
	<cffunction name="updateStatus" access="private" output="false" returntype="void" hint="Updates a person">
		<cfargument name="person" type="Person" required="true" />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes a person">
		<cfargument name="person" type="Person" required="true" />
	</cffunction>
	
</cfcomponent>