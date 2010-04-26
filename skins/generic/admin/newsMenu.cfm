<cfoutput>
	<script type="text/javascript">
		function deleteNews(newsID) {
			if(confirm("#getProperty('resourceBundleService').getResourceBundle().getResource('confirmnewsdelete')#")) {
				location.href = "#BuildUrl('admin.deleteNews')#newsID/" + newsID;
			}
		}
	</script>

	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("managenews")#</h2>

	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<ul>
		<li>
			<a href="#BuildUrl('admin.showNewsForm')#">
				#getProperty("resourceBundleService").getResourceBundle().getResource("addnewnewsitem")#
			</a>
		</li>
	</ul>
	
	<cfif news.recordCount gt 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("headline")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("dateposted")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("action")#</th>
				</tr>
				<cfloop query="news">
					<tr<cfif (news.currentRow MOD 2) EQ 0> class="odd"</cfif>>
						<td>#news.headline#</td>
						<td class="datetime">#getProperty("resourceBundleService").getLocaleUtils().i18nDateTimeFormat(news.dt_to_post, 3, 3)#</td>
						<td class="active">
							<cfif news.is_active eq 1>
								<img alt="Active" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick.png" />
							<cfelse>
								<img alt="Inactive" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick_disabled.png" />
							</cfif>
						</td>
						<td class="action">
							<a href="#BuildUrl('admin.showNewsForm')#newsID/#news.news_id#">
								#getProperty("resourceBundleService").getResourceBundle().getResource("edit")#
							</a>
							<a href="javascript:void(0);" onClick="javascript:deleteNews('#news.news_id#');">
								#getProperty("resourceBundleService").getResourceBundle().getResource("delete")#
							</a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	<cfelse>
		<em>#getProperty("resourceBundleService").getResourceBundle().getResource("nonews")#</em>
	</cfif>
</cfoutput>