<cfcomponent 
	displayname="RSVPDAO_MySQL" 
	output="false" 
	extends="RSVPDAO" 
	hint="RSVPDAO - MySQL">

	<cffunction name="init" access="public" output="false" returntype="RSVPDAO" hint="Constructor for this CFC.">
		<cfreturn this />
	</cffunction>

	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates an RSVP bean">
		<cfargument name="rsvp" type="RSVP" required="true" />
		
		<cfset var getRSVP = 0 />
		<cfset var dtModified = 0 />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		
		<cftry>
			<cfquery name="getRSVP" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	rsvp.rsvp_id, 
						rsvp.meeting_id, 
						rsvp.person_id, 
						rsvp.first_name, 
						rsvp.last_name, 
						rsvp.email, 
						rsvp.comments, 
						rsvp.created_by_id, 
						rsvp.dt_created, 
						rsvp.ip_created, 
						rsvp.modified_by_id, 
						rsvp.dt_modified, 
						rsvp.ip_modified, 
						rsvp.is_active, 
						cb.first_name AS cbfn, 
						cb.last_name AS cbln, 
						mb.first_name AS mbfn, 
						mb.last_name AS mbln 
				FROM 	rsvp 
				LEFT OUTER JOIN person AS cb ON rsvp.created_by_id = cb.person_id 
				LEFT OUTER JOIN person AS mb ON rsvp.modified_by_id = mb.person_id 
				WHERE 	rsvp.rsvp_id = <cfqueryparam value="#arguments.rsvp.getRSVPID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getRSVP.recordCount eq 1>
			<cfif getRSVP.dt_modified is not "">
				<cfset dtModified = getRSVP.dt_modified />
			</cfif>
			
			<cfset audit.init(getRSVP.created_by_id, getRSVP.cbfn & " " & getRSVP.cbln, getRSVP.dt_created, getRSVP.ip_created, 
								getRSVP.modified_by_id, getRSVP.mbfn & " " & getRSVP.mbln, dtModified, getRSVP.ip_modified, getRSVP.is_active) />
			
			<cfset arguments.rsvp.init(getRSVP.rsvp_id, getRSVP.meeting_id, getRSVP.person_id, getRSVP.first_name, getRSVP.last_name, getRSVP.email, 
										getRSVP.comments, audit) />
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves an RSVP">
		<cfargument name="rsvp" type="RSVP" required="true" />
		
		<cfif arguments.rsvp.getRSVPID() is "">
			<cfset arguments.rsvp.setRSVPID(createUUID()) />
			<cfset create(arguments.rsvp) />
		<cfelse>
			<cfset update(arguments.rsvp) />
		</cfif>
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new RSVP">
		<cfargument name="rsvp" type="RSVP" required="true" />
		
		<cfset var insertRSVP = 0 />
		
		<cftry>
			<cfquery name="insertRSVP" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				INSERT INTO rsvp (
					rsvp_id, 
					meeting_id, 
					person_id, 
					first_name, 
					last_name, 
					email, 
					comments, 
					created_by_id, 
					dt_created, 
					ip_created, 
					is_active
				) VALUES (
					<cfqueryparam value="#arguments.rsvp.getRSVPID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.rsvp.getMeetingID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.rsvp.getPersonID()#" cfsqltype="cf_sql_char" maxlength="35" 
							null="#not len(arguments.rsvp.getPersonID())#" />, 
					<cfqueryparam value="#arguments.rsvp.getFirstName()#" cfsqltype="cf_sql_varchar" maxlength="100" />, 
					<cfqueryparam value="#arguments.rsvp.getLastName()#" cfsqltype="cf_sql_varchar" maxlength="100" />, 
					<cfqueryparam value="#arguments.rsvp.getEmail()#" cfsqltype="cf_sql_varchar" maxlength="100" />, 
					<cfqueryparam value="#arguments.rsvp.getComments()#" cfsqltype="cf_sql_longvarchar" 
							null="#not len(arguments.rsvp.getComments())#" />, 
					<cfqueryparam value="#arguments.rsvp.getAudit().getCreatedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.rsvp.getAudit().getDTCreated()#" cfsqltype="cf_sql_bigint" />, 
					<cfqueryparam value="#arguments.rsvp.getAudit().getIPCreated()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
					<cfqueryparam value="#arguments.rsvp.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
				)
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates an RSVP">
		<cfargument name="rsvp" type="RSVP" required="true" />
		
		<cfset var updateRSVP = 0 />
		
		<cftry>
			<cfquery name="updateRSVP" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				UPDATE 	rsvp 
				SET 	meeting_id = <cfqueryparam value="#arguments.rsvp.getMeetingID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						person_id = <cfqueryparam value="#arguments.rsvp.getPersonID()#" cfsqltype="cf_sql_char" maxlength="35" 
												null="#not len(arguments.rsvp.getPersonID())#" />, 
						first_name = <cfqueryparam value="#arguments.rsvp.getFirstName()#" cfsqltype="cf_sql_varchar" maxlength="100" />, 
						last_name = <cfqueryparam value="#arguments.rsvp.getLastName()#" cfsqltype="cf_sql_varchar" maxlength="100" />, 
						email = <cfqueryparam value="#arguments.rsvp.getEmail()#" cfsqltype="cf_sql_varchar" maxlength="100" />, 
						comments = <cfqueryparam value="#arguments.rsvp.getComments()#" cfsqltype="cf_sql_longvarchar" 
												null="#not len(arguments.rsvp.getComments())#" />, 
						modified_by_id = <cfqueryparam value="#arguments.rsvp.getAudit().getModifiedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						dt_modified = <cfqueryparam value="#arguments.rsvp.getAudit().getDTModified()#" cfsqltype="cf_sql_bigint" />, 
						ip_modified = <cfqueryparam value="#arguments.rsvp.getAudit().getIPModified()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
						is_active = <cfqueryparam value="#arguments.rsvp.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" /> 
				WHERE 	rsvp_id = <cfqueryparam value="#arguments.rsvp.getRSVPID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes an RSVP">
		<cfargument name="rsvp" type="RSVP" required="true" />
		
		<cfset var deleteRSVP = 0 />
		
		<cftry>
			<cfquery name="deleteRSVP" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				DELETE FROM rsvp 
				WHERE rsvp_id = <cfqueryparam value="#arguments.rsvp.getRSVPID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>
	
</cfcomponent>