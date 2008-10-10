<cfcomponent 
	displayname="NewsDAO" 
	output="false" 
	hint="Base NewsDAO">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" output="false" returntype="NewsDAO" hint="Constructor for this CFC.">
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
	
	<!---
	PUBLIC FUNCTIONS - CRUD - DATABASE SPECIFIC OBJECTS THAT EXTEND THIS OBJECT MUST OVERRIDE THESE METHODS
	--->
	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates a news bean">
		<cfargument name="news" type="News" required="true" />
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves a news item">
		<cfargument name="news" type="News" required="true" />
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new news item">
		<cfargument name="news" type="News" required="true" />
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates a news item">
		<cfargument name="news" type="News" required="true" />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes a news item">
		<cfargument name="news" type="News" required="true" />
	</cffunction>
	
</cfcomponent>