<cfoutput>
	<script type="text/javascript">
		function deleteBook(bookID) {
			if(confirm("#getProperty('resourceBundleService').getResourceBundle().getResource('confirmbookdelete')#")) {
				location.href = "#BuildUrl('admin.deleteBook')#bookID/" + bookID;
			}
		}
	</script>
	
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("managebooks")#</h2>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<ul>
		<li>
			<a href="#BuildUrl('admin.showBookForm')#">
				#getProperty("resourceBundleService").getResourceBundle().getResource("addnewbook")#
			</a>
		</li>
		<li>
			<a href="#BuildUrl('admin.showCategoryMenu')#">
				#getProperty("resourceBundleService").getResourceBundle().getResource("managecategories")#
			</a>
		</li>
	</ul>
	
	<cfif books.recordCount gt 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("title")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("action")#</th>
				</tr>
				<cfloop query="books">
					<tr<cfif (books.currentRow MOD 2) EQ 0> class="odd"</cfif>>
						<td>#books.title#</td>
						<td class="active">
							<cfif books.is_active eq 1>
								<img alt="Active" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick.png" />
							<cfelse>
								<img alt="Inactive" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick_disabled.png" />
							</cfif>
						</td>
						<td class="action">
							<a href="#BuildUrl('admin.showBookForm')#bookID/#books.book_id#">
								#getProperty("resourceBundleService").getResourceBundle().getResource("edit")#
							</a>
							<a href="javascript:void(0);" onClick="javascript:deleteBook('#books.book_id#');">
								#getProperty("resourceBundleService").getResourceBundle().getResource("delete")#
							</a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	<cfelse>
		<em>#getProperty("resourceBundleService").getResourceBundle().getResource("nobooks")#</em>
	</cfif>
</cfoutput>