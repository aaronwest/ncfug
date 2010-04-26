<cfcomponent 
	displayname="PresentationListener" 
	output="false" 
	extends="MachII.framework.Listener">

	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- don't need anything here for now --->
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setPresentationService" access="public" output="false" returntype="void">
		<cfargument name="presentationService" type="org.capitolhillusergroup.presentation.PresentationService" required="true" />
		<cfset variables.presentationService = arguments.presentationService />
	</cffunction>
	<cffunction name="getPresentationService" access="public" output="false" returntype="org.capitolhillusergroup.presentation.PresentationService">
		<cfreturn variables.presentationService />
	</cffunction>
	
	<cffunction name="setPersonService" access="public" output="false" returntype="void">
		<cfargument name="personService" type="org.capitolhillusergroup.person.PersonService" required="true" />
		<cfset variables.personService = arguments.personService />
	</cffunction>
	<cffunction name="getPersonService" access="public" output="false" returntype="org.capitolhillusergroup.person.PersonService">
		<cfreturn variables.personService />
	</cffunction>
	
	<cffunction name="setSessionService" access="public" output="false" returntype="void">
		<cfargument name="sessionService" type="org.capitolhillusergroup.session.SessionService" required="true" />
		<cfset variables.sessionService = arguments.sessionService />
	</cffunction>
	<cffunction name="getSessionService" access="public" output="false" returntype="org.capitolhillusergroup.session.SessionService">
		<cfreturn variables.sessionService />
	</cffunction>

	<!--- listener methods --->
	<cffunction name="getPresentations" access="public" output="false" returntype="array">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfreturn getPresentationService().getPresentations(orderBy = arguments.event.getArg("orderBy", "date")) />
	</cffunction>
	
	<cffunction name="getPresentationsAsQuery" access="public" output="false" returntype="query">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfreturn getPresentationService().getPresentationsAsQuery(orderBy = arguments.event.getArg("orderBy", "date")) />
	</cffunction>
	
	<cffunction name="getPresentationByID" access="public" output="false" returntype="org.capitolhillusergroup.presentation.Presentation">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getPresentationService().getPresentationByID(arguments.event.getArg("presentationID", "")) />
	</cffunction>
	
	<cffunction name="processPresentationForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var presentation = arguments.event.getArg("presentation") />
		<cfset var presenters = arrayNew(1) />
		<cfset var presenter = 0 />
		<cfset var action = "" />
		<cfset var message = "" />
		<cfset var exitEvent = "success" />
		<cfset var presenterID = 0 />
		
		<cfset presentation.getAudit().setIsActive(arguments.event.getArg("isActive", 0)) />
		
		<!--- deal with the file upload if necessary --->
		<cfif arguments.event.getArg("presentationFile") NEQ "">
			<cftry>
				<cffile action="upload" filefield="presentationFile" destination="#expandPath(getProperty('presentationFilePath'))#" nameconflict="makeunique" />
				<!--- if the upload was successful set the presentation file info to the presentation bean --->
				<cfif CFFILE.fileWasSaved>
					<cfset presentation.setPresentationFile(CFFILE.serverFile) />
				</cfif>
				
				<!--- delete the old file if needed --->
				<cfif arguments.event.getArg("oldPresentationFile") is not "">
					<cffile action="delete" 
							file="#expandPath(getProperty('presentationFilePath'))##arguments.event.getArg('oldPresentationFile')#" />
				</cfif>
				
				<cfcatch type="any">
					<cfset exitEvent = "failure" />
					<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("errormessagefileupload") & " " & CFCATCH.Detail />
				</cfcatch>
			</cftry>
		<cfelseif arguments.event.getArg("deleteFile", 0) eq 1>
			<cffile action="delete" file="#expandPath(getProperty('presentationFilePath'))##arguments.event.getArg('oldPresentationFile')#" />
			<cfset presentation.setPresentationFileTitle("") />
			<cfset presentation.setPresentationFileDescription("") />
		<cfelseif not arguments.event.isArgDefined("deleteFile") 
					and arguments.event.getArg("oldPresentationFile") is not "">
			<cfset presentation.setPresentationFile(arguments.event.getArg("oldPresentationFile")) />
		</cfif>
		
		<!--- get presenters --->
		<cfloop list="#arguments.event.getArg('presenterIDs')#" index="presenterID">
			<cfset presenter = getPersonService().getPersonByID(presenterID) />
			<cfset arrayAppend(presenters, presenter) />
		</cfloop>
		
		<cfset presentation.setPresenters(presenters) />

		<cfif exitEvent is "success">
			<cfif presentation.getPresentationID() is "">
				<cfset action = "add" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addpresentationsuccessful") />
				<cfset presentation.getAudit().setCreatedByID(getSessionService().getUser().getPersonID()) />
				<cfset presentation.getAudit().setDTCreated(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
				<cfset presentation.getAudit().setIPCreated(CGI.REMOTE_ADDR) />
			<cfelse>
				<cfset action = "update" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("updatepresentationsuccessful") />
				<cfset presentation.getAudit().setModifiedByID(getSessionService().getUser().getPersonID()) />
				<cfset presentation.getAudit().setDTModified(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
				<cfset presentation.getAudit().setIPModified(CGI.REMOTE_ADDR) />
			</cfif>
	
			<cftry>
				<cfset getPresentationService().savePresentation(presentation) />
				<cfcatch type="any">
					<!--- if this bombs and we uploaded a file, attempt to delete it --->
					<cfif presentation.getPresentationFile() is not "">
						<cffile action="delete" file="#expandPath(getProperty('presentationFilePath'))##presentation.getPresentationFile()#" />
					</cfif>
					
					<cfset exitEvent = "failure" />
					<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addupdatepresentationfailed") />
					
					<cfif action is "add">
						<cfset presentation.setPresentationID("") />
					</cfif>
					
					<cfset arguments.event.setArg("presentation", presentation) />
				</cfcatch>
			</cftry>
		</cfif>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="deletePresentation" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var exitEvent = "success" />
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("deletepresentationsuccessful") />
		<cfset var presentation = getPresentationService().getPresentationByID(arguments.event.getArg("presentationID")) />
		
		<cftry>
			<cfif presentation.getPresentationFile() is not "">
				<cffile action="delete" file="#expandPath(getProperty('presentationFilePath'))##presentation.getPresentationFile()#" />
			</cfif>
			
			<cfset getPresentationService().deletePresentation(presentation) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("deletepresentationfailed") />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>

</cfcomponent>