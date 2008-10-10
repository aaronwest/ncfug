<cfoutput>
	<script type="text/javascript">
		function deleteMeeting(meetingID) {
			if(confirm("#getProperty('resourceBundleService').getResourceBundle().getResource('confirmmeetingdelete')#")) {
				location.href = "index.cfm?#getProperty('eventParameter')#=admin.deleteMeeting&meetingID=" + meetingID;
			}
		}
	</script>
	
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("managemeetings")#</h2>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<ul>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showMeetingForm">
				#getProperty("resourceBundleService").getResourceBundle().getResource("addnewmeeting")#
			</a>
		</li>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showLocationMenu">
				#getProperty("resourceBundleService").getResourceBundle().getResource("managelocations")#
			</a>
		</li>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showPresentationMenu">
				#getProperty("resourceBundleService").getResourceBundle().getResource("managepresentations")#
			</a>
		</li>
	</ul>
	
	<cfif meetings.recordCount gt 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("date")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("topic")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("action")#</th>
				</tr>
				<cfloop query="meetings">
					<tr<cfif (meetings.currentRow MOD 2) EQ 0> class="odd"</cfif>>
						<td class="datetime">#getProperty("resourceBundleService").getLocaleUtils().i18nDateTimeFormat(meetings.dt_meeting, 3, 3)#</td>
						<td>#meetings.title#</td>
						<td class="active">
							<cfif meetings.is_active eq 1>
								<img alt="Active" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick.png" />
							<cfelse>
								<img alt="Inactive" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick_disabled.png" />
							</cfif>
						</td>
						<td class="action extended">
							<a href="index.cfm?#getProperty('eventParameter')#=admin.showRSVPs&amp;meetingID=#meetings.meeting_id#">
								#getProperty("resourceBundleService").getResourceBundle().getResource("showrsvps")#
							</a>
							<a href="index.cfm?#getProperty('eventParameter')#=admin.showMeetingForm&amp;meetingID=#meetings.meeting_id#">
								#getProperty("resourceBundleService").getResourceBundle().getResource("edit")#
							</a>
							<a href="javascript:void(0);" onClick="javascript:deleteMeeting('#meetings.meeting_id#');">
								#getProperty("resourceBundleService").getResourceBundle().getResource("delete")#
							</a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	<cfelse>
		<em>#getProperty("resourceBundleService").getResourceBundle().getResource("nomeetings")#</em>
	</cfif>
</cfoutput>