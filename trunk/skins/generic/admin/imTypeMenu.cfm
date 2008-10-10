<cfoutput>
	<script type="text/javascript">
		function deleteIMType(imTypeID) {
			if(confirm("#getProperty('resourceBundleService').getResourceBundle().getResource('confirmimtypedelete')#")) {
				location.href = "index.cfm?#getProperty('eventParameter')#=admin.deleteIMType&imTypeID=" + imTypeID;
			}
		}
	</script>
	
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("manageimtypes")#</h2>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<ul>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showIMTypeForm">
				#getProperty("resourceBundleService").getResourceBundle().getResource("addnewimtype")#
			</a>
		</li>
	</ul>
	
	<cfif imTypes.recordCount GT 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("imtype")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("action")#</th>
				</tr>
				<cfloop query="imTypes">
					<tr<cfif (imTypes.currentRow mod 2) EQ 0> class="odd"</cfif>>
						<td>#imTypes.im_type#</td>
						<td class="action">
							<a href="index.cfm?#getProperty('eventParameter')#=admin.showIMTypeForm&amp;imTypeID=#imTypes.im_type_id#">
								#getProperty("resourceBundleService").getResourceBundle().getResource("edit")#
							</a>
							<a href="javascript:void(0);" onClick="javascript:deleteIMType('#imTypes.im_type_id#')">
								#getProperty("resourceBundleService").getResourceBundle().getResource("delete")#
							</a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	<cfelse>
		<em>- #getProperty("resourceBundleService").getResourceBundle().getResource("noimtypesdefined")# -</em>
	</cfif>
</cfoutput>