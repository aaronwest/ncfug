<cfcomponent 
	displayname="RSVPGateway" 
	output="false" 
	hint="Base RSVPGateway">
	
	<cffunction name="init" access="public" output="false" returntype="RSVPGateway">
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
	
	<!--- gateway methods --->
	<cffunction name="rsvpExists" access="public" output="false" returntype="boolean">
		<cfargument name="meetingID" type="string" required="true" />
		<cfargument name="email" type="string" required="true" />
	</cffunction>
	
	<cffunction name="getRSVPsByMeetingID" access="public" output="false" returntype="query">
		<cfargument name="meetingID" type="string" required="true" />
	</cffunction>
	
</cfcomponent>