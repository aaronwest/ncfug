<cfcomponent 
	displayname="PresentationGateway_MySQL" 
	output="false" 
	extends="PresentationGateway" 
	hint="PresentationGateway - MySQL">
	
	<cffunction name="init" access="public" output="false" returntype="PresentationGateway">
		<cfreturn this />
	</cffunction>
	
	<!--- gateway methods --->
	<cffunction name="getPresentations" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="false" />
		<cfargument name="orderBy" type="string" required="false" default="date" />
		
		<cfset var getPresentations = 0 />
		<cfset var orderByClause = "" />
		
		<cfswitch expression="#arguments.orderBy#">
			<cfcase value="date">
				<cfset orderByClause = "presentation.dt_created DESC" />
			</cfcase>
			
			<cfcase value="title">
				<cfset orderByClause = "presentation.title ASC" />
			</cfcase>
			
			<cfdefaultcase>
				<cfset orderByClause = "presentation.dt_created DESC" />
			</cfdefaultcase>
		</cfswitch>
		
		<cftry>
			<cfquery name="getPresentations" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	presentation.presentation_id, 
						presentation.title, 
						presentation.summary, 
						presentation.created_by_id, 
						presentation.dt_created, 
						presentation.ip_created, 
						presentation.modified_by_id, 
						presentation.dt_modified, 
						presentation.ip_modified, 
						presentation.is_active 
				FROM 	presentation 
			<cfif arguments.activeOnly>
				WHERE 	presentation.is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" /> 
			</cfif>
				ORDER BY #orderByClause#
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn getPresentations />
	</cffunction>
	
	<cffunction name="getPresentationIDsByMeetingID" access="public" output="false" returntype="string" 
			hint="Returns a comma-delimited list of presentation IDs based on the meeting ID passed in">
		<cfargument name="meetingID" type="uuid" required="true" />

		<cfset var getPresentationIDs = 0 />
		<cfset var presentationIDs = "" />
		
		<cftry>
			<cfquery name="getPresentationIDs" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT presentation_id 
				FROM meeting_presentation 
				WHERE meeting_id = <cfqueryparam value="#arguments.meetingID#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getPresentationIDs.recordCount gt 0>
			<cfloop query="getPresentationIDs">
				<cfset presentationIDs = listAppend(presentationIDs, getPresentationIDs.presentation_id, ",") />
			</cfloop>
		</cfif>
		
		<cfreturn presentationIDs />
	</cffunction>

</cfcomponent>