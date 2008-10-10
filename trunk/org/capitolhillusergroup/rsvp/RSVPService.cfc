<cfcomponent 
	displayname="RSVPService" 
	output="false" 
	hint="RSVPService">

	<cffunction name="init" access="public" output="false" returntype="RSVPService">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setRSVPDAO" access="public" output="false" returntype="void">
		<cfargument name="rsvpDAO" type="RSVPDAO" required="true" />
		<cfset variables.rsvpDAO = arguments.rsvpDAO />
	</cffunction>
	<cffunction name="getRSVPDAO" access="public" output="false" returntype="RSVPDAO">
		<cfreturn variables.rsvpDAO />
	</cffunction>
	
	<cffunction name="setRSVPGateway" access="public" output="false" returntype="void">
		<cfargument name="rsvpGateway" type="RSVPGateway" required="true" />
		<cfset variables.rsvpGateway = arguments.rsvpGateway />
	</cffunction>
	<cffunction name="getRSVPGateway" access="public" output="false" returntype="RSVPGateway">
		<cfreturn variables.rsvpGateway />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getRSVPBean" access="public" output="false" returntype="RSVP">
		<cfreturn createObject("component", "RSVP").init() />
	</cffunction>

	<cffunction name="getRSVPByID" access="public" output="false" returntype="RSVP">
		<cfargument name="rsvpID" type="string" required="true" />
		
		<cfset var rsvp = getRSVPBean() />
		<cfset rsvp.setRSVPID(arguments.rsvpID) />
		
		<cfif arguments.rsvpID is not "">
			<cfset getRSVPDAO().fetch(rsvp) />
		</cfif>
		
		<cfreturn rsvp />
	</cffunction>
	
	<cffunction name="saveRSVP" access="public" output="false" returntype="void">
		<cfargument name="rsvp" type="RSVP" required="true" />
		
		<cfset getRSVPDAO().save(arguments.rsvp) />
	</cffunction>
	
	<cffunction name="rsvpExists" access="public" output="false" returntype="boolean">
		<cfargument name="meetingID" type="string" required="true" />
		<cfargument name="email" type="string" required="true" />
		
		<cfreturn getRSVPGateway().rsvpExists(arguments.meetingID, arguments.email) />
	</cffunction>
	
	<cffunction name="getRSVPsByMeetingID" access="public" output="false" returntype="query">
		<cfargument name="meetingID" type="string" required="true" />
		
		<cfreturn getRSVPGateway().getRSVPsByMeetingID(arguments.meetingID) />
	</cffunction>
	
	<cffunction name="deleteRSVP" access="public" output="false" returntype="void">
		<cfargument name="rsvp" type="RSVP" required="true" />
		
		<cfset getRSVPDAO().delete(arguments.rsvp) />
	</cffunction>

</cfcomponent>