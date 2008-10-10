<cfcomponent displayname="CategoryService" output="false" hint="Category Service for CHUG">
	
	<!--- constructor --->
	<cffunction name="init" access="public" output="false" returntype="CategoryService">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setCategoryDAO" access="public" output="false" returntype="void">
		<cfargument name="categoryDAO" type="CategoryDAO" required="true" />
		<cfset variables.categoryDAO = arguments.categoryDAO />
	</cffunction>
	<cffunction name="getCategoryDAO" access="public" output="false" returntype="CategoryDAO">
		<cfreturn variables.categoryDAO />
	</cffunction>
	
	<cffunction name="setCategoryGateway" access="public" output="false" returntype="void">
		<cfargument name="categoryGateway" type="CategoryGateway" required="true" />
		<cfset variables.categoryGateway = arguments.categoryGateway />
	</cffunction>
	<cffunction name="getCategoryGateway" access="public" output="false" returntype="CategoryGateway">
		<cfreturn variables.categoryGateway />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getCategoryBean" access="public" output="false" returntype="Category">
		<cfreturn createObject("component", "Category").init() />
	</cffunction>
	
	<cffunction name="getCategories" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		
		<cfreturn getCategoryGateway().getCategories(arguments.activeOnly) />
	</cffunction>
	
	<cffunction name="getCategoriesAsArray" access="public" output="false" returntype="array">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		
		<cfreturn getCategoryGateway().getCategoriesAsArray(arguments.activeOnly) />
	</cffunction>
	
	<cffunction name="getCategoryByID" access="public" output="false" returntype="Category">
		<cfargument name="categoryID" type="string" required="true" />
		
		<cfset var category = getCategoryBean() />
		<cfset category.setCategoryID(arguments.categoryID) />
		
		<cfif arguments.categoryID is not "">
			<cfset getCategoryDAO().fetch(category) />
		</cfif>

		<cfreturn category />
	</cffunction>
	
	<cffunction name="getCategoriesByArticleID" access="public" output="false" returntype="array" 
			hint="Returns an array of person beans representing presenters for a particular presentation">
		<cfargument name="articleID" type="uuid" required="true" />
		
		<cfset var categories = arrayNew(1) />
		<cfset var category = 0 />
		<cfset var categoryIDs = getCategoryGateway().getCategoryIDsByArticleID(arguments.articleID) />
		<cfset var categoryID = "" />
		
		<cfif listLen(categoryIDs) gt 0>
			<cfloop index="categoryID" list="#categoryIDs#" delimiters=",">
				<cfset category = getCategoryByID(categoryID) />
				<cfset arrayAppend(categories, category) />
			</cfloop>
		</cfif>
		
		<cfreturn categories />
	</cffunction>
	
	<cffunction name="getCategoriesByBookID" access="public" output="false" returntype="array" 
			hint="Returns an array of person beans representing presenters for a particular presentation">
		<cfargument name="bookID" type="uuid" required="true" />
		
		<cfset var categories = arrayNew(1) />
		<cfset var category = 0 />
		<cfset var categoryIDs = getCategoryGateway().getCategoryIDsByBookID(arguments.bookID) />
		<cfset var categoryID = "" />
		
		<cfif listLen(categoryIDs) gt 0>
			<cfloop index="categoryID" list="#categoryIDs#" delimiters=",">
				<cfset category = getCategoryByID(categoryID) />
				<cfset arrayAppend(categories, category) />
			</cfloop>
		</cfif>
		
		<cfreturn categories />
	</cffunction>
	
	<cffunction name="getCategoryIDsByCategory" access="public" output="false" returntype="string" 
			hint="Returns an array of person beans representing presenters for a particular presentation">
		<cfargument name="category" type="string" required="true" />
		<cfreturn getCategoryGateway().getCategoryIDsByCategory(category=ARGUMENTS.category)>
	</cffunction>
	
	<cffunction name="saveCategory" access="public" output="false" returntype="void">
		<cfargument name="category" type="Category" required="true" />
		
		<cfset getCategoryDAO().save(arguments.category) />
	</cffunction>
	
	<cffunction name="deleteCategory" access="public" output="false" returntype="void">
		<cfargument name="category" type="Category" required="true" />
		
		<cfset getCategoryDAO().delete(arguments.category) />
	</cffunction>
</cfcomponent>