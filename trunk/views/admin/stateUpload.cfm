<cfsilent>
	<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("uploadstates") />
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/stateUpload.cfm" />