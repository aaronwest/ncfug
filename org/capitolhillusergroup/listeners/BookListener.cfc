<cfcomponent 
	displayname="BookListener" 
	output="false" 
	extends="MachII.framework.Listener">

	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- don't need anything here for now --->
	</cffunction>
	
	<cffunction name="setBookService" access="public" output="false" returntype="void">
		<cfargument name="bookService" type="org.capitolhillusergroup.book.BookService" required="true" />
		<cfset variables.bookService = arguments.bookService />
	</cffunction>
	<cffunction name="getBookService" access="public" output="false" returntype="org.capitolhillusergroup.book.BookService">
		<cfreturn variables.bookService />
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
	
	<cffunction name="getBooks" access="public" output="false" returntype="query">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getBookService().getBooks(arguments.event.getArg("activeOnly", true)) />
	</cffunction>
	
	<cffunction name="getBookByID" access="public" output="false" returntype="org.capitolhillusergroup.book.Book">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getBookService().getBookById(arguments.event.getArg("bookID", "")) />
	</cffunction>
	
	<cffunction name="processBookForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var book = arguments.event.getArg("book") />
		<cfset var action = "" />
		<cfset var message = "" />
		<cfset var categories = ArrayNew(1)>
		<cfset var category = 0>
		<cfset var categoryID = "">
		<cfset var authors = ArrayNew(1)>
		<cfset var author = 0>
		<cfset var authorID = "">
		<cfset var exitEvent = "success" />
		
		<cfset book.getAudit().setIsActive(arguments.event.getArg("isActive", 0)) />
		
		<!--- get the authors if needed --->
		<cfif arguments.event.getArg("authorIDs", "") is not "">
			<cfloop list="#arguments.event.getArg('authorIDs')#" index="authorID">
				<cfset author = getPersonService().getPersonByID(authorID) />
				<cfset arrayAppend(authors, author) />
			</cfloop>
		</cfif>
		
		<cfset book.setAuthors(authors) />
		
		<!--- get the categories if needed --->
		<cfif arguments.event.getArg("categoryIDs", "") is not "">
			<cfloop list="#arguments.event.getArg('categoryIDs')#" index="categoryID">
				<cfset category = getCategoryService().getCategoryByID(categoryID) />
				<cfset arrayAppend(categories, category) />
			</cfloop>
		</cfif>
		
		<cfset book.setCategories(categories) />
		
		<cfif book.getBookID() is "">
			<cfset action = "add" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addbooksuccessful") />
			<cfset book.getAudit().setCreatedByID(getSessionService().getUser().getPersonID()) />
			<cfset book.getAudit().setDTCreated(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset book.getAudit().setIPCreated(CGI.REMOTE_ADDR) />
		<cfelse>
			<cfset action = "update" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("updatebooksuccessful") />
			<cfset book.getAudit().setModifiedByID(getSessionService().getUser().getPersonID()) />
			<cfset book.getAudit().setDTModified(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset book.getAudit().setIPModified(CGI.REMOTE_ADDR) />
		</cfif>
		
		<cftry>
			<cfset getBookService().saveBook(book) />
			<cfcatch type="any">
				<cfrethrow>
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addupdatebookfailed") />
				
				<cfif action is "add">
					<cfset book.setBookID("") />
				</cfif>
				
				<cfset arguments.event.setArg("book", book) />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="deleteBook" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("deletebooksuccessful") />
		<cfset var book = getBookService().getBookByID(arguments.event.getArg("bookID")) />

		<cftry>
			<cfset getBookService().deleteBook(book) />
			<cfcatch type="any">
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("deletebookfailed") />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent("exitEvent", arguments.event.getArgs()) />
	</cffunction>
	
</cfcomponent>