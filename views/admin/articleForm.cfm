<cfsilent>
	<cfset article = event.getArg("article") />
	<cfset authors = event.getArg("authors") />
	<cfset categories = event.getArg("categories") />
	<cfset currentAuthors = article.getAuthors() />
	<cfset currentAuthorIDs = "" />
	<cfset currentCategories = article.getCategories() />
	<cfset currentCategoryIDs = "" />
	
	<cfloop index="i" from="1" to="#arrayLen(currentAuthors)#" step="1">
		<cfset author = currentAuthors[i] />
		<cfset currentAuthorIDs = listAppend(currentAuthorIDs, author.getPersonID(), ",") />
	</cfloop>
	
	<cfloop index="i" from="1" to="#arrayLen(currentCategories)#" step="1">
		<cfset category = currentCategories[i] />
		<cfset currentCategoryIDs = listAppend(currentCategoryIDs, category.getCategoryID(), ",") />
	</cfloop>

	<cfif article.getArticleID() is "">
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("addnewarticle") />
	<cfelse>
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("updatearticle") />
	</cfif>
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/articleForm.cfm" />