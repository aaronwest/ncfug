<cfcomponent 
	displayname="PresentationService" 
	output="false" 
	hint="PresentationService">

	<cffunction name="init" access="public" output="false" returntype="PresentationService">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setPresentationDAO" access="public" output="false" returntype="void">
		<cfargument name="presentationDAO" type="PresentationDAO" required="true" />
		<cfset variables.presentationDAO = arguments.presentationDAO />
	</cffunction>
	<cffunction name="getPresentationDAO" access="public" output="false" returntype="PresentationDAO">
		<cfreturn variables.presentationDAO />
	</cffunction>
	
	<cffunction name="setPresentationGateway" access="public" output="false" returntype="void">
		<cfargument name="presentationGateway" type="PresentationGateway" required="true" />
		<cfset variables.presentationGateway = arguments.presentationGateway />
	</cffunction>
	<cffunction name="getPresentationGateway" access="public" output="false" returntype="PresentationGateway">
		<cfreturn variables.presentationGateway />
	</cffunction>

	<!--- service methods --->
	<cffunction name="getPresentationBean" access="public" output="false" returntype="Presentation">
		<cfreturn createObject("component", "Presentation").init() />
	</cffunction>
	
	<cffunction name="getPresentations" access="public" output="false" returntype="array">
		<cfargument name="activeOnly" type="boolean" required="false" default="false" />
		<cfargument name="orderBy" type="string" required="false" default="date" />
		
		<cfset var presentationsQuery = 0 />
		<cfset var presentations = arrayNew(1) />
		<cfset var presentation = 0 />
		
		<cfset presentationsQuery = getPresentationGateway().getPresentations(arguments.activeOnly, arguments.orderBy) />
		
		<cfif presentationsQuery.recordCount gt 0>
			<cfloop query="presentationsQuery">
				<cfset presentation = getPresentationByID(presentationsQuery.presentation_id) />
				<cfset arrayAppend(presentations, presentation) />
			</cfloop>
		</cfif>
		
		<cfreturn presentations />
	</cffunction>
	
	<cffunction name="getPresentationsAsQuery" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="false" />
		<cfargument name="orderBy" type="string" required="false" default="date" />
		
		<cfreturn getPresentationGateway().getPresentations(arguments.activeOnly, arguments.orderBy) />
	</cffunction>
	
	<cffunction name="getPresentationByID" access="public" output="false" returntype="Presentation">
		<cfargument name="presentationID" type="string" required="true" />
		
		<cfset var presentation = getPresentationBean() />
		<cfset presentation.setPresentationID(arguments.presentationID) />
		
		<cfif arguments.presentationID is not "">
			<cfset getPresentationDAO().fetch(presentation) />
		</cfif>
		
		<cfreturn presentation />
	</cffunction>
	
	<cffunction name="getPresentationsByMeetingID" access="public" output="false" returntype="array">
		<cfargument name="meetingID" type="uuid" required="true" />
		
		<cfset var presentationIDs = "" />
		<cfset var presentationID = "" />
		<cfset var presentation = 0 />
		<cfset var presentations = arrayNew(1) />
		<cfset var i = 0 />
		
		<cfset presentationIDs = getPresentationGateway().getPresentationIDsByMeetingID(arguments.meetingID) />
		
		<cfif presentationIDs is not "">
			<cfloop index="presentationID" list="#presentationIDs#" delimiters=",">
				<cfset presentation = createObject("component", "Presentation").init(presentationID) />
				<cfset getPresentationDAO().fetch(presentation) />
				<cfset arrayAppend(presentations, presentation) />
			</cfloop>
		</cfif>
		
		<cfreturn presentations />
	</cffunction>
	
	<cffunction name="deletePresentationsByMeetingID" access="public" output="false" returntype="void" 
			hint="Deletes presentations and files associated with a particular meeting ID">
		<cfargument name="meetingID" type="uuid" required="true" />
		
		<cfset var presentations = getPresentationsByMeetingID(arguments.meetingID) />
		<cfset var i = 0 />
		
		<cfif arrayLen(presentations) gt 0>
			<cfloop index="i" from="1" to="#arrayLen(presentations)#" step="1">
				<cfset getPresentationDAO().delete(presentations[i]) />
			</cfloop>
		</cfif>
	</cffunction>
	
	<cffunction name="savePresentation" access="public" output="false" returntype="void">
		<cfargument name="presentation" type="Presentation" required="true" />
		<cfset getPresentationDAO().save(arguments.presentation) />
	</cffunction>
	
	<cffunction name="deletePresentation" access="public" output="false" returntype="void">
		<cfargument name="presentation" type="Presentation" required="true" />
		<cfset getPresentationDAO().delete(arguments.presentation) />
	</cffunction>

</cfcomponent>