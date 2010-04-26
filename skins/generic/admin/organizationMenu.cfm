<cfoutput>
	<script type="text/javascript">
		function deleteOrganization(organizationID) {
			if(confirm("#getProperty('resourceBundleService').getResourceBundle().getResource('confirmorganizationdelete')#")) {
				location.href = "#BuildUrl('admin.deleteOrganization')#organizationID/" + organizationID;
			}
		}
	</script>
	
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("manageorganizations")#</h2>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<ul>
		<li>
			<a href="#BuildUrl('admin.showOrganizationForm')#">
				#getProperty("resourceBundleService").getResourceBundle().getResource("addneworganization")#
			</a>
		</li>
	</ul>
	
	<cfif organizations.recordCount gt 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("organization")#</h>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("action")#</th>
				</tr>
				<cfloop query="organizations">
					<tr<cfif (organizations.currentRow MOD 2) EQ 0> class="odd"</cfif>>
						<td>#organizations.organization#</td>
						<td class="active">
							<cfif organizations.is_active eq 1>
								<img alt="Active" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick.png" />
							<cfelse>
								<img alt="Inactive" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick_disabled.png" />
							</cfif>
						</td>
						<td class="action">
							<a href="#BuildUrl('admin.showOrganizationForm')#organizationID/#organizations.organization_id#">
								#getProperty("resourceBundleService").getResourceBundle().getResource("edit")#
							</a>
							<a href="javascript:void(0);" onClick="javascript:deleteOrganization('#organizations.organization_id#');">
								#getProperty("resourceBundleService").getResourceBundle().getResource("delete")#
							</a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	<cfelse>
		<em>#getProperty("resourceBundleService").getResourceBundle().getResource("noorganizations")#</em>
	</cfif>
</cfoutput>