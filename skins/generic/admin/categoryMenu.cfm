<cfoutput>
	<script type="text/javascript">
		function deleteCategory(categoryID) {
			if(confirm("#getProperty('resourceBundleService').getResourceBundle().getResource('confirmcategorydelete')#")) {
				location.href = "#BuildUrl('admin.deleteCategory')#categoryID/" + categoryID;
			}
		}
	</script>
	
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("managecategories")#</h2>
	<ul>
		<li>
			<a href="#BuildUrl('admin.showCategoryForm')#">
				#getProperty("resourceBundleService").getResourceBundle().getResource("addnewcategory")#
			</a>
		</li>
	</ul>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<cfif categories.recordCount GT 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("category")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("action")#</th>
				</tr>
				<cfloop query="categories">
					<tr<cfif (categories.currentRow mod 2) EQ 0> class="odd"</cfif>>
						<td>#categories.category#</td>
						<td class="active">
							<cfif categories.is_active eq 1>
								<img alt="Active" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick.png" />
							<cfelse>
								<img alt="Inactive" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick_disabled.png" />
							</cfif>
						</td>
						<td class="action">
							<a href="#BuildUrl('admin.showCategoryForm')#categoryID/#categories.category_id#">
								#getProperty("resourceBundleService").getResourceBundle().getResource("edit")#
							</a>
							<a href="javascript:void(0);" onClick="javascript:deleteCategory('#categories.category_id#');">
								#getProperty("resourceBundleService").getResourceBundle().getResource("delete")#
							</a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	<cfelse>
		<em>#getProperty("resourceBundleService").getResourceBundle().getResource("nocategories")#</em>
	</cfif>
</cfoutput>