<cfsilent>
	<cfset meeting = event.getArg("meeting") />
	<cfset locations = event.getArg("locations") />
	<cfset presentations = event.getArg("presentations") />
	<cfset currentPresentations = meeting.getPresentations() />
	<cfset currentPresentationIDs = "" />
	
	<cfloop index="i" from="1" to="#arrayLen(currentPresentations)#" step="1">
		<cfset presentation = currentPresentations[i] />
		<cfset currentPresentationIDs = listAppend(currentPresentationIDs, presentation.getPresentationID(), ",") />
	</cfloop>
	
	<cfif meeting.getMeetingID() is "">
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("addnewmeeting") />
	<cfelse>
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("updatemeeting") />
	</cfif>
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/meetingForm.cfm" />