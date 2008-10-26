<cfcomponent 
	displayname="PhotoListener" 
	output="false" 
	extends="MachII.framework.Listener">

	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- don't need anything here for now --->
	</cffunction>
	
	<cffunction name="setPhotoService" access="public" output="false" returntype="void">
		<cfargument name="photoService" type="org.capitolhillusergroup.photo.PhotoService" required="true" />
		<cfset variables.photoService = arguments.photoService />
	</cffunction>
	<cffunction name="getPhotoService" access="public" output="false" returntype="org.capitolhillusergroup.photo.PhotoService">
		<cfreturn variables.photoService />
	</cffunction>
		
	<cffunction name="setSessionService" access="public" output="false" returntype="void">
		<cfargument name="sessionService" type="org.capitolhillusergroup.session.SessionService" 
					required="true" />
		<cfset variables.sessionService = arguments.sessionService />
	</cffunction>
	<cffunction name="getSessionService" access="public" output="false" 
				returntype="org.capitolhillusergroup.session.SessionService">
		<cfreturn variables.sessionService />
	</cffunction>
	
	<cffunction name="getPhotos" access="public" output="false" returntype="query" 
			hint="Returns a query containing either all or only active photos">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getPhotoService().getPhotos(arguments.event.getArg("activeOnly", true)) />
	</cffunction>
	
	<cffunction name="getPhotoById" access="public" output="false" returntype="org.capitolhillusergroup.photo.Photo">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getPhotoService().getPhotoById(arguments.event.getArg("photoID", "")) />
	</cffunction>
	
	<cffunction name="processPhotoForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var photo = event.getArg("photo") />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var exitEvent = "success" />
		<cfset var message = "" />
		<cfset var action = "" />
		
		<cfset audit.setIsActive(arguments.event.getArg("isActive", 0)) />
		
		<cfif photo.getPhotoID() is "">
			<cfset action = "add" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addphotosuccessful") />
			<cfset audit.setCreatedByID(getSessionService().getUser().getPersonID()) />
			<cfset audit.setDTCreated(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset audit.setIPCreated(CGI.REMOTE_ADDR) />
		<cfelse>
			<cfset action = "update" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("updatephotosuccessful") />
			<cfset audit.setModifiedByID(getSessionService().getUser().getPersonID()) />
			<cfset audit.setDTModified(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset audit.setIPModified(CGI.REMOTE_ADDR) />
		</cfif>
		
		<cfset photo.setAudit(audit) />
		
		<cftry>
			<cfset getPhotoService().savePhoto(photo) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addupdatephotofailed") />
				<cfif action is "add">
					<cfset photoalbum.setPhotoAlbumID("") />
				</cfif>
				<cfset arguments.event.setArg("photo", photo) />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="deletePhoto" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("deletephotosuccessful") />
		
		<cftry>
			<cfset getPhotoService().deletePhoto(arguments.event.getArg("photo")) />
			<cfcatch type="any">
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("deletephotofailed") />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		
		<cfset announceEvent("admin.showPhotoMenu_redirect", arguments.event.getArgs()) />
	</cffunction>
</cfcomponent>