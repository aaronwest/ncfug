<cfcomponent displayname="BoardPositionService" output="false" hint="BoardPositionService for CHUG">

	<cffunction name="init" access="public" output="false" returntype="BoardPositionService">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setBoardPositionDAO" access="public" output="false" returntype="void">
		<cfargument name="boardPositionDAO" type="BoardPositionDAO" required="true" />
		<cfset variables.boardPositionDAO = arguments.boardPositionDAO />
	</cffunction>
	<cffunction name="getBoardPositionDAO" access="public" output="false" returntype="BoardPositionDAO">
		<cfreturn variables.boardPositionDAO />
	</cffunction>
	
	<cffunction name="setBoardPositionGateway" access="public" output="false" returntype="void">
		<cfargument name="boardPositionGateway" type="BoardPositionGateway" required="true" />
		<cfset variables.boardPositionGateway = arguments.boardPositionGateway />
	</cffunction>
	<cffunction name="getBoardPositionGateway" access="public" output="false" returntype="BoardPositionGateway">
		<cfreturn variables.boardPositionGateway />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getBoardPositionBean" access="public" output="false" returntype="BoardPosition">
		<cfreturn createObject("component", "BoardPosition").init() />
	</cffunction>
	
	<cffunction name="getBoardPositions" access="public" output="false" returntype="query">
		<cfreturn getBoardPositionGateway().getBoardPositions() />
	</cffunction>
	
	<cffunction name="getOpenBoardPositions" access="public" output="false" returntype="query">
		<cfreturn getBoardPositionGateway().getOpenBoardPositions() />
	</cffunction>
	
	<cffunction name="getNonBoardMembers" access="public" output="false" returntype="query">
		<cfreturn getBoardPositionGateway().getNonBoardMembers() />
	</cffunction>
	
	<cffunction name="getBoardPositionCount" access="public" output="false" returntype="numeric">
		<cfreturn getBoardPositionGateway().getBoardPositionCount() />
	</cffunction>
	
	<cffunction name="getBoardPositionByID" access="public" output="false" returntype="BoardPosition">
		<cfargument name="boardPositionID" type="string" required="true" />
		
		<cfset var boardPosition = getBoardPositionBean() />
		<cfset boardPosition.setBoardPositionID(arguments.boardPositionID) />
		
		<cfif arguments.boardPositionID is not "">
			<cfset getBoardPositionDAO().fetch(boardPosition) />
		</cfif>
		
		<cfreturn boardPosition />
	</cffunction>
	
	<cffunction name="saveBoardPosition" access="public" output="false" returntype="void">
		<cfargument name="boardPosition" type="BoardPosition" required="true" />
		
		<cfset getBoardPositionDAO().save(arguments.boardPosition) />
	</cffunction>
	
	<cffunction name="deleteBoardPosition" access="public" output="false" returntype="void">
		<cfargument name="boardPosition" type="BoardPosition" required="true" />
		
		<cfset getBoardPositionDAO().delete(arguments.boardPosition) />
	</cffunction>
	
	<cffunction name="getBoardMembers" access="public" output="false" returntype="query">
		<cfreturn getBoardPositionGateway().getBoardMembers() />
	</cffunction>
	
	<cffunction name="addBoardMember" access="public" output="false" returntype="void">
		<cfargument name="boardPositionID" type="uuid" required="true" />
		<cfargument name="personID" type="uuid" required="true" />
		
		<cfset getBoardPositionGateway().addBoardMember(arguments.boardPositionID, arguments.personID) />
	</cffunction>
	
	<cffunction name="deleteBoardMember" access="public" output="false" returntype="void">
		<cfargument name="boardPositionID" type="uuid" required="true" />
		
		<cfset getBoardPositionGateway().deleteBoardMember(arguments.boardPositionID) />
	</cffunction>
	
</cfcomponent>