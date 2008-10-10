<cfcomponent 
	displayname="BookDAO_MySQL" 
	output="false" 
	extends="BookDAO" 
	hint="BookDAO - MySQL">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" output="false" returntype="BookDAO" hint="Constructor for this CFC.">
		<cfreturn this />
	</cffunction>

	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates a book bean">
		<cfargument name="book" type="Book" required="true" />
		
		<cfset var getBook = 0 />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var dtModified = createDate(1900, 1, 1) />
		<cfset var reviewDate = createDate(1900, 1, 1) />
		<cfset var reviewer = createObject("component", "org.capitolhillusergroup.person.Person").init() />
		<cfset var authors = ArrayNew(1)>
		<cfset var categories = ArrayNew(1)>
		
		<cftry>
			<cfquery name="getBook" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 
				book.book_id, 
				book.title, 
				book.publisher_id, 
				book.publication_year, 
				book.isbn,
				book.num_pages,
				book.price,
				book.url,
				book.cover_image_small,	
				book.cover_image_large,
				book.created_by_id,
				book.dt_created, 
				book.ip_created, 
				book.modified_by_id,
				book.dt_modified, 
				book.ip_modified,
				book.is_active,
				cb.first_name AS cbfn, 
				cb.last_name AS cbln, 
				mb.first_name AS mbfn, 
				mb.last_name AS mbln 
				FROM	book 
				LEFT OUTER JOIN person AS cb 
					ON book.created_by_id = cb.person_id 
				LEFT OUTER JOIN person AS mb 
					ON book.modified_by_id = mb.person_id 
				WHERE	book.book_id = <cfqueryparam value="#arguments.book.getBookID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getBook.recordCount eq 1>
			<cfif getBook.dt_modified is not "">
				<cfset dtModified = getBook.dt_modified />
			</cfif>
			
			<cfset authors = getPersonService().getAuthorsByBookID(getBook.book_id) />
			<cfset categories = getCategoryService().getCategoriesByBookID(getBook.book_id) />
			
			<cfset audit.init(getBook.created_by_id, getBook.cbfn & " " & getBook.cbln, getBook.dt_created, getBook.ip_created, 
								getBook.modified_by_id, getBook.mbfn & " " & getBook.mbln, dtModified, getBook.ip_modified, 
								getBook.is_active) />
			
			<cfset arguments.book.setBookID(getBook.book_id) />
			<cfset arguments.book.setTitle(getBook.title) />
			<!--- publisher_id --->
			<cfset arguments.book.setPublicationYear(getBook.publication_year) />
			<cfset arguments.book.setNumPages(getBook.num_pages)>
			<cfset arguments.book.setPrice(getBook.price)>
			<cfset arguments.book.setIsbn(getBook.isbn)>
			<cfset arguments.book.setUrl(getBook.url)>
			<cfset arguments.book.setCoverImageSmall(getBook.cover_image_small)>
			<cfset arguments.book.setCoverImageLarge(getBook.cover_image_large)>
			<cfset arguments.book.setAuthors(authors)>
			<cfset arguments.book.setCategories(categories)>
			<cfset arguments.book.setAudit(audit) />
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves a book">
		<cfargument name="book" type="Book" required="true" />
		
		<cfif arguments.book.getBookID() is "">
			<cfset arguments.book.setBookID(createUUID()) />
			<cfset create(arguments.book) />
		<cfelse>
			<cfset update(arguments.book) />
		</cfif>
	</cffunction>

	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new book">
		<cfargument name="book" type="Book" required="true" />
		
		<cfset var insertBook = 0 />
		<cfset var insertCategory = 0>
		<cfset var insertAuthor = 0>
		<cfset var categories = arguments.book.getCategories() />
		<cfset var authors = arguments.book.getAuthors() />
		<cfset var i = 0>
		<cfset var error = false />
		
		<cftransaction action="begin">
			<cftry>
				<cfquery name="insertBook" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					INSERT INTO book (
						book_id, 
						title, 
						publisher_id, 
						publication_year, 
						isbn,
						num_pages,
						price,
						url,
						cover_image_small,	
						cover_image_large,
						created_by_id,
						dt_created,
						ip_created,
						is_active
					) VALUES (
						<cfqueryparam value="#arguments.book.getBookID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						<cfqueryparam value="#arguments.book.getTitle()#" cfsqltype="cf_sql_varchar" maxlength="500" />, 
						<cfqueryparam value="#CreateUUID()#" cfsqltype="cf_sql_varchar" maxlength="500" />, 
						<cfqueryparam value="#arguments.book.getPublicationYear()#" cfsqltype="cf_sql_smallint" />,
						<cfqueryparam value="#arguments.book.getIsbn()#" cfsqltype="cf_sql_varchar" maxlength="20" />,
						<cfqueryparam value="#arguments.book.getNumPages()#" cfsqltype="cf_sql_smallint" null="#not len(arguments.book.getNumPages())#" />,
						<cfqueryparam value="#arguments.book.getPrice()#" cfsqltype="cf_sql_smallint" null="#not len(arguments.book.getPrice())#" />,
						<cfqueryparam value="#arguments.book.getUrl()#" cfsqltype="cf_sql_varchar" maxlength="255" null="#not len(arguments.book.getUrl())#" />,
						<cfqueryparam value="#arguments.book.getCoverImageSmall()#" cfsqltype="cf_sql_varchar" maxlength="255" null="#not len(arguments.book.getCoverImageSmall())#" />,
						<cfqueryparam value="#arguments.book.getCoverImageLarge()#" cfsqltype="cf_sql_varchar" maxlength="255" null="#not len(arguments.book.getCoverImageLarge())#" />,
						<cfqueryparam value="#arguments.book.getAudit().getCreatedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						<cfqueryparam value="#arguments.book.getAudit().getDTCreated()#" cfsqltype="cf_sql_bigint" />, 
						<cfqueryparam value="#arguments.book.getAudit().getIPCreated()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
						<cfqueryparam value="#arguments.book.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
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
						INSERT INTO book_category (
							book_id, 
							category_id
						) VALUES (
							<cfqueryparam value="#arguments.book.getBookID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
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
						INSERT INTO book_author (
							book_id, 
							author_id
						) VALUES (
							<cfqueryparam value="#arguments.book.getBookID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
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

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates a book">
		<cfargument name="book" type="Book" required="true" />
		
		<cfset var updateBook = 0 />
		<cfset var deleteCategories = 0>
		<cfset var insertCategory = 0>
		<cfset var deleteAuthors = 0>
		<cfset var insertAuthor = 0>
		<cfset var categories = arguments.book.getCategories() />
		<cfset var authors = arguments.book.getAuthors() />
		<cfset var i = 0>
		<cfset var error = false />
		
		<cftransaction action="begin">
			<cftry>
				<cfquery name="updateBook" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					
					UPDATE book 
					SET 	title = <cfqueryparam value="#arguments.book.getTitle()#" cfsqltype="cf_sql_varchar" maxlength="500" />, 
							<!--- publisher_id,  --->
							publication_year = <cfqueryparam value="#arguments.book.getPublicationYear()#" cfsqltype="cf_sql_smallint" />, 
							isbn = <cfqueryparam value="#arguments.book.getIsbn()#" cfsqltype="cf_sql_varchar" maxlength="20" />,
							num_pages = <cfqueryparam value="#arguments.book.getNumPages()#" cfsqltype="cf_sql_smallint" null="#not len(arguments.book.getNumPages())#" />,
							price = <cfqueryparam value="#arguments.book.getPrice()#" cfsqltype="cf_sql_smallint" null="#not len(arguments.book.getPrice())#" />,
							url = <cfqueryparam value="#arguments.book.getUrl()#" cfsqltype="cf_sql_varchar" maxlength="255" null="#not len(arguments.book.getUrl())#" />,
							cover_image_small = <cfqueryparam value="#arguments.book.getCoverImageSmall()#" cfsqltype="cf_sql_varchar" maxlength="255" null="#not len(arguments.book.getCoverImageSmall())#" />,
							cover_image_large = <cfqueryparam value="#arguments.book.getCoverImageLarge()#" cfsqltype="cf_sql_varchar" maxlength="255" null="#not len(arguments.book.getCoverImageLarge())#" />,
							modified_by_id = <cfqueryparam value="#arguments.book.getAudit().getModifiedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
							dt_modified = <cfqueryparam value="#arguments.book.getAudit().getDTModified()#" cfsqltype="cf_sql_bigint" />, 
							ip_modified = <cfqueryparam value="#arguments.book.getAudit().getIPModified()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
							is_active = <cfqueryparam value="#arguments.book.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" /> 
					WHERE 	book_id = <cfqueryparam value="#arguments.book.getBookID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
		
			<cftry>
				<cfquery name="deleteCategories" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM book_category
					WHERE book_id = <cfqueryparam value="#arguments.book.getBookID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
			
			<cfloop index="i" from="1" to="#arrayLen(categories)#" step="1">
				<cftry>
					<cfquery name="insertCategory" datasource="#getDatasource().getDSN()#" 
							username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
						INSERT INTO book_category (
							book_id, 
							category_id
						) VALUES (
							<cfqueryparam value="#arguments.book.getBookID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
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
					DELETE FROM book_author
					WHERE book_id = <cfqueryparam value="#arguments.book.getBookID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
			
			<cfloop index="i" from="1" to="#arrayLen(authors)#" step="1">
				<cftry>
					<cfquery name="insertAuthor" datasource="#getDatasource().getDSN()#" 
							username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
						INSERT INTO book_author (
							book_id, 
							author_id
						) VALUES (
							<cfqueryparam value="#arguments.book.getBookID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
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
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes a book">
		<cfargument name="book" type="Book" required="true" />
		
		<cfset var deleteBook = 0 />
		<cfset var deleteCategories = 0>
		<cfset var deleteAuthors = 0>
		<cfset var i = 0>
		<cfset var error = false />
		
		<cftransaction action="begin">
			<cftry>
				<cfquery name="deleteCategories" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM book_category
					WHERE book_id = <cfqueryparam value="#arguments.book.getBookID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfset error = true>
					<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
			
			<cftry>
				<cfquery name="deleteAuthors" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM book_author
					WHERE book_id = <cfqueryparam value="#arguments.book.getBookID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfset error = true>
					<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
			
			<cftry>
				<cfquery name="deleteBook" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM book 
					WHERE 	book_id = <cfqueryparam value="#arguments.book.getBookID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
			
			<cfif not error>
				<cftransaction action="commit" />
			<cfelse>
				<cftransaction action="rollback" />
			</cfif>
		</cftransaction>
		
	</cffunction>
	
</cfcomponent>