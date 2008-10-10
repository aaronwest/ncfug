<cfoutput>
	
	<h1>#getProperty("resourceBundleService").getResourceBundle().getResource("manageyourprofile")#</h1>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<ul>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=member.showPersonForm">
				#getProperty("resourceBundleService").getResourceBundle().getResource("updateperson")#
			</a>
		</li>
	</ul>

</cfoutput>