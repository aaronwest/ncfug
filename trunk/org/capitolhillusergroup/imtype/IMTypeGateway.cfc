<cfcomponent 
	displayname="IMTypeGateway" 
	output="false" 
	hint="Base IMTypeGateway">
	
	<cffunction name="init" access="public" output="false" returntype="IMTypeGateway">
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
	<cffunction name="getIMTypes" access="public" output="false" returntype="query">
		<cfargument name="getActiveOnly" type="boolean" required="false" default="false" />
	</cffunction>
	
</cfcomponent>