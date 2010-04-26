<cfcomponent 
	displayname="PresentationGateway" 
	output="false" 
	hint="Base PresentationGateway">
	
	<cffunction name="init" access="public" output="false" returntype="PresentationGateway">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setDatasource" access="public" output="false" returntype="void"
		hint="Dependency: injected">
		<cfargument name="datasource" type="org.capitolhillusergroup.datasource.Datasource" required="true" />
		<cfset variables.datasource = arguments.datasource />
	</cffunction>	
	<cffunction name="getDatasource" access="private" output="false" returntype="org.capitolhillusergroup.datasource.Datasource">
		<cfreturn variables.datasource />
	</cffunction>

	<cffunction name="setPersonService" access="public" output="false" returntype="void">
		<cfargument name="personService" type="org.capitolhillusergroup.person.PersonService" required="true" />
		<cfset variables.personService = arguments.personService />
	</cffunction>
	<cffunction name="getPersonService" access="public" output="false" returntype="org.capitolhillusergroup.person.PersonService">
		<cfreturn variables.personService />
	</cffunction>
	
	<!--- gateway methods --->
	<cffunction name="getPresentationIDsByMeetingID" access="public" output="false" returntype="string" 
			hint="Returns a comma-delimited list of presentation IDs based on the meeting ID passed in">
		<cfargument name="meetingID" type="uuid" required="true" />
	</cffunction>
	
	<cffunction name="getPresentations" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="false" />
	</cffunction>
	
</cfcomponent>