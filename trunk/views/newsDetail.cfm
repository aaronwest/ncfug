<cfsilent>
	<cfset news = event.getArg("news") />
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/newsDetail.cfm" />
