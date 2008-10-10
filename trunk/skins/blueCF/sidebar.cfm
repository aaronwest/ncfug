<cfoutput>
	<div id="sidebar">
		<div class="sidebox" id="upcoming-meetings">
			<h4>#getProperty("resourceBundleService").getResourceBundle().getResource("upcomingmeetings")#</h4>
			<cfif arrayLen(upcomingMeetings) gt 0>
				<cfloop index="i" from="1" to="#arrayLen(upcomingMeetings)#" step="1">
					<h5>#getProperty("resourceBundleService").getLocaleUtils().i18nDateTimeFormat(upcomingMeetings[i].getDTMeeting(), 3, 3)#</h5>
					<p><a href="index.cfm?#getProperty('eventParameter')#=showMeeting&amp;meetingID=#upcomingMeetings[i].getMeetingID()#">#upcomingMeetings[i].getTitle()#</a><br />
					#upcomingMeetings[i].getLocation().getLocation()#</p>
					<p>#nextMeeting.getLocation().getAddress().getAddress1()#,<br />
					#nextMeeting.getLocation().getAddress().getCity()#, #nextMeeting.getLocation().getAddress().getState()# #nextMeeting.getLocation().getAddress().getPostalCode()#</p>
					<cfif isDefined("tempLinkMain")>
						<p><a href="#tempLinkMain#">#getProperty("resourceBundleService").getResourceBundle().getResource("mapoflocation")#</a></p>
					</cfif>
					<p><a href="index.cfm?#getProperty('eventParameter')#=showRSVPForm&amp;meetingID=#nextMeeting.getMeetingID()#">#getProperty("resourceBundleService").getResourceBundle().getResource("rsvpforthismeeting")#</a></p>
				</cfloop>
			<cfelse>
				<p>#getProperty("resourceBundleService").getResourceBundle().getResource("noupcomingmeetings")#</p>
			</cfif>
		</div>
		
		<div class="sidebox" id="usergroup">
			<p>	
				<a rel="external" href="http://www.adobe.com/cfusion/usergroups/index.cfm"><img src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/images/adobeug.png" alt="Adobe Usergroups" /></a>
			</p>
		</div>
			
		<div class="sidebox" id="supporters">
			<h4>#getProperty("resourceBundleService").getResourceBundle().getResource("supporters")#</h4>
			
			<p>
				<a rel="external" href="http://www.peachpit.com/"><img src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/images/peachpit.gif" alt="Peachpit Usergroup Program" /></a>
			</p>
			<p>
				<a rel="external" href="http://www.oreilly.com/"><img src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/images/oreilly.png" alt="OReilly Usergroup Program" /></a>
			</p>
			<p>
				<a rel="external" href="http://www.edgewebhosting.com/"><img src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/images/edgeweb.png" alt="Edge Web Hosting" /></a>
			</p>
			<p>
				<a rel="external" href="http://www.qantmcollege.edu.au/"><img src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/images/qantm.gif" alt="Qantm College" /></a>
			</p>
		</div>
	</div>
</cfoutput>