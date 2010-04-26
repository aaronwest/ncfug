<cfcomponent 
	displayname="PhotoAlbumGateway" 
	output="false" 
	hint="Base PhotoAlbumGateway">
	
	<cffunction name="init" access="public" output="false" returntype="PhotoAlbumGateway">
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
	
	
	
</cfcomponent>