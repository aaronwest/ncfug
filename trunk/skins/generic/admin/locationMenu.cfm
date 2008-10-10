<cfoutput>
	<script type="text/javascript">
		function deleteLocation(locationID) {
			if(confirm("#getProperty('resourceBundleService').getResourceBundle().getResource('confirmlocationdelete')#")) {
				location.href = "index.cfm?#getProperty('eventParameter')#=admin.deleteLocation&locationID=" + locationID;
			}
		}
	</script>
	
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("managelocations")#</h2>
	<ul>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showLocationForm">
				#getProperty("resourceBundleService").getResourceBundle().getResource("addnewlocation")#
			</a>
		</li>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showUploadCountriesForm">
				#getProperty("resourceBundleService").getResourceBundle().getResource("uploadcountries")#
			</a>
		</li>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showUploadStatesForm">
				#getProperty("resourceBundleService").getResourceBundle().getResource("uploadstates")#
			</a>
		</li>
	</ul>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<cfif locations.recordCount gt 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("location")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("address")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("action")#</th>
				</tr>
				<cfloop query="locations">
					<tr<cfif (locations.currentRow MOD 2) EQ 0> class="odd"</cfif>>
						<td>#locations.location#</td>
						<td >
							#locations.address_1#<br /><cfif locations.address_2 is not "">
							#locations.address_2#<br /></cfif>
							#locations.city#<cfif locations.state_abbr is not "">, #locations.state_abbr#</cfif><cfif locations.postal_code is not ""> #locations.postal_code#</cfif>
						</td>
						<td class="active">
							<cfif locations.is_active eq 1>
								<img alt="Active" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick.png" />
							<cfelse>
								<img alt="Inactive" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick_disabled.png" />
							</cfif>
						</td>
						<td class="action">
							<a href="index.cfm?#getProperty('eventParameter')#=admin.showLocationForm&amp;locationID=#locations.location_id#">
								#getProperty("resourceBundleService").getResourceBundle().getResource("edit")#
							</a>
							<a href="javascript:void(0);" onClick="javascript:deleteLocation('#locations.location_id#');">
								#getProperty("resourceBundleService").getResourceBundle().getResource("delete")#
							</a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	<cfelse>
		<em>#getProperty("resourceBundleService").getResourceBundle().getResource("nolocations")#</em>
	</cfif>
</cfoutput>