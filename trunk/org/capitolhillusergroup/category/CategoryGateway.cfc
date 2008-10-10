<cfcomponent 
	displayname="CategoryGateway" 
	output="false" 
	hint="Base CategoryGateway">
	
	<cffunction name="init" access="public" output="false" returntype="CategoryGateway">
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
	
	<cffunction name="setCategoryService" access="public" output="false" returntype="void">
		<cfargument name="categoryService" type="CategoryService" required="true" />
		<cfset variables.categoryService = arguments.categoryService />
	</cffunction>
	<cffunction name="getCategoryService" access="private" output="false" returntype="CategoryService">
		<cfreturn variables.categoryService />
	</cffunction>
	
	<!--- gateway methods --->
	<cffunction name="getCategories" access="public" output="false" returntype="query">
	</cffunction>
	
	<cffunction name="getCategoriesAsArray" access="public" output="false" returntype="array">
	</cffunction>
	
</cfcomponent>