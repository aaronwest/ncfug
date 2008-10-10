<cfcomponent 
	displayname="NewsGateway_MySQL" 
	output="false" 
	extends="NewsGateway" 
	hint="NewsGateway - MySQL">
	
	<cffunction name="init" access="public" output="false" returntype="NewsGateway">
		<cfreturn this />
	</cffunction>
	
	<!--- gateway methods --->
	<cffunction name="getNews" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		<cfargument name="homeOnly" type="boolean" required="false" default="false" />
		
		<cfset var news = 0 />

		<cftry>
			<cfquery name="news" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	
				news_id
				, headline
				, body
				, dt_to_post
				, created_by_id
				, dt_created
				, ip_created
				, modified_by_id
				, dt_modified
				, ip_modified
				, is_active
				FROM news 
				<cfif ARGUMENTS.homeOnly>
					WHERE news.body LIKE <cfqueryparam value="<!-- HOME -->%" cfsqltype="cf_sql_clob" />
				<cfelseif ARGUMENTS.activeOnly>
					WHERE news.is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" />
				</cfif>
				
				ORDER BY news.dt_to_post DESC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn news />
	</cffunction>
	
	<cffunction name="getNewsAsArray" access="public" output="false" returntype="Array">
		<cfargument name="activeOnly" type="boolean" required="false" default="false" />
		<cfargument name="numToGet" type="numeric" required="false" default="-1" />
		
		<cfset var getNewsIds = 0 />
		<cfset var newsArticle = 0 />
		<cfset var newsArticles = ArrayNew(1) />
		
		<cftry>
			<cfquery name="getNewsIds" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	news_id
				FROM 	news 
				<cfif arguments.activeOnly>
				WHERE 	is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" /> 
				</cfif>
				ORDER BY dt_to_post DESC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getNewsIds.recordCount gt 0>
			<cfloop query="getNewsIds">
				<cfset newsArticle = getNewsService().getNewsByID(getNewsIds.news_id) />
				<cfset ArrayAppend(newsArticles, newsArticle) />
			</cfloop>
		</cfif>
		
		<cfreturn newsArticles />
	</cffunction>
	
</cfcomponent>