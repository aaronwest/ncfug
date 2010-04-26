<cfcomponent 
	displayname="RoleListener" 
	output="false" 
	extends="MachII.framework.Listener">

	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- don't need anything here for now --->
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setRoleService" access="public" output="false" returntype="void">
		<cfargument name="roleService" type="org.capitolhillusergroup.role.RoleService" required="true" />
		<cfset variables.roleService = arguments.roleService />
	</cffunction>
	<cffunction name="getRoleService" access="public" output="false" returntype="org.capitolhillusergroup.role.RoleService">
		<cfreturn variables.roleService />
	</cffunction>

	<cffunction name="setSessionService" access="public" output="false" returntype="void">
		<cfargument name="sessionService" type="org.capitolhillusergroup.session.SessionService" required="true" />
		<cfset variables.sessionService = arguments.sessionService />
	</cffunction>
	<cffunction name="getSessionService" access="public" output="false" returntype="org.capitolhillusergroup.session.SessionService">
		<cfreturn variables.sessionService />
	</cffunction>
	
	<!--- listener methods --->
	<cffunction name="getRoles" access="public" output="false" returntype="query">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getRoleService().getRoles() />
	</cffunction>
	
	<cffunction name="getRoleByID" access="public" output="false" returntype="org.capitolhillusergroup.role.Role">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfreturn getRoleService().getRoleByID(arguments.event.getArg("roleID", "")) />
	</cffunction>
	
	<cffunction name="processRoleForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var role = arguments.event.getArg("role") />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var exitEvent = "success" />
		<cfset var message = "" />
		<cfset var action = "" />
		
		<cfset audit.setIsActive(arguments.event.getArg("isActive", 0)) />
		
		<cfif role.getRoleID() is "">
			<cfset action = "add" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addrolesuccessful") />
			<cfset audit.setCreatedByID(getSessionService().getUser().getPersonID()) />
			<cfset audit.setDTCreated(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset audit.setIPCreated(CGI.REMOTE_ADDR) />
		<cfelse>
			<cfset action = "update" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("updaterolesuccessful") />
			<cfset audit.setModifiedByID(getSessionService().getUser().getPersonID()) />
			<cfset audit.setDTModified(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset audit.setIPModified(CGI.REMOTE_ADDR) />
		</cfif>
		
		<cfset role.setAudit(audit) />
		
		<cftry>
			<cfset getRoleService().saveRole(role) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addupdaterolefailed") />
				<cfif action is "add">
					<cfset role.setRoleID("") />
				</cfif>
				<cfset arguments.event.setArg("role", role) />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="deleteRole" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var exitEvent = "success" />
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("deleterolesuccessful") />
		<cfset var role = getRoleService().getRoleByID(arguments.event.getArg("roleID")) />
		
		<cftry>
			<cfset getRoleService().deleteRole(role) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("deleterolefailed") />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>

</cfcomponent>