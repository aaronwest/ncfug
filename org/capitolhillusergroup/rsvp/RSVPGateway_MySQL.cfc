<cfcomponent 
	displayname="RSVPGateway_MySQL" 
	output="false" 
	extends="RSVPGateway" 
	hint="RSVPGateway - MySQL">
	
	<cffunction name="init" access="public" output="false" returntype="RSVPGateway">
		<cfreturn this />
	</cffunction>
	
	<!--- gateway methods --->
	<cffunction name="rsvpExists" access="public" output="false" returntype="boolean">
		<cfargument name="meetingID" type="string" required="true" />
		<cfargument name="email" type="string" required="true" />
		
		<cfset var checkRSVP = 0 />
		<cfset var rsvpExists = false />
		
		<cftry>
			<cfquery name="checkRSVP" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT rsvp_id 
				FROM rsvp 
				WHERE meeting_id = <cfqueryparam value="#arguments.meetingID#" cfsqltype="cf_sql_char" maxlength="35" /> 
				AND email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar" maxlength="100" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif checkRSVP.recordCount gt 0>
			<cfset rsvpExists = true />
		</cfif>
		
		<cfreturn rsvpExists />
	</cffunction>

	<cffunction name="getRSVPsByMeetingID" access="public" output="false" returntype="query">
		<cfargument name="meetingID" type="string" required="true" />
		
		<cfset var getRSVPs = 0 />
		
		<cftry>
			<cfquery name="getRSVPs" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	rsvp_id, 
						meeting_id, 
						person_id, 
						first_name, 
						last_name, 
						email, 
						comments, 
						dt_created 
				FROM 	rsvp 
				WHERE 	meeting_id = <cfqueryparam value="#arguments.meetingID#" cfsqltype="cf_sql_char" maxlength="35" /> 
				ORDER BY last_name, first_name ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn getRSVPs />
	</cffunction>
</cfcomponent>