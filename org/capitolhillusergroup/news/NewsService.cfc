<cfcomponent 
	displayname="NewsService" 
	output="false" 
	hint="NewsService">
	
	<!--- constructor --->
	<cffunction name="init" access="public" output="false" returntype="NewsService">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setNewsDAO" access="public" output="false" returntype="void">
		<cfargument name="newsDAO" type="NewsDAO" required="true" />
		<cfset variables.newsDAO = arguments.newsDAO />
	</cffunction>
	<cffunction name="getNewsDAO" access="public" output="false" returntype="NewsDAO">
		<cfreturn variables.newsDAO />
	</cffunction>
	
	<cffunction name="setNewsGateway" access="public" output="false" returntype="void">
		<cfargument name="newsGateway" type="NewsGateway" required="true" />
		<cfset variables.newsGateway = arguments.newsGateway />
	</cffunction>
	<cffunction name="getNewsGateway" access="public" output="false" returntype="NewsGateway">
		<cfreturn variables.newsGateway />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getNews" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		<cfargument name="numToGet" type="numeric" required="false" default="-1" />
		
		<cfreturn getNewsGateway().getNews(arguments.activeOnly, arguments.numToGet) />
	</cffunction>
	
	<cffunction name="getNewsBean" access="public" output="false" returntype="News">
		<cfreturn createObject("component", "News").init() />
	</cffunction>
	
	<cffunction name="getNewsByID" access="public" output="false" returntype="News">
		<cfargument name="newsID" type="string" required="true" />
		
		<cfset var news = createObject("component", "News").init(arguments.newsID) />
		<cfif arguments.newsID is not "">
			<cfset getNewsDAO().fetch(news) />
		</cfif>
		
		<cfreturn news />
	</cffunction>
	
	<cffunction name="saveNews" access="public" output="false" returntype="void">
		<cfargument name="news" type="News" required="true" />
		
		<cfset getNewsDAO().save(arguments.news) />
	</cffunction>
	
	<cffunction name="deleteNews" access="public" output="false" returntype="void">
		<cfargument name="news" type="News" required="true" />
		
		<cfset getNewsDAO().delete(arguments.news) />
	</cffunction>
	
</cfcomponent>