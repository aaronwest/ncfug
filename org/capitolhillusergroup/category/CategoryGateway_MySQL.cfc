<cfcomponent 
	displayname="CategoryGateway_MySQL" 
	output="false" 
	extends="CategoryGateway" 
	hint="CategoryGateway - MySQL">
	
	<cffunction name="init" access="public" output="false" returntype="CategoryGateway">
		<cfreturn this />
	</cffunction>
	
	<!--- gateway methods --->
	<cffunction name="getCategories" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		
		<cfset var categories = 0 />
		
		<cfquery name="categories" datasource="#getDatasource().getDSN()#" 
				username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
			SELECT 	category.category_id,
					category.is_active, 
					category.category
			FROM 	category 
			<cfif arguments.activeOnly>
			WHERE 	is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" /> 
			</cfif>
			ORDER BY category ASC
		</cfquery>
		
		<cfreturn categories />
	</cffunction>
	
	<cffunction name="getCategoriesAsArray" access="public" output="false" returntype="array">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		
		<cfset var getCategoryIDs = 0 />
		<cfset var category = 0 />
		<cfset var categories = arrayNew(1) />
		
		<cfquery name="getCategoryIDs" datasource="#getDatasource().getDSN()#" 
				username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
			SELECT 	category_id 
			FROM 	category 
			<cfif arguments.activeOnly>
			WHERE 	is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" /> 
			</cfif>
			ORDER BY category ASC
		</cfquery>
		
		<cfif getCategoryIDs.recordCount gt 0>
			<cfloop query="getCategoryIDs">
				<cfset category = getCategoryService().getCategoryByID(getCategoryIDs.category_id) />
				<cfset arrayAppend(categories, category) />
			</cfloop>
		</cfif>
		
		<cfreturn categories />
	</cffunction>
	
	<cffunction name="getCategoryIDsByArticleID" access="public" output="false" returntype="string" 
			hint="Returns a comma-delimited list of category IDs for a particular article">
		<cfargument name="articleID" type="uuid" required="true" />
		
		<cfset var getCategoryIDs = 0 />
		<cfset var categoryIDs = "" />
		
		<cftry>
			<cfquery name="getCategoryIDs" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	article_category.category_id, 
						category.category
				FROM 	article_category 
				INNER JOIN category ON article_category.category_id = category.category_id 
				WHERE article_id = <cfqueryparam value="#arguments.articleID#" cfsqltype="cf_sql_char" maxlength="35" /> 
				ORDER BY category.category ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfloop query="getCategoryIDs">
			<cfset categoryIDs = listAppend(categoryIDs, getCategoryIDs.category_id, ",") />
		</cfloop>
		
		<cfreturn categoryIDs />
	</cffunction>
	
	<cffunction name="getCategoryIDsByBookID" access="public" output="false" returntype="string" 
			hint="Returns a comma-delimited list of category IDs for a particular book">
		<cfargument name="bookID" type="uuid" required="true" />
		
		<cfset var getCategoryIDs = 0 />
		<cfset var categoryIDs = "" />
		
		<cftry>
			<cfquery name="getCategoryIDs" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	book_category.category_id, 
						category.category
				FROM 	book_category 
				INNER JOIN category ON book_category.category_id = category.category_id 
				WHERE book_id = <cfqueryparam value="#arguments.bookID#" cfsqltype="cf_sql_char" maxlength="35" /> 
				ORDER BY category.category ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfloop query="getCategoryIDs">
			<cfset categoryIDs = listAppend(categoryIDs, getCategoryIDs.category_id, ",") />
		</cfloop>
		
		<cfreturn categoryIDs />
	</cffunction>
	
	<cffunction name="getCategoryIDsByCategory" access="public" output="false" returntype="string" 
			hint="Returns a comma-delimited list of category IDs for a particular article">
		<cfargument name="category" type="string" required="true" />
		
		<cfset var getCategoryIDs = 0 />
		<cfset var categoryIDs = "" />
		
		<cftry>
			<cfquery name="getCategoryIDs" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	category.category_id
				FROM 	category
				WHERE category = <cfqueryparam value="#ARGUMENTS.category#" cfsqltype="cf_sql_char">
				ORDER BY category.category ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfloop query="getCategoryIDs">
			<cfset categoryIDs = listAppend(categoryIDs, getCategoryIDs.category_id, ",") />
		</cfloop>
		
		<cfreturn categoryIDs />
	</cffunction>
	
</cfcomponent>