<cfcomponent 
	displayname="NewsDAO_MySQL" 
	output="false" 
	extends="NewsDAO" 
	hint="NewsDAO - MySQL">

	<cffunction name="init" access="public" output="false" returntype="NewsDAO" hint="Constructor for this CFC.">
		<cfreturn this />
	</cffunction>

	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates a news bean">
		<cfargument name="news" type="News" required="true" />
		
		<cfset var getNews = 0 />
		<cfset var dtModified = createDate(1900, 1, 1) />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		
		<cftry>
			<cfquery name="getNews" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	news.news_id, 
						news.headline, 
						news.body, 
						news.dt_to_post, 
						news.created_by_id, 
						news.dt_created, 
						news.ip_created, 
						news.modified_by_id, 
						news.dt_modified, 
						news.ip_modified, 
						news.is_active, 
						cb.first_name AS cbfn, 
						cb.last_name AS cbln, 
						mb.first_name AS mbfn, 
						mb.last_name AS mbln 
				FROM 	news 
				LEFT OUTER JOIN person AS cb ON news.created_by_id = cb.person_id 
				LEFT OUTER JOIN person AS mb ON news.modified_by_id = mb.person_id 
				WHERE 	news.news_id = <cfqueryparam value="#arguments.news.getNewsID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getNews.recordCount eq 1>
			<cfif getNews.dt_modified is not "">
				<cfset dtModified = getNews.dt_modified />
			</cfif>
			
			<cfset audit.init(getNews.created_by_id, getNews.cbfn & " " & getNews.cbln, getNews.dt_created, getNews.ip_created, 
								getNews.modified_by_id, getNews.mbfn & " " & getNews.mbln, dtModified, getNews.ip_modified, getNews.is_active) />
			
			<cfset arguments.news.init(getNews.news_id, getNews.headline, getNews.body, getNews.dt_to_post, audit) />
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves a news item">
		<cfargument name="news" type="News" required="true" />
		
		<cfif arguments.news.getNewsID() is "">
			<cfset arguments.news.setNewsID(createUUID()) />
			<cfset create(arguments.news) />
		<cfelse>
			<cfset update(arguments.news) />
		</cfif>
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new news item">
		<cfargument name="news" type="News" required="true" />
		
		<cfset var insertNews = 0 />
		
		<cftry>
			<cfquery name="insertNews" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				INSERT INTO news (
					news_id, 
					headline, 
					body, 
					dt_to_post, 
					created_by_id, 
					dt_created, 
					ip_created, 
					is_active
				) VALUES (
					<cfqueryparam value="#arguments.news.getNewsID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.news.getHeadline()#" cfsqltype="cf_sql_varchar" maxlength="500" />, 
					<cfqueryparam value="#arguments.news.getBody()#" cfsqltype="cf_sql_longvarchar" />, 
					<cfqueryparam value="#arguments.news.getDTToPost()#" cfsqltype="cf_sql_bigint" />, 
					<cfqueryparam value="#arguments.news.getAudit().getCreatedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.news.getAudit().getDTCreated()#" cfsqltype="cf_sql_bigint" />, 
					<cfqueryparam value="#arguments.news.getAudit().getIPCreated()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
					<cfqueryparam value="#arguments.news.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
				)
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates a news item">
		<cfargument name="news" type="News" required="true" />
		
		<cfset var updateNews = 0 />
		
		<cftry>
			<cfquery name="updateNews" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				UPDATE 	news 
				SET 	headline = <cfqueryparam value="#arguments.news.getHeadline()#" cfsqltype="cf_sql_varchar" maxlength="500" />, 
						body = <cfqueryparam value="#arguments.news.getBody()#" cfsqltype="cf_sql_longvarchar" />, 
						dt_to_post = <cfqueryparam value="#arguments.news.getDTToPost()#" cfsqltype="cf_sql_bigint" />, 
						modified_by_id = <cfqueryparam value="#arguments.news.getAudit().getModifiedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						dt_modified = <cfqueryparam value="#arguments.news.getAudit().getDTModified()#" cfsqltype="cf_sql_bigint" />, 
						ip_modified = <cfqueryparam value="#arguments.news.getAudit().getIPModified()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
						is_active = <cfqueryparam value="#arguments.news.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" /> 
				WHERE 	news_id = <cfqueryparam value="#arguments.news.getNewsID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes a news item">
		<cfargument name="news" type="News" required="true" />
		
		<cfset var deleteNews = 0 />
		
		<cftry>
			<cfquery name="deleteNews" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				DELETE FROM news 
				WHERE news_id = <cfqueryparam value="#arguments.news.getNewsID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>
	
</cfcomponent>