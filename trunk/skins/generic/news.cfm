<cfoutput>
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("news")#</h2>
	
	<cfif news.recordCount gt 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("headline")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("date")#</th>
				</tr>
				<cfloop query="news">
					<tr<cfif (news.currentRow MOD 2) EQ 0> class="odd"</cfif>>
						<td><a href="index.cfm?#getProperty('eventParameter')#=showNewsDetail&amp;newsID=#news.news_id#">#news.headline#</a></td>
						<td class="datetime">#getProperty("resourceBundleService").getLocaleUtils().i18nDateTimeFormat(news.dt_to_post, 3, 3)#</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	<cfelse>
		<em>#getProperty("resourceBundleService").getResourceBundle().getResource("nonews")#</em>
	</cfif>
</cfoutput>
