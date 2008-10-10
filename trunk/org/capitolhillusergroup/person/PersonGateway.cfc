<cfcomponent 
	displayname="PersonGateway" 
	output="false" 
	hint="Base PersonGateway">
	
	<cffunction name="init" access="public" output="false" returntype="PersonGateway">
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
	<cffunction name="getArticleAuthorIDs" access="public" output="false" returntype="string" 
			hint="Returns a comma-delimited list of author IDs for an article">
		<cfargument name="articleID" type="uuid" required="true" />
	</cffunction>
	
	<cffunction name="getPresenterIDsByPresentationID" access="public" output="false" returntype="string" 
			hint="Returns a comma-delimited list of presenter IDs for a particular presentation">
		<cfargument name="presentationID" type="uuid" required="true" />
	</cffunction>
	
	<cffunction name="getPersonIDByCredentials" access="public" output="false" returntype="string">
		<cfargument name="email" type="string" required="true" />
		<cfargument name="password" type="string" required="true" />
	</cffunction>
	
	<cffunction name="getPeople" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="false" />
	</cffunction>
	
	<cffunction name="deleteIMsByIMTypeID" access="public" output="false" returntype="void">
		<cfargument name="imTypeID" type="string" required="true" />
	</cffunction>
	
	<cffunction name="getPersonIDByEmail" access="public" output="false" returntype="string">
		<cfargument name="email" type="string" required="true" />
	</cffunction>

</cfcomponent>