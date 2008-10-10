<cfcomponent 
	displayname="BookGateway_MySQL" 
	output="false" 
	extends="BookGateway" 
	hint="BookGateway - MySQL">
	
	<cffunction name="init" access="public" output="false" returntype="BookGateway">
		<cfreturn this />
	</cffunction>
	
	<!--- gateway methods --->
	<cffunction name="getBooks" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		
		<cfset var books = 0 />

		<cftry>
			<cfquery name="books" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	book.book_id,
						book.title,
						book.publisher_id,
						book.publication_year,
						book.isbn,
						book.num_pages,
						book.price,
						book.url,
						book.cover_image_small,
						book.cover_image_large,
						book.is_active
				FROM 	book 
				<cfif arguments.activeOnly>
				WHERE 	book.is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" /> 
				</cfif>
				ORDER BY book.dt_created DESC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn books />
	</cffunction>
	
	<cffunction name="getBooksAsArray" access="public" output="false" returntype="array">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		
		<cfset var getBookIDs = 0 />
		<cfset var book = 0 />
		<cfset var books = arrayNew(1) />
		
		<cftry>
			<cfquery name="getBookIDs" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	book_id
				FROM 	book
				<cfif arguments.activeOnly>
				WHERE 	is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" /> 
				</cfif>
				ORDER BY book.dt_created DESC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getBookIDs.recordCount gt 0>
			<cfloop query="getArticleIDs">
				<cfset book = getBookService().getBookById(getBookIDs.article_id) />
				<cfset arrayAppend(books, book) />
			</cfloop>
		</cfif>
		
		<cfreturn books />
	</cffunction>
	
</cfcomponent>