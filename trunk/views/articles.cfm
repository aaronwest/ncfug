<cfsilent>
	<cfset articles = event.getArg("articles") />
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/articles.cfm" />
