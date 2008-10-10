<cfcomponent 
	displayname="BoardPositionGateway_MySQL" 
	output="false" 
	extends="BoardPositionGateway" 
	hint="BoardPositionGateway - MySQL">
	
	<cffunction name="init" access="public" output="false" returntype="BoardPositionGateway">
		<cfreturn this />
	</cffunction>
	
	<!--- gateway methods --->
	<cffunction name="getBoardPositions" access="public" output="false" returntype="query">
		<cfset var boardPositions = 0 />
		
		<cftry>
			<cfquery name="boardPositions" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT board_position_id, board_position, is_active 
				FROM board_position 
				ORDER BY sort_order ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn boardPositions />
	</cffunction>

	<cffunction name="getOpenBoardPositions" access="public" output="false" returntype="query">
		<cfset var boardPositions = 0 />
		
		<cftry>
			<cfquery name="boardPositions" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT board_position_id, board_position, sort_order 
				FROM board_position 
				WHERE board_position_id NOT IN (
					SELECT board_position_id 
					FROM board_position_person
				) 
				ORDER BY sort_order ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn boardPositions />
	</cffunction>
	
	<cffunction name="getBoardPositionCount" access="public" output="false" returntype="numeric">
		<cfreturn getBoardPositions().recordCount />
	</cffunction>

	<cffunction name="getBoardMembers" access="public" output="false" returntype="query">
		<cfset var boardMembers = 0 />
		
		<cftry>
			<cfquery name="boardMembers" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	board_position_person.person_id, 
						board_position_person.board_position_id, 
						person.person_id, 
						person.first_name, 
						person.last_name, 
						board_position.board_position 
				FROM 	board_position_person 
				INNER JOIN person ON board_position_person.person_id = person.person_id 
				INNER JOIN board_position ON board_position_person.board_position_id = board_position.board_position_id 
				ORDER BY board_position.sort_order ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn boardMembers />
	</cffunction>

	<cffunction name="getNonBoardMembers" access="public" output="false" returntype="query">
		<cfset var nonBoardMembers = 0 />
		
		<!--- because roles may vary by implementation, we're making the assumption here that anyone 
				with a password can log into the site and is therefore at minimum a 'member', and therefore 
				is eligible to be on the board --->
		<cftry>
			<cfquery name="nonBoardMembers" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	person.person_id, 
						person.first_name, 
						person.last_name 
				FROM 	person 
				WHERE 	person.password IS NOT NULL 
				AND 	person.is_active = <cfqueryparam value="1" cfsqltype="cf_sql_tinyint" /> 
				AND 	person_id NOT IN (
					SELECT person_id 
					FROM board_position_person
				) 
				ORDER BY person.last_name, person.first_name ASC
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn nonBoardMembers />
	</cffunction>

	<cffunction name="addBoardMember" access="public" output="false" returntype="void">
		<cfargument name="boardPositionID" type="uuid" required="true" />
		<cfargument name="personID" type="uuid" required="true" />
		
		<cfset var insertBoardMember = 0 />
		
		<cftry>
			<cfquery name="insertBoardMember" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				INSERT INTO board_position_person (
					board_position_id, 
					person_id
				) VALUES (
					<cfqueryparam value="#arguments.boardPositionID#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.personID#" cfsqltype="cf_sql_char" maxlength="35" />
				)
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="deleteBoardMember" access="public" output="false" returntype="void">
		<cfargument name="boardPositionID" type="uuid" required="true" />
		
		<cfset var deleteBoardMember = 0 />

		<cftry>
			<cfquery name="deleteBoardMember" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				DELETE FROM board_position_person 
				WHERE board_position_id = <cfqueryparam value="#arguments.boardPositionID#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>
	
</cfcomponent>