<cfcomponent displayname="SecurityService" output="false" hint="SecurityService for CHUG">

	<cffunction name="init" access="public" output="false" returntype="SecurityService" hint="Constructor">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
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
	
	<!--- service methods --->
	<cffunction name="getPersonByCredentials" access="public" output="false" returntype="org.capitolhillusergroup.person.Person">
		<cfargument name="email" type="string" required="true" />
		<cfargument name="password" type="string" required="true" />
		
		<cfreturn getPersonService().getPersonByCredentials(arguments.email, arguments.password) />
	</cffunction>
	
	<cffunction name="getPersonByEmail" access="public" output="false" returntype="org.capitolhillusergroup.person.Person">
		<cfargument name="email" type="string" required="true" />
		
		<cfreturn getPersonService().getPersonByEmail(arguments.email) />
	</cffunction>
	
	<cffunction name="getAuthenticationType" access="public" returntype="string" output="false">
		<cfset var user = getSessionService().getUser() />
		
		<cfif user.getIsAdmin()>
			<cfreturn "admin" />
		<cfelseif not user.getIsAdmin() and user.getPersonID() is not "">
			<cfreturn "member" />
		<cfelse>
			<cfreturn "none" />
		</cfif>
	</cffunction>
	
	<cffunction name="isAuthenticated" access="public" output="false" returntype="boolean">
		<cfif getSessionService().getUser().getPersonID() is not "">
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>
	
	<cffunction name="removeUserSession" access="public" returntype="void" output="false">
		<cfset getSessionService().resetSession() />
	</cffunction>
	
	<cffunction name="authenticate" access="public" output="false" returntype="org.capitolhillusergroup.person.Person">
		<cfargument name="email" type="string" required="true"/>
		<cfargument name="password" type="string" required="true"/>
		
		<cfset var user = getPersonByCredentials(arguments.email, arguments.password) />
		
		<cfif user.getPersonID() is not "" and user.getAudit().getIsActive()>
			<!--- store validated user in session --->
			<cfset getSessionService().setUser(user) />
		<cfelse>
			<cfset getSessionService().resetSession() />
		</cfif>
		
		<cfreturn user/>
	</cffunction>
	
	<cffunction name="forgotPassword" access="public" output="false" returntype="org.capitolhillusergroup.person.Person">
		<cfargument name="email" type="string" required="true"/>
		
		<cfset var user = getPersonByEmail(arguments.email) />
		
		<cfreturn user/>
	</cffunction>

</cfcomponent>
