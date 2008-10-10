<cfoutput>
	<script type="text/javascript">
		function deletePerson(personID) {
			if(confirm("#getProperty('resourceBundleService').getResourceBundle().getResource('confirmpersondelete')#")) {
				location.href = "index.cfm?#getProperty('eventParameter')#=admin.deletePerson&personID=" + personID;
			}
		}
		function toggleActive(personID,toggle) {
			var toggleDialog = "";
			if (toggle == 0) {
				toggleDialog = "#getProperty('resourceBundleService').getResourceBundle().getResource('confirmpersoninactive')#";
			}
			else {
				toggleDialog = "#getProperty('resourceBundleService').getResourceBundle().getResource('confirmpersonactive')#";
			}
			if(confirm(toggleDialog)) {
				location.href = "index.cfm?#getProperty('eventParameter')#=admin.updateStatusPerson&personID=" + personID + "&status=" + toggle;
			}
		}
	</script>
	
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("managepeople")#</h2>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<ul>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showPersonForm">
				#getProperty("resourceBundleService").getResourceBundle().getResource("addnewperson")#
			</a>
		</li>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showBoardPositionMenu">
				#getProperty("resourceBundleService").getResourceBundle().getResource("manageboardpositions")#
			</a>
		</li>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showIMTypeMenu">
				#getProperty("resourceBundleService").getResourceBundle().getResource("manageimtypes")#
			</a>
		</li>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showOrganizationMenu">
				#getProperty("resourceBundleService").getResourceBundle().getResource("manageorganizations")#
			</a>
		</li>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showRoleMenu">
				#getProperty("resourceBundleService").getResourceBundle().getResource("manageroles")#
			</a>
		</li>
	</ul>
	
	<cfif people.recordCount gt 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("name")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("email")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("role")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("admin")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</th>
					<th colspan="2">#getProperty("resourceBundleService").getResourceBundle().getResource("action")#</th>
				</tr>
				<cfloop query="people">
					<tr<cfif (people.currentRow MOD 2) EQ 0> class="odd"</cfif>>
						<td<cfif people.is_active EQ 0> class="inactive"</cfif>>#people.last_name#, #people.first_name#</td>
						<td><a href="mailto:#people.email#">#people.email#</a></td>
						<td>#people.role#</td>
						<td class="active">
							<cfif people.is_admin eq 1>
								<img alt="Admin" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick.png" />
							<cfelse>
								<img alt="Admin" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick_disabled.png" />
							</cfif>
						</td>
						<td class="active">
							<cfif people.is_active eq 1>
								<a href="javascript:toggleActive('#people.person_id#',0);"><img alt="Active" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick.png" /></a>
							<cfelse>
								<a href="javascript:toggleActive('#people.person_id#',1);"><img alt="Inactive" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick_disabled.png" /></a>
							</cfif>
						</td>
						<td class="action">
							<a href="index.cfm?#getProperty('eventParameter')#=admin.showPersonForm&amp;personID=#people.person_id#">
								#getProperty("resourceBundleService").getResourceBundle().getResource("edit")#
							</a>
							<a href="javascript:deletePerson('#people.person_id#');">
								#getProperty("resourceBundleService").getResourceBundle().getResource("delete")#
							</a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	<cfelse>
		<em>#getProperty("resourceBundleService").getResourceBundle().getResource("nopeople")#</em>
	</cfif>
</cfoutput>