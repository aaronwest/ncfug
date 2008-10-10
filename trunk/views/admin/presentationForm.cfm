<cfsilent>
	<cfset presentation = event.getArg("presentation") />
	<cfset presenters = event.getArg("presenters") />
	<cfset currentPresenters = presentation.getPresenters() />
	<cfset currentPresenterIDs = "" />
	
	<cfloop index="i" from="1" to="#arrayLen(currentPresenters)#" step="1">
		<cfset presenter = currentPresenters[i] />
		<cfset currentPresenterIDs = listAppend(currentPresenterIDs, presenter.getPersonID(), ",") />
	</cfloop>
	
	<cfif presentation.getPresentationID() is "">
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("addnewpresentation") />
	<cfelse>
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("updatepresentation") />
	</cfif>
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/presentationForm.cfm" />