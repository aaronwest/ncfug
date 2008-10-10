<cfcomponent 
	displayname="OrganizationListener" 
	output="false" 
	extends="MachII.framework.Listener">

	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- don't need anything here for now --->
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setOrganizationService" access="public" output="false" returntype="void">
		<cfargument name="organizationService" type="org.capitolhillusergroup.organization.OrganizationService" required="true" />
		<cfset variables.organizationService = arguments.organizationService />
	</cffunction>
	<cffunction name="getOrganizationService" access="public" output="false" returntype="org.capitolhillusergroup.organization.OrganizationService">
		<cfreturn variables.organizationService />
	</cffunction>
	
	<cffunction name="setSessionService" access="public" output="false" returntype="void">
		<cfargument name="sessionService" type="org.capitolhillusergroup.session.SessionService" required="true" />
		<cfset variables.sessionService = arguments.sessionService />
	</cffunction>
	<cffunction name="getSessionService" access="public" output="false" returntype="org.capitolhillusergroup.session.SessionService">
		<cfreturn variables.sessionService />
	</cffunction>

	<!--- listener methods --->
	<cffunction name="getOrganizations" access="public" output="false" returntype="query" hint="Returns a query object with all the organizations">
		<cfreturn getOrganizationService().getOrganizations() />
	</cffunction>
	
	<cffunction name="getOrganizationByID" access="public" output="false" returntype="org.capitolhillusergroup.organization.Organization">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getOrganizationService().getOrganizationByID(arguments.event.getArg("organizationID", "")) />
	</cffunction>
	
	<cffunction name="processOrganizationForm" access="public" output="false" returtntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var organization = arguments.event.getArg("organization") />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var exitEvent = "success" />
		<cfset var message = "" />
		
		<cfset audit.setIsActive(arguments.event.getArg("isActive", 0)) />
		
		<cfif organization.getOrganizationID() is "">
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addorganizationsuccessful") />
			<cfset audit.setCreatedByID(getSessionService().getUser().getPersonID()) />
			<cfset audit.setDTCreated(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset audit.setIPCreated(CGI.REMOTE_ADDR) />
		<cfelse>
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("updateorganizationsuccessful") />
			<cfset audit.setModifiedByID(getSessionService().getUser().getPersonID()) />
			<cfset audit.setDTModified(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset audit.setIPModified(CGI.REMOTE_ADDR) />
		</cfif>
		
		<cfset organization.setAudit(audit) />
		
		<cftry>
			<cfset getOrganizationService().saveOrganization(organization) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addupdateorganizationfailed") />
				<cfset organization.setOrganizationID("") />
				<cfset arguments.event.setArg("organization", organization) />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="deleteOrganization" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var exitEvent = "success" />
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("deleteorganizationsuccessful") />
		<cfset var organization = getOrganizationService().getOrganizationByID(arguments.event.getArg("organizationID")) />
		
		<cftry>
			<cfset getOrganizationService().deleteOrganization(organization) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("deleteorganizationfailed") />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>

</cfcomponent>