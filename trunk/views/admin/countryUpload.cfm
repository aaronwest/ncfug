<cfsilent>
	<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("uploadcountries") />
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/countryUpload.cfm" />