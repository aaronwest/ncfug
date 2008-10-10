<cfcomponent 
	displayname="ArticleService" 
	output="false" 
	hint="ArticleService">

	<cffunction name="init" access="public" output="false" returntype="ArticleService">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setArticleDAO" access="public" output="false" returntype="void">
		<cfargument name="articleDAO" type="ArticleDAO" required="true" />
		<cfset variables.articleDAO = arguments.articleDAO />
	</cffunction>
	<cffunction name="getArticleDAO" access="public" output="false" returntype="ArticleDAO">
		<cfreturn variables.articleDAO />
	</cffunction>
	
	<cffunction name="setArticleGateway" access="public" output="false" returntype="void">
		<cfargument name="articleGateway" type="ArticleGateway" required="true" />
		<cfset variables.articleGateway = arguments.articleGateway />
	</cffunction>
	<cffunction name="getArticleGateway" access="public" output="false" returntype="ArticleGateway">
		<cfreturn variables.articleGateway />
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
	
	<!--- service methods --->
	<cffunction name="getArticleBean" access="public" output="false" returntype="Article">
		<cfreturn createObject("component", "Article").init() />
	</cffunction>
	
	<cffunction name="getArticles" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		<cfargument name="categoryIDs" type="string" required="false" />
		
		<cfreturn getArticleGateway().getArticles(argumentCollection=ARGUMENTS) />
	</cffunction>
	
	<cffunction name="getArticlesAsArray" access="public" output="false" returntype="array">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		<cfargument name="categoryIDs" type="string" required="false" />
		
		<cfreturn getArticleGateway().getArticlesAsArray(argumentCollection=ARGUMENTS)>
	</cffunction>
	
	<cffunction name="getStickyCategoryArticles" access="public" output="false" returntype="array">
		<cfargument name="articleIDs" type="string" required="true" />
		
		<cfset var result = ArrayNew(1)>
		
		
		
		<cfreturn result>		
	</cffunction>

	<cffunction name="getArticleByID" access="public" output="false" returntype="Article">
		<cfargument name="articleID" type="string" required="true" />
		
		<cfset var article = getArticleBean() />
		<cfset article.setArticleID(ARGUMENTS.articleID) />
		
		<cfif ARGUMENTS.articleID is not "">
			<cfset getArticleDAO().fetch(article) />
		</cfif>
		
		<cfreturn article />
	</cffunction>
	
	<cffunction name="saveArticle" access="public" output="false" returntype="void">
		<cfargument name="article" type="Article" required="true" />
		
		<cfset getArticleDAO().save(arguments.article) />
	</cffunction>
	
	<cffunction name="deleteArticle" access="public" output="false" returntype="void">
		<cfargument name="article" type="Article" required="true" />
		
		<cfset getArticleDAO().delete(arguments.article) />
	</cffunction>
	
</cfcomponent>