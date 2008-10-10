<cfcomponent 
	displayname="LocationDAO" 
	output="false" 
	hint="Base LocationDAO">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" output="false" returntype="LocationDAO" hint="Constructor for this CFC.">
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

	<cffunction name="setAddressService" access="public" output="false" returntype="void">
		<cfargument name="addressService" type="org.capitolhillusergroup.address.AddressService" required="true" />
		<cfset variables.addressService = arguments.addressService />
	</cffunction>
	<cffunction name="getAddressService" access="public" output="false" returntype="org.capitolhillusergroup.address.AddressService">
		<cfreturn variables.addressService />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS - CRUD - DATABASE SPECIFIC OBJECTS THAT EXTEND THIS OBJECT MUST OVERRIDE THESE METHODS
	--->
	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates a location bean">
		<cfargument name="location" type="Location" required="true" />
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves a location">
		<cfargument name="location" type="Location" required="true" />
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new location">
		<cfargument name="location" type="Location" required="true" />
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates a location">
		<cfargument name="location" type="Location" required="true" />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes a location">
		<cfargument name="location" type="Location" required="true" />
	</cffunction>
	
</cfcomponent>