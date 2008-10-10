<cfcomponent 
	displayname="MeetingGateway_MySQL" 
	output="false" 
	extends="MeetingGateway" 
	hint="MeetingGateway - MySQL">
	
	<cffunction name="init" access="public" output="false" returntype="MeetingGateway">
		<cfreturn this />
	</cffunction>
	
	<!--- gateway methods --->
	<cffunction name="getMeetings" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		
		<cfset var meetings = 0 />
		
		<cftry>
			<cfquery name="meetings" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	meeting.meeting_id, 
						meeting.title, 
						meeting.description, 
						meeting.dt_meeting, 
						meeting.location_id, 
						meeting.is_active,
						location.location 
				FROM 	meeting 
				LEFT OUTER JOIN location 
					ON meeting.location_id = location.location_id 
				<cfif arguments.activeOnly>
				WHERE 	meeting.is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" /> 
				</cfif>
				ORDER BY meeting.dt_meeting DESC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn meetings />
	</cffunction>
	
	<cffunction name="getMeetingsAsArray" access="public" output="false" returntype="array">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		
		<cfset var getMeetingIDs = 0 />
		<cfset var meeting = 0 />
		<cfset var meetings = arrayNew(1) />
		
		<cftry>
			<cfquery name="getMeetingIDs" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	meeting_id 
				FROM 	meeting 
				<cfif arguments.activeOnly>
				WHERE 	is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" /> 
				</cfif>
				ORDER BY dt_meeting DESC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getMeetingIDs.recordCount gt 0>
			<cfloop query="getMeetingIDs">
				<cfset meeting = getMeetingService().getMeetingByID(getMeetingIDs.meeting_id) />
				<cfset arrayAppend(meetings, meeting) />
			</cfloop>
		</cfif>
		
		<cfreturn meetings />
	</cffunction>
	
	<cffunction name="getUpcomingMeetings" access="public" output="false" returntype="array">
		<cfargument name="numToGet" type="numeric" required="false" default="-1" />
		
		<cfset var getMeetingIDs = 0 />
		<cfset var meeting = 0 />
		<cfset var meetings = arrayNew(1) />
		<cfset var today = getResourceBundleFacade().getLocaleUtils().toEpoch(createDateTime(datePart("yyyy", now()), datePart("m", now()), datePart("d", now()), 0, 0, 0)) />
		
		<cftry>
			<cfquery name="getMeetingIDs" datasource="#getDatasource().getDSN()#" maxrows="#arguments.numToGet#"
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	meeting_id 
				FROM 	meeting 
				WHERE 	dt_meeting >= <cfqueryparam value="#today#" cfsqltype="cf_sql_bigint" /> 
				AND 	is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" /> 
				ORDER BY dt_meeting ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getMeetingIDs.recordCount gt 0>
			<cfloop query="getMeetingIDs">
				<cfset meeting = getMeetingService().getMeetingByID(getMeetingIDs.meeting_id) />
				<cfset arrayAppend(meetings, meeting) />
			</cfloop>
		</cfif>
		
		<cfreturn meetings />
	</cffunction>
	
	<cffunction name="getPreviousMeetings" access="public" output="false" returntype="array">
		<cfargument name="numToGet" type="numeric" required="false" default="-1" />
		
		<cfset var getMeetingIDs = 0 />
		<cfset var meeting = 0 />
		<cfset var meetings = arrayNew(1) />
		<cfset var today = getResourceBundleFacade().getLocaleUtils().toEpoch(createDateTime(datePart("yyyy", now()), datePart("m", now()), datePart("d", now()), 0, 0, 0)) />
		
		<cftry>
			<cfquery name="getMeetingIDs" datasource="#getDatasource().getDSN()#" maxrows="#arguments.numToGet#"
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	meeting_id 
				FROM 	meeting 
				WHERE 	dt_meeting <= <cfqueryparam value="#today#" cfsqltype="cf_sql_bigint" /> 
				AND 	is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" /> 
				ORDER BY dt_meeting DESC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getMeetingIDs.recordCount gt 0>
			<cfloop query="getMeetingIDs">
				<cfset meeting = getMeetingService().getMeetingByID(getMeetingIDs.meeting_id) />
				<cfset arrayAppend(meetings, meeting) />
			</cfloop>
		</cfif>
		
		<cfreturn meetings />
	</cffunction>
	
</cfcomponent>