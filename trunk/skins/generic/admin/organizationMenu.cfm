<cfoutput>
	<script type="text/javascript">
		function deleteOrganization(organizationID) {
			if(confirm("#getProperty('resourceBundleService').getResourceBundle().getResource('confirmorganizationdelete')#")) {
				location.href = "index.cfm?#getProperty('eventParameter')#=admin.deleteOrganization&organizationID=" + organizationID;
			}
		}
	</script>
	
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("manageorganizations")#</h2>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<ul>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showOrganizationForm">
				#getProperty("resourceBundleService").getResourceBundle().getResource("addneworganization")#
			</a>
		</li>
	</ul>
	
	<cfif organizations.recordCount gt 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("organization")#</h>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("action")#</th>
				</tr>
				<cfloop query="organizations">
					<tr<cfif (organizations.currentRow MOD 2) EQ 0> class="odd"</cfif>>
						<td>#organization#</td>
						<td class="action">
							<a href="index.cfm?#getProperty('eventParameter')#=admin.showOrganizationForm&amp;organizationID=#organizations.organization_id#">
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