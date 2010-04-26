<cfcomponent 
	displayname="PhotoAlbumListener" 
	output="false" 
	extends="MachII.framework.Listener">

	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- don't need anything here for now --->
	</cffunction>
	
	<cffunction name="setPhotoAlbumService" access="public" output="false" returntype="void">
		<cfargument name="photoAlbumService" type="org.capitolhillusergroup.photoalbum.PhotoAlbumService" required="true" />
		<cfset variables.photoAlbumService = arguments.photoAlbumService />
	</cffunction>
	<cffunction name="getPhotoAlbumService" access="public" output="false" returntype="org.capitolhillusergroup.photoalbum.PhotoAlbumService">
		<cfreturn variables.photoAlbumService />
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
	
	<cffunction name="getPhotoAlbums" access="public" output="false" returntype="query" 
			hint="Returns a query containing either all or only active photo albums">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getPhotoAlbumService().getPhotoAlbums(arguments.event.getArg("activeOnly", true)) />
	</cffunction>
	
	<cffunction name="getPhotoAlbumById" access="public" output="false" returntype="org.capitolhillusergroup.photoalbum.PhotoAlbum">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getPhotoAlbumService().getPhotoAlbumById(arguments.event.getArg("photoAlbumID", "")) />
	</cffunction>
	
	<cffunction name="processPhotoAlbumForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var photoalbum = event.getArg("photoalbum") />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var exitEvent = "success" />
		<cfset var message = "" />
		<cfset var action = "" />
		
		<cfset audit.setIsActive(arguments.event.getArg("isActive", 0)) />
		
		<cfif photoalbum.getPhotoAlbumID() is "">
			<cfset action = "add" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addphotoalbumsuccessful") />
			<cfset audit.setCreatedByID(getSessionService().getUser().getPersonID()) />
			<cfset audit.setDTCreated(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset audit.setIPCreated(CGI.REMOTE_ADDR) />
		<cfelse>
			<cfset action = "update" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("updatephotoalbumsuccessful") />
			<cfset audit.setModifiedByID(getSessionService().getUser().getPersonID()) />
			<cfset audit.setDTModified(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset audit.setIPModified(CGI.REMOTE_ADDR) />
		</cfif>
		
		<cfset photoalbum.setAudit(audit) />
		
		<cftry>
			<cfset getPhotoAlbumService().savePhotoAlbum(photoalbum) />
			<cfcatch type="any">
				<cfrethrow>
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addupdatephotoalbumfailed") />
				<cfif action is "add">
					<cfset photoalbum.setPhotoAlbumID("") />
				</cfif>
				<cfset arguments.event.setArg("photoalbum", photoalbum) />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="deletePhotoAlbum" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("deletephotoalbumsuccessful") />
		
		<cftry>
			<cfset getPhotoAlbumService().deletePhotoAlbum(arguments.event.getArg("photoalbum")) />
			<cfcatch type="any">
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("deletephotoalbumfailed") />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		
		<cfset announceEvent("admin.showPhotoAlbumMenu_redirect", arguments.event.getArgs()) />
	</cffunction>
</cfcomponent>