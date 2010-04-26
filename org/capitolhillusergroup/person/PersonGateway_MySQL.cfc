<cfcomponent 
	displayname="PersonGateway_MySQL" 
	output="false" 
	extends="PersonGateway"
	hint="PersonGateway - MySQL">
	
	<cffunction name="init" access="public" output="false" returntype="PersonGateway">
		<cfreturn this />
	</cffunction>
	
	<!--- gateway methods --->
	<cffunction name="getPresenterIDsByPresentationID" access="public" output="false" returntype="string" 
			hint="Returns a comma-delimited list of presenter IDs for a particular presentation">
		<cfargument name="presentationID" type="uuid" required="true" />
		
		<cfset var getPresenterIDs = 0 />
		<cfset var presenterIDs = "" />
		
		<cftry>
			<cfquery name="getPresenterIDs" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	presentation_presenter.presenter_id, 
						person.last_name 
				FROM 	presentation_presenter 
				INNER JOIN person ON presentation_presenter.presenter_id = person.person_id 
				WHERE presentation_id = <cfqueryparam value="#arguments.presentationID#" cfsqltype="cf_sql_char" maxlength="35" /> 
				ORDER BY person.last_name ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfloop query="getPresenterIDs">
			<cfset presenterIDs = listAppend(presenterIDs, getPresenterIDs.presenter_id, ",") />
		</cfloop>
		
		<cfreturn presenterIDs />
	</cffunction>
	
	<cffunction name="getAuthorIDsByArticleID" access="public" output="false" returntype="string" 
			hint="Returns a comma-delimited list of author IDs for a particular article">
		<cfargument name="articleID" type="uuid" required="true" />
		
		<cfset var getAuthorIDs = 0 />
		<cfset var authorIDs = "" />
		
		<cftry>
			<cfquery name="getAuthorIDs" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	article_author.author_id, 
						person.last_name 
				FROM 	article_author
				INNER JOIN person ON article_author.author_id = person.person_id 
				WHERE article_id = <cfqueryparam value="#arguments.articleID#" cfsqltype="cf_sql_char" maxlength="35" /> 
				ORDER BY person.last_name ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfloop query="getAuthorIDs">
			<cfset authorIDs = listAppend(authorIDs, getAuthorIDs.author_id, ",") />
		</cfloop>
		
		<cfreturn authorIDs />
	</cffunction>
	
	<cffunction name="getAuthorIDsByBookID" access="public" output="false" returntype="string" 
			hint="Returns a comma-delimited list of author IDs for a particular book">
		<cfargument name="bookID" type="uuid" required="true" />
		
		<cfset var getAuthorIDs = 0 />
		<cfset var authorIDs = "" />
		
		<cftry>
			<cfquery name="getAuthorIDs" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	book_author.author_id, 
						person.last_name 
				FROM 	book_author
				INNER JOIN person ON book_author.author_id = person.person_id 
				WHERE book_id = <cfqueryparam value="#arguments.bookID#" cfsqltype="cf_sql_char" maxlength="35" /> 
				ORDER BY person.last_name ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfloop query="getAuthorIDs">
			<cfset authorIDs = listAppend(authorIDs, getAuthorIDs.author_id, ",") />
		</cfloop>
		
		<cfreturn authorIDs />
	</cffunction>

	<cffunction name="getPersonIDByCredentials" access="public" output="false" returntype="string">
		<cfargument name="email" type="string" required="true" />
		<cfargument name="password" type="string" required="true" />
		
		<cfset var getPersonID = 0 />
		<cfset var personID = "" />
		
		<cfif arguments.password is not "">
			<cftry>
				<cfquery name="getPersonID" datasource="#getDatasource().getDSN()#" 
							username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					SELECT person_id 
					FROM person 
					WHERE email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar" maxlength="250" /> 
					AND password = <cfqueryparam value="#arguments.password#" cfsqltype="cf_sql_varchar" maxlength="50" />
				</cfquery>
				<cfcatch type="database">
					<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
			
			<cfif getPersonID.recordCount eq 1>
				<cfset personID = getPersonID.person_id />
			</cfif>
		</cfif>
		
		<cfreturn personID />
	</cffunction>
	
	<cffunction name="getPeople" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="false" />
		
		<cfset var getPeople = 0 />
		
		<cftry>
			<cfquery name="getPeople" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	person.person_id, 
						person.first_name, 
						person.last_name, 
						person.email, 
						person.role_id, 
						person.is_admin, 
						person.is_active, 
						role.role 
				FROM 	person 
				LEFT OUTER JOIN role ON person.role_id = role.role_id 
			<cfif arguments.activeOnly>
				WHERE 	person.is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" />
			</cfif>
				ORDER BY person.last_name, person.first_name ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn getPeople />
	</cffunction>
	
	<cffunction name="deleteIMsByIMTypeID" access="public" output="false" returntype="void">
		<cfargument name="imTypeID" type="string" required="true" />
		
		<cfset var deleteIMs = 0 />
		
		<cftry>
			<cfquery name="deleteIMs" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				DELETE FROM person_im 
				WHERE im_type_id = <cfqueryparam value="#arguments.imTypeID#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="getPersonIDByEmail" access="public" output="false" returntype="string">
		<cfargument name="email" type="string" required="true" />
		
		<cfset var getPersonID = 0 />
		<cfset var personID = "" />
		
		<cftry>
			<cfquery name="getPersonID" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT person_id 
				FROM person 
				WHERE email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar" maxlength="100" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getPersonID.recordCount gt 0>
			<cfset personID = getPersonID.person_id />
		</cfif>
		
		<cfreturn personID />
	</cffunction>

</cfcomponent>