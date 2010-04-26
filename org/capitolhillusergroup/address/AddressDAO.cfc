<cfcomponent
	displayname="AddressDAO"
	output="false"
	hint="Base AddressDAO">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" output="false" returntype="AddressDAO" hint="Constructor for this CFC.">
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
	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates an address bean">
		<cfargument name="address" type="Address" required="true" />
	</cffunction>
	
	<cffunction name="getAddressByPersonID" access="public" output="false" returntype="void" hint="Populates an address bean">
		<cfargument name="personID" type="string" required="true" />
		<cfargument name="address" type="Address" required="true" />
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves an address">
		<cfargument name="address" type="Address" required="true" />
	</cffunction>
	
	<cffunction name="uploadStates" access="public" output="false" returntype="void">
		<cfargument name="states" type="Array" required="true" />
	</cffunction>

	<cffunction name="uploadCountries" access="public" output="false" returntype="void">
		<cfargument name="countries" type="Array" required="true" />
	</cffunction>
	
	<cffunction name="savePersonAddress" access="public" output="false" returntype="void">
		<cfargument name="personID" type="string" required="true" />
		<cfargument name="addressID" type="string" required="true" />
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new address">
		<cfargument name="address" type="Address" required="true" />
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates an address">
		<cfargument name="address" type="Address" required="true" />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes an address">
		<cfargument name="address" type="Address" required="true" />
	</cffunction>
	
</cfcomponent>