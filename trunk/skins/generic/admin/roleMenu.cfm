<cfoutput>
	<script type="text/javascript">
		function deleteRole(roleID) {
			if(confirm("#getProperty('resourceBundleService').getResourceBundle().getResource('confirmroledelete')#")) {
				location.href = "index.cfm?#getProperty('eventParameter')#=admin.deleteRole&roleID=" + roleID;
			}
		}
	</script>
	
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("manageroles")#</h2>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<ul>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showRoleForm">
				#getProperty("resourceBundleService").getResourceBundle().getResource("addnewrole")#
			</a>
		</li>
	</ul>
	
	<cfif roles.recordCount gt 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("role")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("action")#</th>
				</tr>
				<cfloop query="roles">
					<tr<cfif (roles.currentRow MOD 2) EQ 0> class="odd"</cfif>>
						<td>#role#</td>
						<td class="action">
							<a href="index.cfm?#getProperty('eventParameter')#=admin.showRoleForm&amp;roleID=#roles.role_id#">
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