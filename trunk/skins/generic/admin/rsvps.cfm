<cfoutput>
	<script type="text/javascript">
		function deleteRSVP(rsvpID) {
			if(confirm("#getProperty('resourceBundleService').getResourceBundle().getResource('confirmrsvpdelete')#")) {
				location.href = "#BuildUrl('admin.deleteRSVP')#rsvpID/" + rsvpID;
			}
		}
	</script>
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("meetingrsvps")#</h2>
	
	<h2>#getProperty("resourceBundleService").getLocaleUtils().i18nDateTimeFormat(meeting.getDTMeeting(), 3, 3)#</h2>
	<p>
		#meeting.getTitle()#<br />
		#meeting.getLocation().getLocation()#
	</p>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<cfif rsvps.recordCount gt 0>
		<p>#getProperty("resourceBundleService").getResourceBundle().getResource("totalrsvps")#: #rsvps.recordCount#</p>
		
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("name")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("email")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("date")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("action")#</th>
				</tr>
				<cfloop query="rsvps">
					<tr<cfif (rsvps.currentRow MOD 2) EQ 0> class="odd"</cfif>>
						<td>#rsvps.last_name#, #rsvps.first_name#</td>
						<td><a href="mailto:#rsvps.email#">#rsvps.email#</a></td>
						<td class="datetime">#getProperty("resourceBundleService").getLocaleUtils().i18nDateTimeFormat(rsvps.dt_created, 3, 3)#</td>
						<td class="action">
							<a href="#BuildUrl('admin.showRSVPForm', 'rsvpID=#rsvps.rsvp_id#')#">
								#getProperty("resourceBundleService").getResourceBundle().getResource("edit")#
							</a>
							<a href="javascript:deleteRSVP('#rsvps.rsvp_id#');">
								#getProperty("resourceBundleService").getResourceBundle().getResource("delete")#
							</a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
		
		<br />
		<br />
		
		<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("emailrsvpsforthismeeting")#</h2>
		
		<p>#getProperty("resourceBundleService").getResourceBundle().getResource("emailrsvpsnote")#</p>
		
		<form id="rsvpNotificationForm" class="standardForm" action="#BuildUrl('admin.processRSVPNotificationForm')#" method="post">
			
			<fieldset>
			
				<label for="subject"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("subject")#</span>
					<input type="text" id="subject" name="subject" size="30" maxlength="250" value="#event.getArg('subject', '')#" /><br />
				</label>
				
				<label for="emailBody"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("message")#</span>
					<textarea id="emailBody" name="emailBody" cols="40" rows="6">#event.getArg("emailBody", "")#</textarea><br />
				</label>
				
				<div class="submit-wrap">
					<input type="submit" value="#getProperty('resourceBundleService').getResourceBundle().getResource('sendmessage')#" class="submit" tabindex="4" /><br />
				</div>
				
				<input type="hidden" id="meetingID" name="meetingID" value="#event.getArg('meetingID')#" />
				
			</fieldset>
		
		</form>
		
		<script type="text/javascript">
			<!--//--><![CDATA[//><!--
			objForm = new qForm("rsvpNotificationForm");
			objForm.subject.required = true;
			objForm.subject.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("subject")#";
			objForm.emailBody.required = true;
			objForm.emailBody.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("message")#";
			//--><!]]>
		</script>
	<cfelse>
		<p>#getProperty("resourceBundleService").getResourceBundle().getResource("norsvps")#</p>
	</cfif>
</cfoutput>
