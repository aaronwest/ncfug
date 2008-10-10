<cfcomponent 
	displayname="PersonListener" 
	output="false" 
	extends="MachII.framework.Listener">

	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- don't need anything here for now --->
	</cffunction>
	
	<!--- dependencies --->
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
	<cffunction name="getAllPeople" access="public" output="false" returntype="query">
		<cfreturn getPersonService().getPeople() />
	</cffunction>
	
	<cffunction name="getActivePeople" access="public" output="false" returntype="query">
		<cfreturn getPersonService().getPeople(true) />
	</cffunction>
	
	<cffunction name="getPersonByID" access="public" output="false" returntype="org.capitolhillusergroup.person.Person">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfif Find("member.",ARGUMENTS.event.getName())>
			<cfset ARGUMENTS.event.setArg("personID",getSessionService().getUser().getPersonID())>
		</cfif>
		
		<cfreturn getPersonService().getPersonByID(arguments.event.getArg("personID", "")) />
	</cffunction>
	
	<cffunction name="processRegistrationForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var exitEvent = "success" />
		<cfset var message = "" />
		
		<cfif getProperty("useCaptcha") AND ARGUMENTS.event.isArgDefined("captchaMessage")>
			<cfset exitEvent =  "failure" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("captchafail") />
			<cfset arguments.event.setArg("message", message) />
			<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
		<cfelse>
			<cfset processPersonForm(ARGUMENTS.event)>
		</cfif>
		
	</cffunction>
	
	<cffunction name="processPersonForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var person = arguments.event.getArg("person") />
		<cfset var organization = arguments.event.getArg("organization") />
		<cfset var address = arguments.event.getArg("address") />
		<cfset var role = arguments.event.getArg("role") />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var bio = arguments.event.getArg("bio") />
		<cfset var ims = arrayNew(2) />
		<cfset var formField = "" />
		<cfset var i = 0 />
		<cfset var exitEvent = "success" />
		<cfset var message = "" />
		
		<cfset audit.setIsActive(arguments.event.getArg("isActive", 0)) />
		
		<cfif person.getPersonID() is "">
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addpersonsuccessful") />
			<cfset audit.setCreatedByID(getSessionService().getUser().getPersonID()) />
			<cfset audit.setDTCreated(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset audit.setIPCreated(CGI.REMOTE_ADDR) />
		<cfelse>
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("updatepersonsuccessful") />
			<cfset audit.setModifiedByID(getSessionService().getUser().getPersonID()) />
			<cfset audit.setDTModified(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset audit.setIPModified(CGI.REMOTE_ADDR) />
		</cfif>
		
		<cfset person.setOrganization(organization) />
		<cfset person.setRole(role) />
		<cfset person.setAudit(audit) />
		<cfset person.setAddress(address) />
		<cfset person.setBio(bio) />
		
		<!--- Address --->
		<cfset address.setAudit(audit) />
		
		<!--- deal with the file upload if necessary --->
		<cfif arguments.event.getArg("image") is not "">
			<cftry>
				<cffile action="upload" filefield="image" 
						destination="#expandPath(getProperty('personImageFilePath'))#" 
						nameconflict="makeunique" />
				<!--- if the upload was successful set the image file info to the person bean --->
				<cfif CFFILE.fileWasSaved>
					<cfset person.setImage(CFFILE.serverFile) />
				</cfif>
				
				<!--- delete the old file if needed --->
				<cfif arguments.event.getArg("oldImage") is not "">
					<cffile action="delete" 
							file="#expandPath(getProperty('personImageFilePath'))##arguments.event.getArg('oldImage')#" />
				</cfif>
				
				<cfcatch type="any">
					<cfset exitEvent = "failure" />
					<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("errormessagefileupload") & " " & CFCATCH.Detail />
				</cfcatch>
			</cftry>
		<cfelseif arguments.event.getArg("deleteFile", 0) eq 1>
			<cffile action="delete" file="#expandPath(getProperty('personImageFilePath'))##arguments.event.getArg('oldImage')#" />
			<cfset person.setImage("") />
		<cfelseif not arguments.event.isArgDefined("deleteFile") 
					and arguments.event.getArg("oldImage") is not "">
			<cfset person.setImage(arguments.event.getArg("oldImage")) />
		</cfif>
		
		<!--- deal with im accounts --->
		<cfloop collection="#arguments.event.getArgs()#" item="formField">
			<cfif ucase(listFirst(formField, "_")) is "IMACCOUNT">
				<cfif arguments.event.getArg(formField) is not "">
					<cfset i = i + 1 />
					<cfset ims[i][1] = listLast(formField, "_") />
					<cfset ims[i][2] = arguments.event.getArg(formField) />
				</cfif>
			</cfif>
		</cfloop>
		
		<cfset person.setIMs(ims) />
		
		<cftry>
			<cfset getPersonService().savePerson(person) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addupdatepersonfailed") />
				<cfset person.setPersonID("") />
				<cfset arguments.event.setArg("person", person) />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>

	<cffunction name="deletePerson" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var exitEvent = "success" />
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("deletepersonsuccessful") />
		<cfset var person = getPersonService().getPersonByID(arguments.event.getArg("personID")) />
		
		<cftry>
			<cfset getPersonService().deletePerson(person) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("deletepersonfailed") />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="updateStatusPerson" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var exitEvent = "success" />
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("updatestatuspersonsuccessful") />
		<cfset var person = getPersonService().getPersonByID(arguments.event.getArg("personID")) />
		<cfset var status = arguments.event.getArg('status') />
		
		<cftry>
			<cfset getPersonService().updateStatusPerson(person,status) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("updatestatuspersonfailed") />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>

</cfcomponent>