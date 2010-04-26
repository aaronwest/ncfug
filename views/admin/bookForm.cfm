<cfsilent>
	<cfset book = event.getArg("book") />
	<cfset authors = event.getArg("authors") />
	<cfset categories = event.getArg("categories") />
	<cfset currentAuthors = book.getAuthors() />
	<cfset currentAuthorIDs = "" />
	<cfset currentCategories = book.getCategories() />
	<cfset currentCategoryIDs = "" />
	
	<cfloop index="i" from="1" to="#arrayLen(currentAuthors)#" step="1">
		<cfset author = currentAuthors[i] />
		<cfset currentAuthorIDs = listAppend(currentAuthorIDs, author.getPersonID(), ",") />
	</cfloop>
	
	<cfloop index="i" from="1" to="#arrayLen(currentCategories)#" step="1">
		<cfset category = currentCategories[i] />
		<cfset currentCategoryIDs = listAppend(currentCategoryIDs, category.getCategoryID(), ",") />
	</cfloop>
	
	<cfif book.getBookID() is "">
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("addnewbook") />
	<cfelse>
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("updatebook") />
	</cfif>
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/bookForm.cfm" />