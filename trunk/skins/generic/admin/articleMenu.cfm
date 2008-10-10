<cfoutput>
	<script type="text/javascript">
		function deleteArticle(articleID) {
			if(confirm("#getProperty('resourceBundleService').getResourceBundle().getResource('confirmarticledelete')#")) {
				location.href = "index.cfm?#getProperty('eventParameter')#=admin.deleteArticle&articleID=" + articleID;
			}
		}
	</script>
	
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("managearticles")#</h2>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<ul>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showArticleForm">
				#getProperty("resourceBundleService").getResourceBundle().getResource("addnewarticle")#
			</a>
		</li>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showCategoryMenu">
				#getProperty("resourceBundleService").getResourceBundle().getResource("managecategories")#
			</a>
		</li>
	</ul>
	
	<cfif articles.recordCount gt 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("title")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("date")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("action")#</th>
				</tr>
				<cfloop query="articles">
					<tr<cfif (articles.currentRow MOD 2) EQ 0> class="odd"</cfif>>
						<td>#articles.title#</td>
						<td class="datetime">#getProperty("resourceBundleService").getLocaleUtils().i18nDateTimeFormat(articles.dt_created, 3, 3)#</td>
						<td class="active">
							<cfif articles.is_active eq 1>
								<img alt="Active" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick.png" />
							<cfelse>
								<img alt="Inactive" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick_disabled.png" />
							</cfif>
						</td>
						<td class="action">
							<a href="index.cfm?#getProperty('eventParameter')#=admin.showArticleForm&amp;articleID=#articles.article_id#">
								#getProperty("resourceBundleService").getResourceBundle().getResource("edit")#
							</a>
							<a href="javascript:void(0);" onClick="javascript:deleteArticle('#articles.article_id#');">
								#getProperty("resourceBundleService").getResourceBundle().getResource("delete")#
							</a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	<cfelse>
		<em>#getProperty("resourceBundleService").getResourceBundle().getResource("noarticles")#</em>
	</cfif>
</cfoutput>