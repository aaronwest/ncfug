<cfoutput>
	<cfif event.isArgDefined("message")>
		<p style="font-weight:bold;color:red;">#event.getArg("message")#</p>
	</cfif>
	
	<h2>Welcome to the Nashville ColdFusion User Group</h2>
	<p>
		Thank you for stopping by! While we are a 
		<a href="http://www.adobe.com/products/coldfusion/">ColdFusion</a> user group you still may see us talk about other Adobe products such as <a href="http://www.adobe.com/products/flex/">Flex</a> and 
		<a href="http://www.adobe.com/go/air/">AIR</a>. We cover a variety of topics and skill levels, so please join us!
	</p>
	
	<p>
		If you're interested in hearing 
		about a particular topic, or you're interested in presenting, please 
		<a href="#BuildUrl('contact')#">fill out our contact form</a>.
	</p>
	
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("nextmeeting")#</h2>
	
	<cfif isDefined("nextMeeting")>
		<h3>
			<a href="#BuildUrl('meeting', 'meetingID=#nextMeeting.getMeetingID()#')#">#nextMeeting.getTitle()#</a><br />
		</h3>
		<p>	#getProperty("resourceBundleService").getLocaleUtils().i18nDateTimeFormat(nextMeeting.getDTMeeting(), 3, 3)#<br />
			#nextMeeting.getLocation().getLocation()#<br />
			#nextMeeting.getLocation().getAddress().getAddress1()#,<br />
			#nextMeeting.getLocation().getAddress().getCity()#,
			#nextMeeting.getLocation().getAddress().getState()#
			#nextMeeting.getLocation().getAddress().getPostalCode()#
		</p>
		<cfif nextMeeting.getConnectURL() is not "">
		<p>
			<strong>#getProperty("resourceBundleService").getResourceBundle().getResource("connecturl")#:</strong> 
			<a href="#nextMeeting.getConnectURL()#">#nextMeeting.getConnectURL()#</a>
		</p>
		</cfif>
		
		<p>#nextMeeting.getDescription()#</p>
		
		<p><strong>#getProperty("resourceBundleService").getResourceBundle().getResource("locationinfo")#</strong><br/>
		#nextMeeting.getLocation().getAddress().getAddress1()#,
		#nextMeeting.getLocation().getAddress().getCity()#,
		#nextMeeting.getLocation().getAddress().getState()#
		#nextMeeting.getLocation().getAddress().getPostalCode()#<br/>
		#nextMeeting.getLocation().getDescription()#</p>
		
		<cfif nextMeeting.getLocation().getMapLink() is not "">
			<p>
				<a href="#nextMeeting.getLocation().getMapLink()#" target="_blank">
					#getProperty("resourceBundleService").getResourceBundle().getResource("mapoflocation")#
				</a>
			</p>
		</cfif>
		
		<cfif arrayLen(nextMeeting.getPresentations()) gt 0>
			<h3>#getProperty("resourceBundleService").getResourceBundle().getResource("presentations")#</h3>
			
			<cfset presentations = nextMeeting.getPresentations() />
			
			<cfloop index="i" from="1" to="#arrayLen(presentations)#" step="1">
				<cfset presenters = presentations[i].getPresenters() />
				<cfset presenterList = "" />
				
				<cfif ArrayLen(presenters) EQ 1>
					<cfset presenterList = presenters[1].getFirstName() & " " & presenters[1].getLastName() />
				<cfelse>
					<cfloop index="j" from="1" to="#arrayLen(presenters)#" step="1">
						<cfset presenterList = presenterList & presenters[j].getFirstName() & " " & presenters[j].getLastName() />
						
						<cfif j lt arrayLen(presenters)>
							<cfif j eq (arrayLen(presenters) - 1)>
								<cfset presenterList = presenterList & getProperty("resourceBundleService").getResourceBundle().getResource("and") & " " />
							<cfelse>
								<cfset presenterList = presenterList & ", " />
							</cfif>
						</cfif>
					</cfloop>
				</cfif>
					
				<h2>
					#presentations[i].getTitle()# 
					(<cfif arrayLen(presenters) eq 1>#getProperty("resourceBundleService").getResourceBundle().getResource("presenter")#<cfelse>#getProperty("resourceBundleService").getResourceBundle().getResource("presenters")#</cfif>: #presenterList#)
				</h2>
				
				<p>#presentations[i].getSummary()#</p>
			</cfloop>
		</cfif>

		<p>
			<a href="#BuildUrl('rsvpform', 'meetingID=#nextMeeting.getMeetingID()#')#">
				#getProperty("resourceBundleService").getResourceBundle().getResource("rsvpforthismeeting")#
			</a>
		</p>
	<cfelse>
		<p>#getProperty("resourceBundleService").getResourceBundle().getResource("noupcomingmeetings")#</p>
	</cfif>
</cfoutput>