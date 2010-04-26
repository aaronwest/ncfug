<cfcomponent 
	displayname="NewsGateway" 
	output="false" 
	hint="Base NewsGateway">
	
	<cffunction name="init" access="public" output="false" returntype="NewsGateway">
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
	
	<cffunction name="setNewsService" access="public" output="false" returntype="void">
		<cfargument name="newsService" type="NewsService" required="true" />
		<cfset variables.newsService = ARGUMENTS.newsService />
	</cffunction>
	<cffunction name="getNewsService" access="private" output="false" returntype="NewsService">
		<cfreturn variables.newsService />
	</cffunction>
	
	<cffunction name="setResourceBundleFacade" access="public" output="false" returntype="void">
		<cfargument name="resourceBundleFacade" type="org.capitolhillusergroup.i18n.ResourceBundleFacade" required="true" />
		<cfset variables.resourceBundleFacade = arguments.resourceBundleFacade />
	</cffunction>
	<cffunction name="getResourceBundleFacade" access="private" output="false" returntype="org.capitolhillusergroup.i18n.ResourceBundleFacade">
		<cfreturn variables.resourceBundleFacade />
	</cffunction>
	
	<!--- gateway methods --->
	<cffunction name="getNews" access="public" output="false" returntype="query">
	</cffunction>
	
</cfcomponent>