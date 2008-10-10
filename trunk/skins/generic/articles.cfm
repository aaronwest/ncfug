<cfoutput>
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("articles")#</h2>
	
	<cfif ArrayLen(articles) gt 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("articletitle")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("author")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("category")#</th>
				</tr>
				<cfloop from="1" to="#arrayLen(articles)#" index="a">
					<cfset authorsare = articles[a].getAuthors() />
					<cfset categoriesare = articles[a].getCategories() />
					<tr<cfif (a MOD 2) EQ 0> class="odd"</cfif>>
						<td><a href="index.cfm?#getProperty('eventParameter')#=showArticleDetail&articleID=#articles[a].getArticleID()#">#articles[a].getTitle()#</a></td>
						<td>
							<cfloop from="1" to="#arrayLen(authorsare)#" index="au">
								<cfif au GT 1><br /></cfif>
								#authorsare[au].getFirstName()# #authorsare[au].getLastName()#
							</cfloop>
						</td>
						<td>
							<cfloop from="1" to="#arrayLen(categoriesare)#" index="cat">
								<cfif cat GT 1><br /></cfif>
								#categoriesare[cat].getCategory()#
							</cfloop>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	<cfelse>
		<em>#getProperty("resourceBundleService").getResourceBundle().getResource("noarticles")#</em>
	</cfif>
</cfoutput>
