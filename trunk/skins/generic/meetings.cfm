<cfoutput>
	<h2>#getProperty("siteName")# #getProperty("resourceBundleService").getResourceBundle().getResource("meetingscap")#</h2>
	
	<cfif ArrayLen(meetings) gt 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>Date</th>
					<th>Topic</th>
					<th>Presentations</th>
				</tr>
				<cfloop index="i" from="1" to="#arrayLen(meetings)#" step="1">
					<tr <cfif (i MOD 2) EQ 0>class="odd"</cfif>>
						<td class="datetime">
							#getProperty("resourceBundleService").getLocaleUtils().i18nDateTimeFormat(meetings[i].getDtMeeting(), 3, 3)#
						</td>
						<td>
							<a href="index.cfm?#getProperty('eventParameter')#=showMeeting&amp;meetingID=#meetings[i].getMeetingID()#">#meetings[i].getTitle()#</a>
						</td>
						<td>
							<cfif ArrayLen(meetings[i].getPresentations()) gt 0>
								<cfset presentations = meetings[i].getPresentations() />
								
								<cfloop index="j" from="1" to="#arrayLen(presentations)#" step="1">
									<cfset presenters = presentations[j].getPresenters() />
									<cfset presenterNames = "" />
									
									<cfloop index="k" from="1" to="#arrayLen(presenters)#" step="1">
										<cfset presenterNames = presenters[k].getFirstName() & " " & presenters[k].getLastName() />
										<cfif k lt arrayLen(presenters)>
											<cfset presenterNames = presenterNames & ", " />
										</cfif>
									</cfloop>
									
									#presentations[j].getTitle()# (#presenterNames#)<cfif j lt arrayLen(presentations)><br /></cfif>
								</cfloop>
							</cfif>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	<cfelse>
		<p><em>#getProperty("resourceBundleService").getResourceBundle().getResource("nomeetings")#</em></p>
	</cfif>
	<br />
	<br />
	<h3>#getProperty("resourceBundleService").getResourceBundle().getResource("suggestameetingtopic")#</h3>
</cfoutput>