<cfcomponent 
	displayname="ArticleDAO_MySQL" 
	output="false" 
	extends="ArticleDAO" 
	hint="ArticleDAO - MySQL">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" output="false" returntype="ArticleDAO" hint="Constructor for this CFC.">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Retrieves an article">
		<cfargument name="article" type="Article" required="true" />
		
		<cfset var getArticle = 0 />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var dtModified = createDate(1900, 1, 1) />
		<cfset var authors = ArrayNew(1)>
		<cfset var categories = ArrayNew(1)>
		
		<cftry>
			<cfquery name="getArticle" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	article.article_id,
						article.title,
						article.content,
						article.created_by_id,
						article.dt_created,
						article.ip_created,
						article.modified_by_id,
						article.dt_modified,
						article.ip_modified,
						article.is_active, 
						cb.first_name AS cbfn, 
						cb.last_name AS cbln, 
						mb.first_name AS mbfn, 
						mb.last_name AS mbln 
				FROM	article 
				LEFT OUTER JOIN person AS cb 
					ON article.created_by_id = cb.person_id 
				LEFT OUTER JOIN person AS mb 
					ON article.modified_by_id = mb.person_id 
				WHERE	article.article_id = <cfqueryparam value="#arguments.article.getArticleID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getArticle.recordCount eq 1>
			<cfif getArticle.dt_modified is not "">
				<cfset dtModified = getArticle.dt_modified />
			</cfif>
			
			<cfset authors = getPersonService().getAuthorsByArticleID(getArticle.article_id) />
			<cfset categories = getCategoryService().getCategoriesByArticleID(getArticle.article_id) />
			
			<cfset audit.init(getArticle.created_by_id, getArticle.cbfn & " " & getArticle.cbln, getArticle.dt_created, getArticle.ip_created, 
								getArticle.modified_by_id, getArticle.mbfn & " " & getArticle.mbln, dtModified, getArticle.ip_modified, 
								getArticle.is_active) />
			
			<cfset arguments.article.setArticleID(getArticle.article_id) />
			<cfset arguments.article.setTitle(getArticle.title) />
			<cfset arguments.article.setContent(getArticle.content) />
			<cfset arguments.article.setAuthors(authors)>
			<cfset arguments.article.setCategories(categories)>
			<cfset arguments.article.setAudit(audit) />
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves an article">
		<cfargument name="article" type="Article" required="true" />

		<cfif arguments.article.getArticleID() is "">
			<cfset arguments.article.setArticleID(createUUID()) />
			<cfset create(arguments.article) />
		<cfelse>
			<cfset update(arguments.article) />
		</cfif>
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new article">
		<cfargument name="article" type="Article" required="true" />

		<cfset var insertArticle = 0 />
		<cfset var insertCategory = 0>
		<cfset var insertAuthor = 0>
		<cfset var categories = arguments.article.getCategories() />
		<cfset var authors = arguments.article.getAuthors() />
		<cfset var i = 0>
		<cfset var error = false />
		
		<cftransaction action="begin">
			<cftry>
				<cfquery name="insertArticle" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					INSERT INTO article	(
						article_id,
						title,
						content,
						created_by_id,
						dt_created,
						ip_created,
						is_active
					) VALUES (
						<cfqueryparam value="#arguments.article.getArticleID()#" cfsqltype="cf_sql_char" maxlength="35" />,
						<cfqueryparam value="#arguments.article.getTitle()#" cfsqltype="cf_sql_varchar" maxlength="500" />,
						<cfqueryparam value="#arguments.article.getContent()#" cfsqltype="cf_sql_longvarchar" />,
						<cfqueryparam value="#arguments.article.getAudit().getCreatedByID()#" cfsqltype="cf_sql_char" maxlength="35" />,
						<cfqueryparam value="#arguments.article.getAudit().getDTCreated()#" cfsqltype="cf_sql_bigint" />,
						<cfqueryparam value="#arguments.article.getAudit().getIPCreated()#" cfsqltype="cf_sql_varchar" maxlength="15" />,
						<cfqueryparam value="#arguments.article.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
					)
				</cfquery>
				<cfcatch type="database">
					<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
		
			<cfloop index="i" from="1" to="#arrayLen(categories)#" step="1">
				<cftry>
					<cfquery name="insertCategory" datasource="#getDatasource().getDSN()#" 
							username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
						INSERT INTO article_category (
							article_id, 
							category_id
						) VALUES (
							<cfqueryparam value="#arguments.article.getArticleID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
							<cfqueryparam value="#categories[i].getCategoryID()#" cfsqltype="cf_sql_char" maxlength="35" />
						)
					</cfquery>
					<cfcatch type="database">
						<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
					</cfcatch>
				</cftry>
			</cfloop>
			
			<cfloop index="i" from="1" to="#arrayLen(authors)#" step="1">
				<cftry>
					<cfquery name="insertAuthor" datasource="#getDatasource().getDSN()#" 
							username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
						INSERT INTO article_author (
							article_id, 
							author_id
						) VALUES (
							<cfqueryparam value="#arguments.article.getArticleID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
							<cfqueryparam value="#authors[i].getPersonID()#" cfsqltype="cf_sql_char" maxlength="35" />
						)
					</cfquery>
					<cfcatch type="database">
						<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
					</cfcatch>
				</cftry>
			</cfloop>
			
			<cfif not error>
				<cftransaction action="commit" />
			<cfelse>
				<cftransaction action="rollback" />
			</cfif>
		</cftransaction>
		
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates an article">
		<cfargument name="article" type="Article" required="true" />
		
		<cfset var updateArticle = 0 />
		<cfset var deleteCategories = 0>
		<cfset var insertCategory = 0>
		<cfset var deleteAuthors = 0>
		<cfset var insertAuthor = 0>
		<cfset var categories = arguments.article.getCategories() />
		<cfset var authors = arguments.article.getAuthors() />
		<cfset var i = 0>
		<cfset var error = false />
		
		<cftransaction action="begin">
			<cftry>
				<cfquery name="updateArticle" datasource="#getDatasource().getDSN()#" 
							username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					UPDATE	article
					SET		title = <cfqueryparam value="#arguments.article.getTitle()#" cfsqltype="cf_sql_varchar" maxlength="500" />,
							content = <cfqueryparam value="#arguments.article.getContent()#" cfsqltype="cf_sql_longvarchar" />,
							modified_by_id = <cfqueryparam value="#arguments.article.getAudit().getModifiedByID()#" cfsqltype="cf_sql_char" 
													maxlength="35" null="#not len(arguments.article.getAudit().getModifiedByID())#" />,
							dt_modified = <cfqueryparam value="#arguments.article.getAudit().getDTModified()#" cfsqltype="cf_sql_bigint" 
												null="#not len(arguments.article.getAudit().getDTModified())#" />,
							ip_modified = <cfqueryparam value="#arguments.article.getAudit().getIPModified()#" cfsqltype="cf_sql_varchar" 
													maxlength="15" null="#not len(arguments.article.getAudit().getIPModified())#" />,
							is_active = <cfqueryparam value="#arguments.article.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
					WHERE	article_id = <cfqueryparam value="#arguments.article.getArticleID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
			
			<cftry>
				<cfquery name="deleteCategories" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM article_category
					WHERE article_id = <cfqueryparam value="#arguments.article.getArticleID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
			
			<cfloop index="i" from="1" to="#arrayLen(categories)#" step="1">
				<cftry>
					<cfquery name="insertCategory" datasource="#getDatasource().getDSN()#" 
							username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
						INSERT INTO article_category (
							article_id, 
							category_id
						) VALUES (
							<cfqueryparam value="#arguments.article.getArticleID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
							<cfqueryparam value="#categories[i].getCategoryID()#" cfsqltype="cf_sql_char" maxlength="35" />
						)
					</cfquery>
					<cfcatch type="database">
						<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
					</cfcatch>
				</cftry>
			</cfloop>
			
			<cftry>
				<cfquery name="deleteAuthors" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM article_author
					WHERE article_id = <cfqueryparam value="#arguments.article.getArticleID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
			
			<cfloop index="i" from="1" to="#arrayLen(authors)#" step="1">
				<cftry>
					<cfquery name="insertAuthor" datasource="#getDatasource().getDSN()#" 
							username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
						INSERT INTO article_author (
							article_id, 
							author_id
						) VALUES (
							<cfqueryparam value="#arguments.article.getArticleID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
							<cfqueryparam value="#authors[i].getPersonID()#" cfsqltype="cf_sql_char" maxlength="35" />
						)
					</cfquery>
					<cfcatch type="database">
						<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
					</cfcatch>
				</cftry>
			</cfloop>
			
			<cfif not error>
				<cftransaction action="commit" />
			<cfelse>
				<cftransaction action="rollback" />
			</cfif>
		</cftransaction>
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes an article">
		<cfargument name="article" type="Article" required="true" />
		
		<cfset var deleteArticle = 0 />
		<cfset var deleteCategories = 0>
		<cfset var deleteAuthors = 0>
		<cfset var i = 0>
		<cfset var error = false />
		
		<cftransaction action="begin">
			<cftry>
				<cfquery name="deleteCategories" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM article_category
					WHERE article_id = <cfqueryparam value="#arguments.article.getArticleID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfset error = true>
					<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
			
			<cftry>
				<cfquery name="deleteAuthors" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM article_author
					WHERE article_id = <cfqueryparam value="#arguments.article.getArticleID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfset error = true>
					<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
				
			<cfif not error>
				<cftry>
					<cfquery name="deleteArticle" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
						DELETE FROM	article 
						WHERE	article_id = <cfqueryparam value="#arguments.article.getArticleID()#" cfsqltype="cf_sql_char" maxlength="35" />
					</cfquery>
					<cfcatch type="database">
						<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
					</cfcatch>
				</cftry>
			</cfif>
			
			<cfif not error>
				<cftransaction action="commit" />
			<cfelse>
				<cftransaction action="rollback" />
			</cfif>
		</cftransaction>
		
	</cffunction>
	
</cfcomponent>