<cfsilent>
	<cfset article = event.getArg("article") />
	<cfset authors = article.getAuthors()>
	<cfset categories = article.getCategories()>
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/articleDetail.cfm" />