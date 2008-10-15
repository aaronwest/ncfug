<cfoutput>
	<h2>#article.getTitle()#</h2>
	
	<h3><cfif ArrayLen(authors) GT 1>#getProperty("resourceBundleService").getResourceBundle().getResource("authors")#<cfelse>#getProperty("resourceBundleService").getResourceBundle().getResource("author")#</cfif>: <cfloop from="1" to="#arrayLen(authors)#" index="au">
								<cfif au GT 1><br /></cfif>
								#authors[au].getFirstName()# #authors[au].getLastName()#
							</cfloop><br />
	<cfif arrayLen(categories) GT 1>#getProperty("resourceBundleService").getResourceBundle().getResource("categories")#<cfelse>#getProperty("resourceBundleService").getResourceBundle().getResource("category")#</cfif>: <cfloop from="1" to="#arrayLen(categories)#" index="cat">
								<cfif cat GT 1><br /></cfif>
								#categories[cat].getCategory()#
							</cfloop></h3>
	
	<p>#article.getContent()#</p>
	
	<p><a href="#getProperty('baseURL')##getProperty('eventParameter')#/articles">&lt;&lt;#getProperty("resourceBundleService").getResourceBundle().getResource("backtoarticles")#</a></p>
</cfoutput>
