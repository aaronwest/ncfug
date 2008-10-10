<cfcomponent 
	displayname="AddressGateway" 
	output="false" 
	hint="Base AddressGateway">
	
	<cffunction name="init" access="public" output="false" returntype="AddressGateway">
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
	<cffunction name="getStates" access="public" output="false" returntype="query">
	</cffunction>
	
	<cffunction name="getCountries" access="public" output="false" returntype="query">
	</cffunction>
	
	<cffunction name="getStateAbbreviations" access="public" output="false" returntype="query">
	</cffunction>
	
</cfcomponent>