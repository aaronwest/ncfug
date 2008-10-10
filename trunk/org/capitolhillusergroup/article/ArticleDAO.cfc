<cfcomponent 
	displayname="ArticleDAO" 
	output="false" 
	hint="Base ArticleDAO">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" output="false" returntype="ArticleDAO" hint="Constructor for this CFC.">
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
	
	<cffunction name="setPersonDAO" access="public" output="false" returntype="void" hint="Dependency: injected">
		<cfargument name="personDAO" type="org.capitolhillusergroup.person.PersonDAO" required="true" />
		<cfset variables.personDAO = arguments.personDAO />
	</cffunction>
	<cffunction name="getPersonDAO" access="public" output="false" returntype="org.capitolhillusergroup.person.PersonDAO">
		<cfreturn variables.personDAO />
	</cffunction>
	
	<cffunction name="setCategoryService" access="public" output="false" returntype="void">
		<cfargument name="categoryService" type="org.capitolhillusergroup.category.CategoryService" required="true" />
		<cfset variables.categoryService = arguments.categoryService />
	</cffunction>
	<cffunction name="getCategoryService" access="public" output="false" 
				returntype="org.capitolhillusergroup.category.CategoryService">
		<cfreturn variables.categoryService />
	</cffunction>
	
	<cffunction name="setPersonService" access="public" output="false" returntype="void">
		<cfargument name="personService" type="org.capitolhillusergroup.person.PersonService" required="true" />
		<cfset variables.personService = arguments.personService />
	</cffunction>
	<cffunction name="getPersonService" access="public" output="false" returntype="org.capitolhillusergroup.person.PersonService">
		<cfreturn variables.personService />
	</cffunction>
	<!---
	PUBLIC FUNCTIONS - CRUD - DATABASE SPECIFIC OBJECTS THAT EXTEND THIS OBJECT MUST OVERRIDE THESE METHODS
	--->
	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Retrieves an article">
		<cfargument name="article" type="Article" required="true" />
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves an article">
		<cfargument name="article" type="Article" required="true" />
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new article">
		<cfargument name="article" type="Article" required="true" />
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates an article">
		<cfargument name="article" type="Article" required="true" />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes an article">
		<cfargument name="article" type="Article" required="true" />
	</cffunction>
	
</cfcomponent>