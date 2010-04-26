<cfoutput>
	<h2>#meeting.getTitle()#</h2>
	
	<h3>
		#getProperty("resourceBundleService").getLocaleUtils().i18nDateTimeFormat(meeting.getDtMeeting(), 3, 3)#<br />
		#meeting.getLocation().getLocation()#
	</h3>
	
	<cfif meeting.getConnectURL() is not "">
	<p>
		<strong>#getProperty("resourceBundleService").getResourceBundle().getResource("connecturl")#:</strong> 
		<a href="#meeting.getConnectURL()#">#meeting.getConnectURL()#</a>
	</p>
	</cfif>
	
	<p>#meeting.getDescription()#</p>
	
	<p><strong>#getProperty("resourceBundleService").getResourceBundle().getResource("locationinfo")#</strong><br/>
	#meeting.getLocation().getAddress().getAddress1()#,
	#meeting.getLocation().getAddress().getCity()#,
	#meeting.getLocation().getAddress().getState()#
	#meeting.getLocation().getAddress().getPostalCode()#<br/>
	#meeting.getLocation().getDescription()#</p>
	
	<cfif meeting.getLocation().getMapLink() is not "">
		<cfset tempLink = Replace(meeting.getLocation().getMapLink(),"&","&amp;","ALL")>
		<p>
			<a href="#tempLink#">
				#getProperty("resourceBundleService").getResourceBundle().getResource("mapoflocation")#
			</a>
		</p>
	</cfif>

	<cfif arrayLen(meeting.getPresentations()) gt 0>
		<h3>#getProperty("resourceBundleService").getResourceBundle().getResource("presentations")#</h3>
		
		<cfset presentations = meeting.getPresentations() />
		
		<cfloop index="i" from="1" to="#arrayLen(presentations)#" step="1">
			<cfset presenters = presentations[i].getPresenters() />
			<cfset presenterList = "" />
			
			<cfif arrayLen(presenters) gte 1>
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
			<cfelseif arrayLen(presenters) eq 1>
				<cfset presenterList = presenters[1].getFirstName() & " " & presenters[1].getLastName() />
			</cfif>
				
			<h2>
				#presentations[i].getTitle()# 
				(<cfif arrayLen(presenters) eq 1>#getProperty("resourceBundleService").getResourceBundle().getResource("presenter")#<cfelse>#getProperty("resourceBundleService").getResourceBundle().getResource("presenters")#</cfif>: #presenterList#)
			</h2>
			
			<p>#presentations[i].getSummary()#</p>
		</cfloop>
	</cfif>

	<p>
		<a href="#BuildUrl('rsvpform', 'meetingID=#meeting.getMeetingID()#')#">
			#getProperty("resourceBundleService").getResourceBundle().getResource("rsvpforthismeeting")#
		</a>
	</p>
	
	<p><a href="#BuildUrl('meetings')#">&lt;&lt; #getProperty("resourceBundleService").getResourceBundle().getResource("backtomeetings")#</a>
	</p>
</cfoutput>