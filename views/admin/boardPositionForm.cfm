<cfsilent>
	<cfset boardPosition = event.getArg("boardPosition") />
	
	<cfif boardPosition.getBoardPositionID() is "">
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("addnewboardposition") />
	<cfelse>
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("updateboardposition") />
	</cfif>
	
	<cfset boardPositionCount = event.getArg("boardPositionCount") />
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/boardPositionForm.cfm" />