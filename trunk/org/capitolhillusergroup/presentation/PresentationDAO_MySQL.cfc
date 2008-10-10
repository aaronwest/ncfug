<cfcomponent 
	displayname="PresentationDAO_MySQL" 
	output="false" 
	extends="PresentationDAO" 
	hint="PresentationDAO - MySQL">

	<cffunction name="init" access="public" output="false" returntype="PresentationDAO" hint="Constructor for this CFC.">
		<cfreturn this />
	</cffunction>

	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates a presentation bean">
		<cfargument name="presentation" type="Presentation" required="true" />
		
		<cfset var getPresentation = 0 />
		<cfset var dtModified = createDate(1900, 1, 1) />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var presenters = arrayNew(1) />
		
		<cftry>
			<cfquery name="getPresentation" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	presentation.presentation_id, 
						presentation.title, 
						presentation.summary, 
						presentation.presentation_file, 
						presentation.presentation_file_title, 
						presentation.presentation_file_description, 
						presentation.created_by_id, 
						presentation.dt_created, 
						presentation.ip_created, 
						presentation.modified_by_id, 
						presentation.dt_modified, 
						presentation.ip_modified, 
						presentation.is_active, 
						cb.first_name AS cbfn, 
						cb.last_name AS cbln, 
						mb.first_name AS mbfn, 
						mb.last_name AS mbln 
				FROM 	presentation 
				LEFT OUTER JOIN person AS cb ON presentation.created_by_id = cb.person_id 
				LEFT OUTER JOIN person AS mb ON presentation.modified_by_id = mb.person_id 
				WHERE 	presentation.presentation_id = <cfqueryparam value="#arguments.presentation.getPresentationID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getPresentation.recordCount eq 1>
			<cfif getPresentation.dt_modified is not "">
				<cfset dtModified = getPresentation.dt_modified />
			</cfif>
			
			<cfset presenters = getPersonService().getPresentersByPresentationID(getPresentation.presentation_id) />
			
			<cfset audit.init(getPresentation.created_by_id, getPresentation.cbfn & " " & getPresentation.cbln, getPresentation.dt_created, 
								getPresentation.ip_created, getPresentation.modified_by_id, getPresentation.mbfn & " " & getPresentation.mbln, 
								dtModified, getPresentation.ip_modified, getPresentation.is_active) />
			
			<cfset arguments.presentation.init(getPresentation.presentation_id, getPresentation.title, getPresentation.summary, 
												presenters, getPresentation.presentation_file, getPresentation.presentation_file_title, 
												getPresentation.presentation_file_description, audit) />
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves a presentation">
		<cfargument name="presentation" type="Presentation" required="true" />
		
		<cfif arguments.presentation.getPresentationID() is "">
			<cfset arguments.presentation.setPresentationID(createUUID()) />
			<cfset create(arguments.presentation) />
		<cfelse>
			<cfset update(arguments.presentation) />
		</cfif>
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new presentation">
		<cfargument name="presentation" type="Presentation" required="true" />
		
		<cfset var insertPresentation = 0 />
		<cfset var insertPresenter = 0 />
		<cfset var presenters = arguments.presentation.getPresenters() />
		<cfset var i = 0 />
		<cfset var error = false />
		<cfset var errorDetail = "" />
		
		<cftransaction action="begin">
			<cftry>
				<cfquery name="insertPresentation" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					INSERT INTO presentation (
						presentation_id, 
						title, 
						summary, 
						presentation_file, 
						presentation_file_title, 
						presentation_file_description, 
						created_by_id, 
						dt_created, 
						ip_created, 
						is_active
					) VALUES (
						<cfqueryparam value="#arguments.presentation.getPresentationID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						<cfqueryparam value="#arguments.presentation.getTitle()#" cfsqltype="cf_sql_varchar" maxlength="250" />, 
						<cfqueryparam value="#arguments.presentation.getSummary()#" cfsqltype="cf_sql_longvarchar" 
										null="#not len(arguments.presentation.getSummary())#" />, 
						<cfqueryparam value="#arguments.presentation.getPresentationFile()#" cfsqltype="cf_sql_varchar" maxlength="250" 
										null="#not len(arguments.presentation.getPresentationFile())#" />, 
						<cfqueryparam value="#arguments.presentation.getPresentationFileTitle()#" cfsqltype="cf_sql_varchar" maxlength="250" 
										null="#not len(arguments.presentation.getPresentationFileTitle())#" />, 
						<cfqueryparam value="#arguments.presentation.getPresentationFileDescription()#" cfsqltype="cf_sql_varchar" maxlength="250" 
										null="#not len(arguments.presentation.getPresentationFileDescription())#" />, 
						<cfqueryparam value="#arguments.presentation.getAudit().getCreatedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						<cfqueryparam value="#arguments.presentation.getAudit().getDTCreated()#" cfsqltype="cf_sql_bigint" />, 
						<cfqueryparam value="#arguments.presentation.getAudit().getIPCreated()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
						<cfqueryparam value="#arguments.presentation.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
					)
				</cfquery>
				<cfcatch type="database">
					<cfset error = true />
					<cfset errorDetail = CFCATCH.Detail />
				</cfcatch>
			</cftry>
			
			<cfloop index="i" from="1" to="#arrayLen(presenters)#" step="1">
				<cftry>
					<cfquery name="insertPresenter" datasource="#getDatasource().getDSN()#" 
							username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
						INSERT INTO presentation_presenter (
							presentation_id, 
							presenter_id
						) VALUES (
							<cfqueryparam value="#presentation.getPresentationID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
							<cfqueryparam value="#presenters[i].getPersonID()#" cfsqltype="cf_sql_char" maxlength="35" />
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

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates a presentation">
		<cfargument name="presentation" type="Presentation" required="true" />
		
		<cfset var updatePresentation = 0 />
		<cfset var deletePresenters = 0 />
		<cfset var insertPresenter = 0 />
		<cfset var presenters = arguments.presentation.getPresenters() />
		<cfset var error = false />
		<cfset var errorDetail = "" />
		
		<cftransaction action="begin">
			<cftry>
				<cfquery name="updatePresentation" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					UPDATE 	presentation 
					SET 	title = <cfqueryparam value="#arguments.presentation.getTitle()#" cfsqltype="cf_sql_varchar" maxlength="250" />, 
							summary = <cfqueryparam value="#arguments.presentation.getSummary()#" cfsqltype="cf_sql_longvarchar" 
														null="#not len(arguments.presentation.getSummary())#" />, 
							presentation_file = <cfqueryparam value="#arguments.presentation.getPresentationFile()#" cfsqltype="cf_sql_varchar" maxlength="250" 
															null="#not len(arguments.presentation.getPresentationFile())#" />, 
							presentation_file_title = <cfqueryparam value="#arguments.presentation.getPresentationFileTitle()#" cfsqltype="cf_sql_varchar" maxlength="250" 
																	null="#not len(arguments.presentation.getPresentationFileTitle())#" />, 
							presentation_file_description = <cfqueryparam value="#arguments.presentation.getPresentationFileDescription()#" cfsqltype="cf_sql_varchar" maxlength="250" 
																		null="#not len(arguments.presentation.getPresentationFileDescription())#" />, 
							modified_by_id = <cfqueryparam value="#arguments.presentation.getAudit().getModifiedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
							dt_modified = <cfqueryparam value="#arguments.presentation.getAudit().getDTModified()#" cfsqltype="cf_sql_bigint" />, 
							ip_modified = <cfqueryparam value="#arguments.presentation.getAudit().getIPModified()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
							is_active = <cfqueryparam value="#arguments.presentation.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" /> 
					WHERE 	presentation_id = <cfqueryparam value="#arguments.presentation.getPresentationID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfset error = true />
					<cfset errorDetail = CFCATCH.Detail />
				</cfcatch>
			</cftry>
			
			<cftry>
				<cfquery name="deletePresenters" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM presentation_presenter 
					WHERE presentation_id = <cfqueryparam value="#arguments.presentation.getPresentationID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfset error = true />
					<cfset errorDetail = CFCATCH.Detail />
				</cfcatch>
			</cftry>
			
			<cfloop index="i" from="1" to="#arrayLen(presenters)#" step="1">
				<cftry>
					<cfquery name="insertPresenter" datasource="#getDatasource().getDSN()#" 
							username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
						INSERT INTO presentation_presenter (
							presentation_id, 
							presenter_id
						) VALUES (
							<cfqueryparam value="#presentation.getPresentationID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
							<cfqueryparam value="#presenters[i].getPersonID()#" cfsqltype="cf_sql_char" maxlength="35" />
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
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes a presentation">
		<cfargument name="presentation" type="Presentation" required="true" />
		
		<cfset var deletePresentation = 0 />
		<cfset var deletePresenters = 0 />
		<cfset var error = false />
		<cfset var errorDetail = "" />
		
		<cftransaction action="begin">
			<cftry>
				<cfquery name="deletePresentation" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM presentation 
					WHERE presentation_id = <cfqueryparam value="#arguments.presentation.getPresentationID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfset error = true />
					<cfset errorDetail = CFCATCH.Detail />
				</cfcatch>
			</cftry>
			
			<cftry>
				<cfquery name="deletePresenters" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					DELETE FROM presentation_presenter 
					WHERE presentation_id = <cfqueryparam value="#arguments.presentation.getPresentationID()#" cfsqltype="cf_sql_char" maxlength="35" />
				</cfquery>
				<cfcatch type="database">
					<cfset error = true />
					<cfset errorDetail = CFCATCH.Detail />
				</cfcatch>
			</cftry>

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
	
</cfcomponent>