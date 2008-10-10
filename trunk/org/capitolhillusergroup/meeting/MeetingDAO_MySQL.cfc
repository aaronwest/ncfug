<cfcomponent 
	displayname="MeetingDAO_MySQL" 
	output="false" 
	extends="MeetingDAO" 
	hint="MeetingDAO - MySQL">

	<cffunction name="init" access="public" output="false" returntype="MeetingDAO" hint="Constructor for this CFC.">
		<cfreturn this />
	</cffunction>

	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates a meeting bean">
		<cfargument name="meeting" type="Meeting" required="true" />
		
		<cfset var getMeeting = 0 />
		<cfset var dtModified = 0 />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var location = 0 />
		<cfset var presentations = arrayNew(1) />
		
		<cftry>
			<cfquery name="getMeeting" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	meeting.meeting_id, 
						meeting.title, 
						meeting.description, 
						meeting.dt_meeting, 
						meeting.location_id, 
						meeting.connect_url, 
						meeting.created_by_id, 
						meeting.dt_created, 
						meeting.ip_created, 
						meeting.modified_by_id, 
						meeting.dt_modified, 
						meeting.ip_modified, 
						meeting.is_active, 
						cb.first_name AS cbfn, 
						cb.last_name AS cbln, 
						mb.first_name AS mbfn, 
						mb.last_name AS mbln 
				FROM 	meeting 
				LEFT OUTER JOIN person AS cb 
					ON meeting.created_by_id = cb.person_id 
				LEFT OUTER JOIN person AS mb 
					ON meeting.modified_by_id = mb.person_id 
				WHERE 	meeting.meeting_id = <cfqueryparam value="#arguments.meeting.getMeetingID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getMeeting.recordCount eq 1>
			<cfif getMeeting.dt_modified is not "">
				<cfset dtModified = getMeeting.dt_modified />
			</cfif>
			
			<cfset location = getLocationService().getLocationByID(getMeeting.location_id) />
			<cfset presentations = getPresentationService().getPresentationsByMeetingID(getMeeting.meeting_id) />
			
			<cfset audit.init(getMeeting.created_by_id, getMeeting.cbfn & " " & getMeeting.cbln, getMeeting.dt_created, getMeeting.ip_created, 
								getMeeting.modified_by_id, getMeeting.mbfn & " " & getMeeting.mbln, dtModified, getMeeting.ip_modified, 
								getMeeting.is_active) />
			
			<cfset arguments.meeting.init(getMeeting.meeting_id, getMeeting.title, getMeeting.description, 
											getMeeting.dt_meeting, location, getMeeting.connect_url, 
											presentations, audit) />
		</cfif>
	</cffunction>
	
	<cffunction name="fetchDefaults" access="public" output="false" returntype="void" hint="Populates a meeting bean">
		<cfargument name="meeting" type="Meeting" required="true" />
		
		<cfset var getMeeting = 0 />
		<cfset var dtModified = 0 />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var location = 0 />
		<cfset var presentations = arrayNew(1) />
		<cfset var defaultDateTime = getResourceBundleFacade().getLocaleUtils().toEpoch(createDateTime(datePart("yyyy", now()), datePart("m", now()), datePart("d", now()), 18, 0, 0))>
		
		<cftry>
			<cfquery name="getMeeting" datasource="#getDatasource().getDSN()#" maxrows="1" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	meeting.meeting_id
						, meeting.title
						, meeting.description 
						, meeting.dt_meeting
						, meeting.location_id
						, meeting.connect_url
						, meeting.created_by_id
						, meeting.dt_created
						, meeting.ip_created
						, meeting.modified_by_id
						, meeting.dt_modified
						, meeting.ip_modified
						, meeting.is_active
						, cb.first_name AS cbfn
						, cb.last_name AS cbln
						, mb.first_name AS mbfn
						, mb.last_name AS mbln 
				FROM 	meeting 
				LEFT OUTER JOIN person AS cb ON meeting.created_by_id = cb.person_id 
				LEFT OUTER JOIN person AS mb ON meeting.modified_by_id = mb.person_id 
				ORDER BY meeting.dt_meeting DESC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>

		<cfif getMeeting.recordCount GT 0>
			<cfset location = getLocationService().getLocationByID(locationID=getMeeting.location_id) />
			
			<cfset ARGUMENTS.meeting.init(""
										, ""
										, ""
										, getMeeting.dt_meeting
										, location
										, ""
										, presentations
										, audit)>
		<cfelse>
			<cfset location = getLocationService().getLocationByID(locationID="") />
			
			<cfset ARGUMENTS.meeting.init(""
										, ""
										, ""
										, defaultDateTime
										, location
										, ""
										, presentations
										, audit)>
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves a meeting">
		<cfargument name="meeting" type="Meeting" required="true" />
		
		<cfif arguments.meeting.getMeetingID() is "">
			<cfset arguments.meeting.setMeetingID(createUUID()) />
			<cfset create(arguments.meeting) />
		<cfelse>
			<cfset update(arguments.meeting) />
		</cfif>
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new meeting">
		<cfargument name="meeting" type="Meeting" required="true" />
		
		<cfset var insertMeeting = 0 />
		<cfset var insertPresentation = 0 />
		<cfset var presentations = arguments.meeting.getPresentations() />
		<cfset var i = 0 />
		<cfset var error = false />
		<cfset var errorDetail = "" />
		
		<cftransaction action="begin">
			<cftry>
				<cfquery name="insertMeeting" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					INSERT INTO meeting (
						meeting_id, 
						title, 
						description, 
						dt_meeting, 
						location_id, 
						connect_url, 
						created_by_id, 
						dt_created, 
						ip_created, 
						is_active
					) VALUES (
						<cfqueryparam value="#arguments.meeting.getMeetingID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						<cfqueryparam value="#arguments.meeting.getTitle()#" cfsqltype="cf_sql_char" maxlength="500" />, 
						<cfqueryparam value="#arguments.meeting.getDescription()#" cfsqltype="cf_sql_longvarchar" 
									null="#not len(arguments.meeting.getDescription())#" />, 
						<cfqueryparam value="#arguments.meeting.getDTMeeting()#" cfsqltype="cf_sql_bigint" />, 
						<cfqueryparam value="#arguments.meeting.getLocation().getLocationID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						<cfqueryparam value="#arguments.meeting.getConnectURL()#" cfsqltype="cf_sql_varchar" maxlength="255" />, 
						<cfqueryparam value="#arguments.meeting.getAudit().getCreatedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						<cfqueryparam value="#arguments.meeting.getAudit().getDTCreated()#" cfsqltype="cf_sql_bigint" />, 
						<cfqueryparam value="#arguments.meeting.getAudit().getIPCreated()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
						<cfqueryparam value="#arguments.meeting.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
					)
				</cfquery>
				<cfcatch type="database">
					<cfset error = true />
					<cfset errorDetail = CFCATCH.Detail />
				</cfcatch>
			</cftry>
			
			<cfloop index="i" from="1" to="#arrayLen(presentations)#" step="1">
				<cftry>
					<cfquery name="insertPresentation" datasource="#getDatasource().getDSN()#" 
							username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
						INSERT INTO meeting_presentation (
							meeting_id, 
							presentation_id
						) VALUES (
							<cfqueryparam value="#arguments.meeting.getMeetingID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
							<cfqueryparam value="#presentations[i].getPresentationID()#" cfsqltype="cf_sql_char" maxlength="35" />
						)
					</cfquery>
					<cfcatch type="database">
						<cfset error = true />
						<cfset errorDetail = CFCATCH.Detail />
					</cfcatch>
				</cftry>
			</cfloop>
			
			<cfif not error>
				<cftransaction action="commit" />
			<cfelse>
				<cftransaction action="rollback" />
			</cfif>
		</cftransaction>
		
		<cfif error>
			<cfthrow type="application" message="Database Error" detail="#errorDetail#" />
		</cfif>
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates a meeting">
		<cfargument name="meeting" type="Meeting" required="true" />
		
		<cfset var updateMeeting = 0 />
		<cfset var deletePresentations = 0 />
		<cfset var insertPresentation = 0 />
		<cfset var presentations = arguments.meeting.getPresentations() />
		<cfset var i = 0 />
		<cfset var error = false />
		<cfset var errorDetail = "" />
		
		<cftransaction action="begin">
			<cftry>
				<cfquery name="updateMeeting" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					UPDATE 	meeting 
					SET 	title = <cfqueryparam value="#arguments.meeting.getTitle()#" cfsqltype="cf_sql_char" maxlength="500" />, 
							description = <cfqueryparam value="#arguments.meeting.getDescription()#" cfsqltype="cf_sql_longvarchar" 
														null="#not len(arguments.meeting.getDescription())#" />, 
							dt_meeting = <cfqueryparam value="#arguments.meeting.getDTMeeting()#" cfsqltype="cf_sql_bigint" />, 
							location_id = <cfqueryparam value="#arguments.meeting.getLocation().getLocationID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
							connect_url = <cfqueryparam value="#arguments.meeting.getConnectURL()#" cfsqltype="cf_sql_varchar" maxlength="255" />, 
							modified_by_id = <cfqueryparam value="#arguments.meeting.getAudit().getModifiedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
							dt_modified = <cfqueryparam value="#arguments.meeting.getAudit().getDTModified()#" cfsqltype="cf_sql_bigint" />, 
							ip_modified = <cfqueryparam value="#arguments.meeting.getAudit().getIPModified()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
							is_active = <cfqueryparam value="#arguments.meeting.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" /> 
					WHERE 	meeting_id = <cfqueryparam value="#arguments.meeting.getMeetingID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
			
			<cftry>
				<cfquery name="deletePresentations" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM meeting_presentation 
					WHERE meeting_id = <cfqueryparam value="#arguments.meeting.getMeetingID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
			
			<cfloop index="i" from="1" to="#arrayLen(presentations)#" step="1">
				<cftry>
					<cfquery name="insertPresentation" datasource="#getDatasource().getDSN()#" 
							username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
						INSERT INTO meeting_presentation (
							meeting_id, 
							presentation_id
						) VALUES (
							<cfqueryparam value="#arguments.meeting.getMeetingID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
							<cfqueryparam value="#presentations[i].getPresentationID()#" cfsqltype="cf_sql_char" maxlength="35" />
						)
					</cfquery>
					<cfcatch type="database">
						<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
					</cfcatch>
				</cftry>
			</cfloop>
			
			<cfif not error>
				<cftransaction action="commit" />
			<cfelse>
				<cftransaction action="rollback" />
			</cfif>
		</cftransaction>
		
		<cfif error>
			<cfthrow type="application" message="Database Error" detail="#errorDetail#" />
		</cfif>
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes a meeting">
		<cfargument name="meeting" type="Meeting" required="true" />
		
		<cfset var deleteMeeting = 0 />
		<cfset var error = false />
		
		<cftry>
			<cfset getPresentationService().deletePresentationsByMeetingID(arguments.meeting.getMeetingID()) />
			<cfcatch type="any">
				<cfset error = true />
				<cfthrow type="application" message="Error Deleting Presentations" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif not error>
			<cftry>
				<cfquery name="deleteMeeting" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM meeting 
					WHERE meeting_id = <cfqueryparam value="#arguments.meeting.getMeetingID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
		</cfif>
	</cffunction>
	
</cfcomponent>