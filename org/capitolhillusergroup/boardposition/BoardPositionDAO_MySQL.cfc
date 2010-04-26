<cfcomponent 
	displayname="BoardPositionDAO_MySQL" 
	output="false" 
	extends="BoardPositionDAO" 
	hint="BoardPositionDAO - MySQL">

	<cffunction name="init" access="public" output="false" returntype="BoardPositionDAO" hint="Constructor for this CFC.">
		<cfreturn this />
	</cffunction>

	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates a BoardPosition bean">
		<cfargument name="boardPosition" type="BoardPosition" required="true" />
		
		<cfset var getBoardPosition = 0 />
		<cfset var dtModified = createDate(1900, 1, 1) />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		
		<cftry>
			<cfquery name="getBoardPosition" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	board_position.board_position_id, 
						board_position.board_position, 
						board_position.description, 
						board_position.sort_order, 
						board_position.created_by_id, 
						board_position.dt_created, 
						board_position.ip_created, 
						board_position.modified_by_id, 
						board_position.dt_modified, 
						board_position.ip_modified, 
						board_position.is_active, 
						cb.first_name AS cbfn, 
						cb.last_name AS cbln, 
						mb.first_name AS mbfn, 
						mb.last_name AS mbln 
				FROM 	board_position 
				LEFT OUTER JOIN person AS cb ON board_position.created_by_id = cb.person_id 
				LEFT OUTER JOIN person AS mb ON board_position.modified_by_id = mb.person_id 
				WHERE 	board_position.board_position_id = <cfqueryparam value="#arguments.boardPosition.getBoardPositionID()#" 
																		cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getBoardPosition.recordCount eq 1>
			<cfif getBoardPosition.dt_modified is not "">
				<cfset dtModified = getBoardPosition.dt_modified />
			</cfif>
			
			<cfset audit.init(getBoardPosition.created_by_id, getBoardPosition.cbfn & " " & getBoardPosition.cbln, getBoardPosition.dt_created, 
								getBoardPosition.ip_created, getBoardPosition.modified_by_id, getBoardPosition.mbfn & " " & getBoardPosition.mbln, 
								dtModified, getBoardPosition.ip_modified, getBoardPosition.is_active) />
			
			<cfset arguments.boardPosition.init(getBoardPosition.board_position_id, getBoardPosition.board_position, getBoardPosition.description, 
												getBoardPosition.sort_order, audit) />
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves a BoardPosition">
		<cfargument name="boardPosition" type="BoardPosition" required="true" />
		
		<cfif arguments.boardPosition.getBoardPositionID() is "">
			<cfset arguments.boardPosition.setBoardPositionID(createUUID()) />
			<cfset create(arguments.boardPosition) />
		<cfelse>
			<cfset update(arguments.boardPosition) />
		</cfif>
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new BoardPosition">
		<cfargument name="boardPosition" type="BoardPosition" required="true" />
		
		<cfset var insertBoardPosition = 0 />
		
		<cftry>
			<cfquery name="insertBoardPosition" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				INSERT INTO board_position (
					board_position_id, 
					board_position, 
					description, 
					sort_order, 
					created_by_id, 
					dt_created, 
					ip_created, 
					is_active
				) VALUES (
					<cfqueryparam value="#arguments.boardPosition.getBoardPositionID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.boardPosition.getBoardPosition()#" cfsqltype="cf_sql_varchar" maxlength="250" />, 
					<cfqueryparam value="#arguments.boardPosition.getDescription()#" cfsqltype="cf_sql_varchar" maxlength="500" 
									null="#not len(arguments.boardPosition.getDescription())#" />, 
					<cfqueryparam value="#arguments.boardPosition.getSortOrder()#" cfsqltype="cf_sql_tinyint" />, 
					<cfqueryparam value="#arguments.boardPosition.getAudit().getCreatedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.boardPosition.getAudit().getDTCreated()#" cfsqltype="cf_sql_bigint" />, 
					<cfqueryparam value="#arguments.boardPosition.getAudit().getIPCreated()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
					<cfqueryparam value="#arguments.boardPosition.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
				)
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates a BoardPosition">
		<cfargument name="boardPosition" type="BoardPosition" required="true" />
		
		<cfset var updateBoardPosition = 0 />
		
		<cftry>
			<cfquery name="updateBoardPosition" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				UPDATE 	board_position 
				SET 	board_position = <cfqueryparam value="#arguments.boardPosition.getBoardPosition()#" cfsqltype="cf_sql_varchar" maxlength="250" />, 
						description = <cfqueryparam value="#arguments.boardPosition.getDescription()#" cfsqltype="cf_sql_varchar" maxlength="500" 
													null="#not len(arguments.boardPosition.getDescription())#" />, 
						sort_order = <cfqueryparam value="#arguments.boardPosition.getSortOrder()#" cfsqltype="cf_sql_tinyint" />, 
						modified_by_id = <cfqueryparam value="#arguments.boardPosition.getAudit().getModifiedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
						dt_modified = <cfqueryparam value="#arguments.boardPosition.getAudit().getDTModified()#" cfsqltype="cf_sql_bigint" />, 
						ip_modified = <cfqueryparam value="#arguments.boardPosition.getAudit().getIPModified()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
						is_active = <cfqueryparam value="#arguments.boardPosition.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" /> 
				WHERE 	board_position_id = <cfqueryparam value="#arguments.boardPosition.getBoardPositionID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes a BoardPosition">
		<cfargument name="boardPosition" type="BoardPosition" required="true" />
		
		<cfset var deleteBoardPosition = 0 />
		
		<cftry>
			<cfquery name="deleteBoardPosition" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				DELETE FROM board_position 
				WHERE 	board_position_id = <cfqueryparam value="#arguments.boardPosition.getBoardPositionID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>
	
</cfcomponent>