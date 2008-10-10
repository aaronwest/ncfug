<cfcomponent 
	displayname="ArticleListener" 
	output="false" 
	extends="MachII.framework.Listener">

	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- don't need anything here for now --->
	</cffunction>
	
	<cffunction name="setArticleService" access="public" output="false" returntype="void">
		<cfargument name="articleService" type="org.capitolhillusergroup.article.ArticleService" required="true" />
		<cfset variables.articleService = arguments.articleService />
	</cffunction>
	<cffunction name="getArticleService" access="public" output="false" returntype="org.capitolhillusergroup.article.ArticleService">
		<cfreturn variables.articleService />
	</cffunction>
	
	<cffunction name="setCategoryService" access="public" output="false" returntype="void">
		<cfargument name="categoryService" type="org.capitolhillusergroup.category.CategoryService" required="true" />
		<cfset variables.categoryService = arguments.categoryService />
	</cffunction>
	<cffunction name="getCategoryService" access="public" output="false" returntype="org.capitolhillusergroup.category.CategoryService">
		<cfreturn variables.categoryService />
	</cffunction>
	
	<cffunction name="setPersonService" access="public" output="false" returntype="void">
		<cfargument name="personService" type="org.capitolhillusergroup.person.PersonService" required="true" />
		<cfset variables.personService = arguments.personService />
	</cffunction>
	<cffunction name="getPersonService" access="public" output="false" returntype="org.capitolhillusergroup.person.PersonService">
		<cfreturn variables.personService />
	</cffunction>
	
	<cffunction name="setSessionService" access="public" output="false" returntype="void">
		<cfargument name="sessionService" type="org.capitolhillusergroup.session.SessionService" required="true" />
		<cfset variables.sessionService = arguments.sessionService />
	</cffunction>
	<cffunction name="getSessionService" access="public" output="false" returntype="org.capitolhillusergroup.session.SessionService">
		<cfreturn variables.sessionService />
	</cffunction>
	
	<cffunction name="getArticles" access="public" output="false" returntype="query">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getArticleService().getArticles(arguments.event.getArg("activeOnly", true)) />
	</cffunction>
	
	<cffunction name="getHomePageArticles" access="public" output="false" returntype="query">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var categoryIDs = "">
		
		<cfif Len(Trim(getProperty("homepageCategoryID"))) GT 0>
			<cfset categoryIDs = getProperty("homepageCategoryID")>
		<cfelse>
			<cfset categoryIDs = getCategoryService().getCategoryIDsByCategory("HomePage")>
		</cfif>
		
		<cfreturn getArticleService().getArticles(false,categoryIDs)>
	</cffunction>
	
	<cffunction name="getArticlesAsArray" access="public" output="false" returntype="array">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfreturn getArticleService().getArticlesAsArray(arguments.event.getArg("activeOnly", true)) />
	</cffunction>
	
	<cffunction name="getArticleByID" access="public" output="false" returntype="org.capitolhillusergroup.article.Article">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getArticleService().getArticleById(arguments.event.getArg("articleID", "")) />
	</cffunction>
	
	<cffunction name="processArticleForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var article = arguments.event.getArg("article") />
		<cfset var action = "" />
		<cfset var message = "" />
		<cfset var categories = ArrayNew(1)>
		<cfset var category = 0>
		<cfset var categoryID = "">
		<cfset var authors = ArrayNew(1)>
		<cfset var author = 0>
		<cfset var authorID = "">
		<cfset var exitEvent = "success" />
		
		<cfset article.getAudit().setIsActive(arguments.event.getArg("isActive", 0)) />
		
		<!--- get the authors if needed --->
		<cfif arguments.event.getArg("authorIDs", "") is not "">
			<cfloop list="#arguments.event.getArg('authorIDs')#" index="authorID">
				<cfset author = getPersonService().getPersonByID(authorID) />
				<cfset arrayAppend(authors, author) />
			</cfloop>
		</cfif>
		
		<cfset article.setAuthors(authors) />
		
		<!--- get the categories if needed --->
		<cfif arguments.event.getArg("categoryIDs", "") is not "">
			<cfloop list="#arguments.event.getArg('categoryIDs')#" index="categoryID">
				<cfset category = getCategoryService().getCategoryByID(categoryID) />
				<cfset arrayAppend(categories, category) />
			</cfloop>
		</cfif>
		
		<cfset article.setCategories(categories) />
		
		<cfif article.getArticleID() is "">
			<cfset action = "add" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addarticlesuccessful") />
			<cfset article.getAudit().setCreatedByID(getSessionService().getUser().getPersonID()) />
			<cfset article.getAudit().setDTCreated(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset article.getAudit().setIPCreated(CGI.REMOTE_ADDR) />
		<cfelse>
			<cfset action = "update" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("updatearticlesuccessful") />
			<cfset article.getAudit().setModifiedByID(getSessionService().getUser().getPersonID()) />
			<cfset article.getAudit().setDTModified(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset article.getAudit().setIPModified(CGI.REMOTE_ADDR) />
		</cfif>
		
		<cftry>
			<cfset getArticleService().saveArticle(article) />
			<cfcatch type="any">
				<cfrethrow>
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addupdatearticlefailed") />
				
				<cfif action is "add">
					<cfset article.setArticleID("") />
				</cfif>
				
				<cfset arguments.event.setArg("article", article) />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="deleteArticle" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("deletearticlesuccessful") />
		<cfset var article = getArticleService().getArticleByID(arguments.event.getArg("articleID")) />
		
		<cftry>
			<cfset getArticleService().deleteArticle(article) />
			<cfcatch type="any">
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("deletearticlefailed") />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent("exitEvent", arguments.event.getArgs()) />
	</cffunction>
</cfcomponent>