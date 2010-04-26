<cfcomponent 
	displayname="ArticleGateway" 
	output="false" 
	hint="Base ArticleGateway">
	
	<cffunction name="init" access="public" output="false" returntype="ArticleGateway">
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
	
	<cffunction name="setArticleService" access="public" output="false" returntype="void">
		<cfargument name="articleService" type="ArticleService" required="true" />
		<cfset variables.articleService = arguments.articleService />
	</cffunction>
	<cffunction name="getArticleService" access="private" output="false" returntype="ArticleService">
		<cfreturn variables.articleService />
	</cffunction>
	
</cfcomponent>