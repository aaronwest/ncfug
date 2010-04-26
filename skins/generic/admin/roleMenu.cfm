<cfoutput>
	<script type="text/javascript">
		function deleteRole(roleID) {
			if(confirm("#getProperty('resourceBundleService').getResourceBundle().getResource('confirmroledelete')#")) {
				location.href = "#BuildUrl('admin.deleteRole')#roleID/" + roleID;
			}
		}
	</script>
	
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("manageroles")#</h2>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<ul>
		<li>
			<a href="#BuildUrl('admin.showRoleForm')#">
				#getProperty("resourceBundleService").getResourceBundle().getResource("addnewrole")#
			</a>
		</li>
	</ul>
	
	<cfif roles.recordCount gt 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("role")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("action")#</th>
				</tr>
				<cfloop query="roles">
					<tr<cfif (roles.currentRow MOD 2) EQ 0> class="odd"</cfif>>
						<td>#roles.role#</td>
						<td class="active">
							<cfif roles.is_active eq 1>
								<img alt="Active" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick.png" />
							<cfelse>
								<img alt="Inactive" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick_disabled.png" />
							</cfif>
						</td>
						<td class="action">
							<a href="#BuildUrl('admin.showRoleForm')#roleID/#roles.role_id#">
								#getProperty("resourceBundleService").getResourceBundle().getResource("edit")#
							</a>
							<a href="javascript:void(0);" onClick="javascript:deleteRole('#roles.role_id#');">
								#getProperty("resourceBundleService").getResourceBundle().getResource("delete")#
							</a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	<cfelse>
		<em>#getProperty("resourceBundleService").getResourceBundle().getResource("noroles")#</em>
	</cfif>
</cfoutput>