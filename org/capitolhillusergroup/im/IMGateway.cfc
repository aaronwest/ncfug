<cfcomponent 
	displayname="IMGateway" 
	output="false" 
	hint="Base IMGateway">
	
	<cffunction name="init" access="public" output="false" returntype="IMGateway">
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
	<cffunction name="getIMsByPersonID" access="public" output="false" returntype="array">
		<cfargument name="personID" type="string" required="true" />
	</cffunction>
	
	<cffunction name="savePersonIMs" access="public" output="false" returntype="void">
		<cfargument name="personID" type="string" required="true" />
		<cfargument name="ims" type="array" required="true" />
	</cffunction>
	
	<cffunction name="deletePersonIMs" access="public" output="false" returntype="void">
		<cfargument name="personID" type="string" required="true" />
	</cffunction>
	
</cfcomponent>