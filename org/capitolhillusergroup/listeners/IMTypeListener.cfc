<cfcomponent 
	displayname="IMTypeListener" 
	output="false" 
	extends="MachII.framework.Listener">

	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- don't need anything here for now --->
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setIMTypeService" access="public" output="false" returntype="void">
		<cfargument name="imTypeService" type="org.capitolhillusergroup.imtype.IMTypeService" required="true" />
		<cfset variables.imTypeService = arguments.imTypeService />
	</cffunction>
	<cffunction name="getIMTypeService" access="public" output="false" returntype="org.capitolhillusergroup.imtype.IMTypeService">
		<cfreturn variables.imTypeService />
	</cffunction>
	
	<cffunction name="setSessionService" access="public" output="false" returntype="void">
		<cfargument name="sessionService" type="org.capitolhillusergroup.session.SessionService" required="true" />
		<cfset variables.sessionService = arguments.sessionService />
	</cffunction>
	<cffunction name="getSessionService" access="public" output="false" returntype="org.capitolhillusergroup.session.SessionService">
		<cfreturn variables.sessionService />
	</cffunction>
	
	<!--- listener methods --->
	<cffunction name="getIMTypes" access="public" output="false" returntype="query" hint="Returns a query object with all IM Types">
		<cfreturn getIMTypeService().getIMTypes() />
	</cffunction>
	
	<cffunction name="getIMTypeByID" access="public" output="false" returntype="org.capitolhillusergroup.imtype.IMType">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getIMTypeService().getIMTypeByID(arguments.event.getArg("imTypeID", "")) />
	</cffunction>
	
	<cffunction name="processIMTypeForm" access="public" output="false" returntype="void" 
			hint="Processes the IM Type form and announces the next event">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var imType = arguments.event.getArg("IMType") />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var exitEvent = "success" />
		<cfset var message = "" />
		<cfset var action = "" />
		
		<cfset audit.setIsActive(arguments.event.getArg("isActive", 0)) />
		
		<cfif imType.getIMTypeID() is "">
			<cfset action = "add" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addimtypesuccessful") />
			<cfset audit.setCreatedByID(getSessionService().getUser().getPersonID()) />
			<cfset audit.setDTCreated(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset audit.setIPCreated(CGI.REMOTE_ADDR) />
		<cfelse>
			<cfset action = "update" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("updateimtypesuccessful") />
			<cfset audit.setModifiedByID(getSessionService().getUser().getPersonID()) />
			<cfset audit.setDTModified(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset audit.setIPModified(CGI.REMOTE_ADDR) />
		</cfif>
		
		<cfset imType.setAudit(audit) />
		
		<cftry>
			<cfset getIMTypeService().saveIMType(imType) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addupdateimtypefailed") />
				<cfif action is "add">
					<cfset imType.setIMTypeID("") />
				</cfif>
				<cfset arguments.event.setArg("imType", imType) />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="deleteIMType" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var exitEvent = "success" />
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("deleteimtypesuccessful") />
		<cfset var imType = getIMTypeService().getIMTypeByID(arguments.event.getArg("imTypeID")) />
		
		<cftry>
			<cfset getIMTypeService().deleteIMType(imType) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("deleteimtypefailed") />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
</cfcomponent>