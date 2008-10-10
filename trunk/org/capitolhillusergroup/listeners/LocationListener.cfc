<cfcomponent 
	displayname="LocationListener" 
	output="false" 
	extends="MachII.framework.Listener">

	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- don't need anything here for now --->
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setLocationService" access="public" output="false" returntype="void">
		<cfargument name="locationService" type="org.capitolhillusergroup.location.LocationService" required="true" />
		<cfset variables.locationService = arguments.locationService />
	</cffunction>
	<cffunction name="getLocationService" access="public" output="false" returntype="org.capitolhillusergroup.location.LocationService">
		<cfreturn variables.locationService />
	</cffunction>
	
	<cffunction name="setSessionService" access="public" output="false" returntype="void">
		<cfargument name="sessionService" type="org.capitolhillusergroup.session.SessionService" required="true" />
		<cfset variables.sessionService = arguments.sessionService />
	</cffunction>
	<cffunction name="getSessionService" access="public" output="false" returntype="org.capitolhillusergroup.session.SessionService">
		<cfreturn variables.sessionService />
	</cffunction>
	
	<!--- listener methods --->
	<cffunction name="getLocationByID" access="public" output="false" returntype="org.capitolhillusergroup.location.Location">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfreturn getLocationService().getLocationByID(arguments.event.getArg("locationID", "")) />
	</cffunction>
	
	<cffunction name="getLocations" access="public" output="false" returntype="query">
		<cfreturn getLocationService().getLocations() />
	</cffunction>
	
	<cffunction name="getActiveLocations" access="public" output="false" returntype="query">
		<cfreturn getLocationService().getActiveLocations() />
	</cffunction>
	
	<cffunction name="processLocationForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var location = arguments.event.getArg("location") />
		<cfset var address = arguments.event.getArg("address") />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var exitEvent = "success" />
		<cfset var message = "" />
		<cfset var action = "" />
		
		<cfset audit.setIsActive(arguments.event.getArg("isActive", 0)) />
		
		<cfset location.setAddress(address) />
		
		<cfif location.getLocationID() is "">
			<cfset action = "add" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addlocationsuccessful") />
			<cfset audit.setCreatedByID(getSessionService().getUser().getPersonID()) />
			<cfset audit.setDTCreated(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset audit.setIPCreated(CGI.REMOTE_ADDR) />
		<cfelse>
			<cfset action = "update" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("updatelocationsuccessful") />
			<cfset audit.setModifiedByID(getSessionService().getUser().getPersonID()) />
			<cfset audit.setDTModified(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset audit.setIPModified(CGI.REMOTE_ADDR) />
		</cfif>
		
		<cfset location.setAudit(audit) />
		
		<cftry>
			<cfset getLocationService().saveLocation(location) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addupdatelocationfailed") />
				<cfset location.getAddress().setAddressID("") />
				<cfif action is "add">
					<cfset location.setLocationID("") />
				</cfif>
				<cfset arguments.event.setArg("location", location) />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="deleteLocation" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var exitEvent = "success" />
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("deletelocationsuccessful") />
		
		<cftry>
			<cfset getLocationService().deleteLocationByID(arguments.event.getArg("locationID")) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("deletelocationfailed") />
			</cfcatch>
		</cftry>

		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>

</cfcomponent>