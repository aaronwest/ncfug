<cfcomponent 
	displayname="PersonService" 
	output="false" 
	hint="PersonService">

	<cffunction name="init" access="public" output="false" returntype="PersonService">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setPersonDAO" access="public" output="false" returntype="void">
		<cfargument name="personDAO" type="PersonDAO" required="true" />
		<cfset variables.personDAO = arguments.personDAO />
	</cffunction>
	<cffunction name="getPersonDAO" access="public" output="false" returntype="PersonDAO">
		<cfreturn variables.personDAO />
	</cffunction>
	
	<cffunction name="setPersonGateway" access="public" output="false" returntype="void">
		<cfargument name="personGateway" type="PersonGateway" required="true" />
		<cfset variables.personGateway = arguments.personGateway />
	</cffunction>
	<cffunction name="getPersonGateway" access="public" output="false" returntype="PersonGateway">
		<cfreturn variables.personGateway />
	</cffunction>
	
	<cffunction name="setIMService" access="public" output="false" returntype="void">
		<cfargument name="imService" type="org.capitolhillusergroup.im.IMService" required="true" />
		<cfset variables.imService = arguments.imService />
	</cffunction>
	<cffunction name="getIMService" access="public" output="false" returntype="org.capitolhillusergroup.im.IMService">
		<cfreturn variables.imService />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getPersonBean" access="public" output="false" returntype="Person">
		<cfreturn createObject("component", "Person").init() />
	</cffunction>
	
	<cffunction name="getPersonByID" access="public" output="false" returntype="Person">
		<cfargument name="personID" type="string" required="true" />
		
		<cfset var person = getPersonBean() />
		<cfset person.setPersonID(arguments.personID) />
		
		<cfif arguments.personID is not "">
			<cfset getPersonDAO().fetch(person) />
		</cfif>
		
		<cfreturn person />
	</cffunction>
	
	<cffunction name="getPersonByEmail" access="public" output="false" returntype="Person">
		<cfargument name="email" type="string" required="true" />
		
		<cfreturn getPersonByID(getPersonIDByEmail(arguments.email)) />
	</cffunction>
	
	<cffunction name="getPersonIDByEmail" access="public" output="false" returntype="string">
		<cfargument name="email" type="string" required="true" />
		
		<cfreturn getPersonGateway().getPersonIDByEmail(arguments.email) />
	</cffunction>
	
	<cffunction name="getPersonByCredentials" access="public" output="false" returntype="Person">
		<cfargument name="email" type="string" required="true" />
		<cfargument name="password" type="string" required="true" />
		
		<cfreturn getPersonByID(getPersonGateway().getPersonIDByCredentials(arguments.email, arguments.password)) />
	</cffunction>
	
	<cffunction name="getPresentersByPresentationID" access="public" output="false" returntype="array" 
			hint="Returns an array of person beans representing presenters for a particular presentation">
		<cfargument name="presentationID" type="uuid" required="true" />
		
		<cfset var presenters = arrayNew(1) />
		<cfset var presenter = 0 />
		<cfset var presenterIDs = getPersonGateway().getPresenterIDsByPresentationID(arguments.presentationID) />
		<cfset var presenterID = "" />
		
		<cfif listLen(presenterIDs) gt 0>
			<cfloop index="presenterID" list="#presenterIDs#" delimiters=",">
				<cfset presenter = getPersonByID(presenterID) />
				<cfset arrayAppend(presenters, presenter) />
			</cfloop>
		</cfif>
		
		<cfreturn presenters />
	</cffunction>
	
	<cffunction name="getAuthorsByArticleID" access="public" output="false" returntype="array" 
			hint="Returns an array of person beans representing authors for a particular article">
		<cfargument name="articleID" type="uuid" required="true" />
		
		<cfset var authors = arrayNew(1) />
		<cfset var author = 0 />
		<cfset var authorIDs = getPersonGateway().getAuthorIDsByArticleID(arguments.articleID) />
		<cfset var authorID = "" />
		
		<cfif listLen(authorIDs) gt 0>
			<cfloop index="authorID" list="#authorIDs#" delimiters=",">
				<cfset author = getPersonByID(authorID) />
				<cfset arrayAppend(authors, author) />
			</cfloop>
		</cfif>
		
		<cfreturn authors />
	</cffunction>
	
	<cffunction name="getAuthorsByBookID" access="public" output="false" returntype="array" 
			hint="Returns an array of person beans representing authors for a particular book">
		<cfargument name="bookID" type="uuid" required="true" />
		
		<cfset var authors = arrayNew(1) />
		<cfset var author = 0 />
		<cfset var authorIDs = getPersonGateway().getAuthorIDsByBookID(arguments.bookID) />
		<cfset var authorID = "" />
		
		<cfif listLen(authorIDs) gt 0>
			<cfloop index="authorID" list="#authorIDs#" delimiters=",">
				<cfset author = getPersonByID(authorID) />
				<cfset arrayAppend(authors, author) />
			</cfloop>
		</cfif>
		
		<cfreturn authors />
	</cffunction>
	
	<cffunction name="getIMsByPersonID" access="public" output="false" returntype="array">
		<cfargument name="personID" type="string" required="true" />
		<cfreturn getPersonGateway().getIMsByPersonID(arguments.personID) />
	</cffunction>
	
	<cffunction name="deleteIMsByIMTypeID" access="public" output="false" returntype="void">
		<cfargument name="imTypeID" type="string" required="true" />
		<cfset getPersonGateway().deleteIMsByIMTypeID(arguments.imTypeID) />
	</cffunction>
	
	<cffunction name="getPeople" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="false" />
		<cfreturn getPersonGateway().getPeople(arguments.activeOnly) />
	</cffunction>
	
	<cffunction name="savePerson" access="public" output="false" returntype="void">
		<cfargument name="person" type="Person" required="true" />
		<cfset getPersonDAO().save(arguments.person) />
	</cffunction>
	
	<cffunction name="deletePerson" access="public" output="false" returntype="void">
		<cfargument name="person" type="Person" required="true" />
		<cfset getPersonDAO().delete(arguments.person) />
	</cffunction>
	
	<cffunction name="updateStatusPerson" access="public" output="false" returntype="void">
		<cfargument name="person" type="Person" required="true" />
		<cfargument name="status" type="boolean" required="false" default="0" />
		<cfset getPersonDAO().updateStatus(arguments.person,arguments.status) />
	</cffunction>
	
</cfcomponent>