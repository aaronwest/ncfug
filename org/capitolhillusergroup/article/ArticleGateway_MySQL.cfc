<cfcomponent 
	displayname="ArticleGateway_MySQL" 
	output="false" 
	extends="ArticleGateway" 
	hint="ArticleGateway - MySQL">
	
	<cffunction name="init" access="public" output="false" returntype="ArticleGateway">
		<cfreturn this />
	</cffunction>
	
	<!--- gateway methods --->
	<cffunction name="getArticles" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		<cfargument name="categoryIDs" type="string" required="false" />
		
		<cfset var articles = 0 />
		<cfset var andString = "WHERE">
		
		<cftry>
			<cfquery name="articles" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	
				article.article_id
				, article.title
				, article.dt_created
				, article.content
				, article.is_active
				<!--- Bit of a Fix in here to prevent having to rewrite welcome screens (for now) --->
				, article.title AS headline
				, article.content AS body
				FROM article 
				<cfif ARGUMENTS.activeOnly IS true>
					WHERE is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" />
					<cfset andString = "AND">
				</cfif>
				
				<cfif StructKeyExists(ARGUMENTS,"categoryIDs")>
					#andString# article_id IN ( SELECT article_id 
												FROM article_category
												<cfif ListLen(ARGUMENTS.categoryIDs) GT 1>
													WHERE category_id IN (<cfqueryparam cfsqltype="cf_sql_char" value="#ARGUMENTS.categoryIDs#" list="true">)
												<cfelseif Len(ARGUMENTS.categoryIDs) GT 0>
													WHERE category_id = <cfqueryparam cfsqltype="cf_sql_char" value="#ARGUMENTS.categoryIDs#">
												<cfelse>
													WHERE category_id IS null
												</cfif>
												)
				</cfif>
				ORDER BY article.dt_created DESC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>

		<cfreturn articles />
	</cffunction>
	
	<cffunction name="getArticlesAsArray" access="public" output="false" returntype="array">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		<cfargument name="categoryIDs" type="string" required="false" />
		
		<cfset var getArticleIDs = getArticleIDs(argumentCollection=ARGUMENTS) />
		<cfset var article = 0 />
		<cfset var articles = ArrayNew(1) />
		
		<cfif getArticleIDs.recordCount gt 0>
			<cfloop query="getArticleIDs">
				<cfset article = getArticleService().getArticleByID(articleID=getArticleIDs.article_id) />
				<cfset arrayAppend(articles, article) />
			</cfloop>
		</cfif>
		
		<cfreturn articles />
	</cffunction>
	
	<cffunction name="getArticleIDs" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		<cfargument name="categoryIDs" type="string" required="false" />
		
		<cfset var tmpQry = 0 />
		<cfset var andString = "WHERE">
		
		<cftry>
			<cfquery name="tmpQry" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	article_id
				FROM 	article
				<cfif ARGUMENTS.activeOnly IS true>
					WHERE is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" />
					<cfset andString = "AND">
				</cfif>
				
				<cfif StructKeyExists(ARGUMENTS,"categoryIDs")>
					<cfif ListLen(ARGUMENTS.categoryIDs) GT 1>
						#andString# category_id IN (<cfqueryparam cfsqltype="cf_sql_char" value="#ARGUMENTS.categoryIDs#" list="true">)
					<cfelse>
						#andString# category_id = <cfqueryparam cfsqltype="cf_sql_char" value="#ARGUMENTS.categoryIDs#" null="#YesNoFormat(Len(ARGUMENTS.categoryIDs) EQ 0)#">
					</cfif>
				</cfif>
				ORDER BY article.dt_created DESC
			</cfquery>
			
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		<cfreturn tmpQry />
	</cffunction>
</cfcomponent>