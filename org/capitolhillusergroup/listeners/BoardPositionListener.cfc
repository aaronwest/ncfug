<cfcomponent displayname="BoardPositionListener" output="false" extends="MachII.framework.Listener" hint="BoardPositionListener for CHUG">

	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- do nothing --->
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setBoardPositionService" access="public" output="false" returntype="void">
		<cfargument name="boardPositionService" type="org.capitolhillusergroup.boardposition.BoardPositionService" required="true" />
		<cfset variables.boardPositionService = arguments.boardPositionService />
	</cffunction>
	<cffunction name="getBoardPositionService" access="public" output="false" returntype="org.capitolhillusergroup.boardposition.BoardPositionService">
		<cfreturn variables.boardPositionService />
	</cffunction>

	<cffunction name="setSessionService" access="public" output="false" returntype="void">
		<cfargument name="sessionService" type="org.capitolhillusergroup.session.SessionService" required="true" />
		<cfset variables.sessionService = arguments.sessionService />
	</cffunction>
	<cffunction name="getSessionService" access="public" output="false" returntype="org.capitolhillusergroup.session.SessionService">
		<cfreturn variables.sessionService />
	</cffunction>
	
	<!--- listener methods --->
	<cffunction name="getBoardPositions" access="public" output="false" returntype="query">
		<cfreturn getBoardPositionService().getBoardPositions() />
	</cffunction>
	
	<cffunction name="getOpenBoardPositions" access="public" output="false" returntype="query">
		<cfreturn getBoardPositionService().getOpenBoardPositions() />
	</cffunction>
	
	<cffunction name="getNonBoardMembers" access="public" output="false" returntype="query">
		<cfreturn getBoardPositionService().getNonBoardMembers() />
	</cffunction>
	
	<cffunction name="getBoardPositionCount" access="public" output="false" returntype="numeric">
		<cfreturn getBoardPositionService().getBoardPositionCount() />
	</cffunction>
	
	<cffunction name="getBoardPositionByID" access="public" output="false" returntype="org.capitolhillusergroup.boardposition.BoardPosition">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfreturn getBoardPositionService().getBoardPositionByID(arguments.event.getArg("boardPositionID", "")) />
	</cffunction>
	
	<cffunction name="processBoardPositionForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var boardPosition = arguments.event.getArg("boardPosition") />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var exitEvent = "success" />
		<cfset var message = "" />
		<cfset var action = "" />
		
		<cfset audit.setIsActive(arguments.event.getArg("isActive", 0)) />
		
		<cfif boardPosition.getBoardPositionID() is "">
			<cfset action = "add" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addboardpositionsuccessful") />
			<cfset audit.setCreatedByID(getSessionService().getUser().getPersonID()) />
			<cfset audit.setDTCreated(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset audit.setIPCreated(CGI.REMOTE_ADDR) />
		<cfelse>
			<cfset action = "update" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("updateboardpositionsuccessful") />
			<cfset audit.setModifiedByID(getSessionService().getUser().getPersonID()) />
			<cfset audit.setDTModified(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset audit.setIPModified(CGI.REMOTE_ADDR) />
		</cfif>
		
		<cfset boardPosition.setAudit(audit) />
		
		<cftry>
			<cfset getBoardPositionService().saveBoardPosition(boardPosition) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addupdateboardpositionfailed") />
				<cfif action is "add">
					<cfset boardPosition.setBoardPositionID("") />
				</cfif>
				<cfset arguments.event.setArg("boardPosition", boardPosition) />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="deleteBoardPosition" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var exitEvent = "success" />
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("deleteboardpositionsuccessful") />
		<cfset var boardPosition = getBoardPositionService().getBoardPositionByID(arguments.event.getArg("boardPositionID")) />
		
		<cftry>
			<cfset getBoardPositionService().deleteBoardPosition(boardPosition) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("deleteboardpositionfailed") />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="getBoardMembers" access="public" output="false" returntype="query">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getBoardPositionService().getBoardMembers() />
	</cffunction>
	
	<cffunction name="processBoardMemberForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var exitEvent = "success" />
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("addboardmembersuccessful") />
		
		<cftry>
			<cfset getBoardPositionService().addBoardMember(arguments.event.getArg("boardPositionID"), arguments.event.getArg("personID")) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addboardmemberfailed") />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="deleteBoardMember" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var exitEvent = "success" />
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("deleteboardmembersuccessful") />
		
		<cftry>
			<cfset getBoardPositionService().deleteBoardMember(arguments.event.getArg("boardPositionID")) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("deleteboardmemberfailed") />
			</cfcatch>
		</cftry>

		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>

</cfcomponent>