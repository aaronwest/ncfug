<cfsilent>
	<cfset news = event.getArg("news") />
	
	<cfif news.getNewsID() is "">
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("addnewnewsitem") />
	<cfelse>
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("updatenewsitem") />
	</cfif>
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/newsForm.cfm" />