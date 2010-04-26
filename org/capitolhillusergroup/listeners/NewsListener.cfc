<cfcomponent 
	displayname="NewsListener" 
	output="false" 
	extends="MachII.framework.Listener">

	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- don't need anything here for now --->
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setNewsService" access="public" output="false" returntype="void">
		<cfargument name="newsService" type="org.capitolhillusergroup.news.NewsService" required="true" />
		<cfset variables.newsService = arguments.newsService />
	</cffunction>
	<cffunction name="getNewsService" access="public" output="false" returntype="org.capitolhillusergroup.news.NewsService">
		<cfreturn variables.newsService />
	</cffunction>
	
	<cffunction name="setSessionService" access="public" output="false" returntype="void">
		<cfargument name="sessionService" type="org.capitolhillusergroup.session.SessionService" required="true" />
		<cfset variables.sessionService = arguments.sessionService />
	</cffunction>
	<cffunction name="getSessionService" access="public" output="false" returntype="org.capitolhillusergroup.session.SessionService">
		<cfreturn variables.sessionService />
	</cffunction>
	
	<!--- listener methods --->
	<cffunction name="getNews" access="public" output="false" returntype="query">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfreturn getNewsService().getNews(ARGUMENTS.event.getArg("activeOnly",true),false) />
	</cffunction>
	
	<cffunction name="getHomeNews" access="public" output="false" returntype="query">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getNewsService().getNews(false,true)>
	</cffunction>
	
	
	<cffunction name="getNewsByID" access="public" output="false" returntype="org.capitolhillusergroup.news.News">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getNewsService().getNewsByID(arguments.event.getArg("newsID", "")) />
	</cffunction>
	
	<cffunction name="processNewsForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var news = arguments.event.getArg("news") />
		<cfset var action = "" />
		<cfset var message = "" />
		<cfset var exitEvent = "success" />
		
		<cfset news.getAudit().setIsActive(arguments.event.getArg("isActive", 0)) />
		<cfset news.setDTToPost(getProperty("resourceBundleService").getLocaleUtils().i18nDateTimeParse(arguments.event.getArg("dtToPost"))) />
		
		<cfif news.getNewsID() is "">
			<cfset action = "add" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addnewsitemsuccessful") />
			<cfset news.getAudit().setCreatedByID(getSessionService().getUser().getPersonID()) />
			<cfset news.getAudit().setDTCreated(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset news.getAudit().setIPCreated(CGI.REMOTE_ADDR) />
		<cfelse>
			<cfset action = "update" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("updatenewsitemsuccessful") />
			<cfset news.getAudit().setModifiedByID(getSessionService().getUser().getPersonID()) />
			<cfset news.getAudit().setDTModified(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset news.getAudit().setIPModified(CGI.REMOTE_ADDR) />
		</cfif>
		
		<cftry>
			<cfset getNewsService().saveNews(news) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addupdatenewsfailed") />
				
				<cfif action is "add">
					<cfset news.setNewsID("") />
				</cfif>
				
				<cfset arguments.event.setArg("news", news) />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="deleteNews" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("deletenewssuccessful") />
		<cfset var news = getNewsService().getNewsByID(arguments.event.getArg("newsID")) />
		
		<cftry>
			<cfset getNewsService().deleteNews(news) />
			<cfcatch type="any">
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("deletenewsfailed") />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent("exitEvent", arguments.event.getArgs()) />
	</cffunction>

</cfcomponent>