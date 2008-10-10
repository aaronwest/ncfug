<cfcomponent 
	displayname="BookService" 
	output="false" 
	hint="BookService">

	<cffunction name="init" access="public" output="false" returntype="BookService">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setBookDAO" access="public" output="false" returntype="void">
		<cfargument name="bookDAO" type="BookDAO" required="true" />
		<cfset variables.bookDAO = arguments.bookDAO />
	</cffunction>
	<cffunction name="getBookDAO" access="public" output="false" returntype="BookDAO">
		<cfreturn variables.bookDAO />
	</cffunction>
	
	<cffunction name="setBookGateway" access="public" output="false" returntype="void">
		<cfargument name="bookGateway" type="BookGateway" required="true" />
		<cfset variables.bookGateway = arguments.bookGateway />
	</cffunction>
	<cffunction name="getBookGateway" access="public" output="false" returntype="BookGateway">
		<cfreturn variables.bookGateway />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getBooks" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		
		<cfreturn getBookGateway().getBooks(arguments.activeOnly) />
	</cffunction>
	
	<cffunction name="getBookByID" access="public" output="false" returntype="Book">
		<cfargument name="bookID" type="string" required="true" />
		
		<cfset var book = createObject("component", "Book").init(arguments.bookID) />
		
		<cfif arguments.bookID is not "">
			<cfset getBookDAO().fetch(book) />
		</cfif>
		
		<cfreturn book />
	</cffunction>
	
	<cffunction name="saveBook" access="public" output="false" returntype="void">
		<cfargument name="book" type="Book" required="true" />
		
		<cfset getBookDAO().save(arguments.book) />
	</cffunction>
	
	<cffunction name="deleteBook" access="public" output="false" returntype="void">
		<cfargument name="book" type="Book" required="true" />
		
		<cfset getBookDAO().delete(arguments.book) />
	</cffunction>
	
</cfcomponent>