<cfoutput>
	
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("manageyourprofile")#</h2>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<ul>
		<li>
			<a href="#BuildUrl('member.showPersonForm')#">
				#getProperty("resourceBundleService").getResourceBundle().getResource("updateperson")#
			</a>
		</li>
	</ul>

</cfoutput>