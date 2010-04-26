<cfcomponent displayname="SessionService" hint="Service for Session Facade">

	<cffunction name="init" returntype="SessionService" access="public" output="false">
		<cfreturn this/>
	</cffunction>
	
	<!---
	SESSION USER MANAGEMENT
	--->
	<cffunction name="getUser" access="public" returntype="org.capitolhillusergroup.person.Person" output="false">
		<cfreturn getParameter("user") />
	</cffunction>
	
	<cffunction name="setUser" access="public" returntype="void" output="false">
		<cfargument name="user" type="org.capitolhillusergroup.person.Person" required="true" />
		<cfset setParameter("user", arguments.user) />
	</cffunction>
	
	<cffunction name="isAuthenticated" access="public" returntype="boolean" output="false">
		<cfif getParameter("user").getPersonID() is not "">
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>
	
	<!---
	SESSION DATA MANAGEMENT
	--->
	
	<cffunction name="setParameter" access="public" output="false" returntype="void">
		<cfargument name="name" type="string" required="true" hint="name of variable" />
		<cfargument name="value" type="any" required="true" hint="value of variable" />
		
		<cfset validateSession() />
		
		<cflock name="session.storage" timeout="5">
			<cfset session.storage[arguments.name] = arguments.value/>
		</cflock>
	</cffunction>
	
	<cffunction name="getParameter" access="public" output="false" returntype="any">
		<cfargument name="name" type="string" required="true" hint="name of variable" />
		
		<cfset var value = 0 />
		<cfset var error = false />
		
		<cfset validateSession() />
		
		<cflock name="session.storage" timeout="5">
			<cfif structKeyExists(session.storage, arguments.name)>
				<cfset value = session.storage[arguments.name] />
			<cfelse>
				<cfset error = true />
			</cfif>
		</cflock>
		
		<cfif error>
			<cfthrow message="session variable: #arguments.name# is not defined"/>
		<cfelse>
			<cfreturn value />
		</cfif>
	</cffunction>

	<cffunction name="parameterExist" access="public" output="false" returntype="boolean">
		<cfargument name="name" type="string" required="true" hint="name of variable" />
		<cfset var exists = false />
		
		<cfset validateSession() />
		
		<cfif structKeyExists(session.storage, arguments.name)>
			<cfset exists = true />
		</cfif>
		
		<cfreturn exists />
	</cffunction>		
	
	<cffunction name="removeParameter" access="public" output="false" returntype="void">
		<cfargument name="varName" type="string" required="true" hint="name of variable" />
		
		<cfset validateSession() />
		
		<cflock name="session.storage" timeout="5">
			<cfif structKeyExists(session.storage, arguments.name)>
				<cfset structDelete(session.storage, arguments.name)/>
			</cfif>
		</cflock>
	</cffunction>
	
	<cffunction name="initSession" access="public" returntype="void" output="false">
		<cfargument name="user" type="org.capitolhillusergroup.person.Person" required="false" 
				default="#createObject('component', 'org.capitolhillusergroup.person.Person').init()#" />
		
		<cflock name="session.storage" timeout="5">
			<cfset session.uid = createUUID() />
			<cfset session.storage = structNew() />
			<cfset session.storage.user = user />
			<cfset session.storage.startTime = now() />
		</cflock>
	</cffunction>
	
	<!--- 
	PRIVATE METHODS FOR SESSION MANAGEMENT
	--->
	
	<cffunction name="validateSession" access="private" returntype="void" output="false">
		<cfif not StructKeyExists(session, "uid")>
			<cfset initSession() />
		</cfif>
	</cffunction>
	
	<cffunction name="resetSession" access="public" returntype="void" output="false">
		<cfset initSession() />
	</cffunction>
	
	<cffunction name="killSession" access="public" output="false" returntype="void">
		<cfset structDelete(session, "uid", false) />
		<cfset structDelete(session, "storage", false) />
	</cffunction>
	
</cfcomponent>