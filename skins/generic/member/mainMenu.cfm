<cfoutput>
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("memberMenu")#</h2>
	<p>Please pick an action:</p>
	<ul>
		<li>
			<a href="#BuildUrl('member.showPersonForm')#">
				#getProperty("resourceBundleService").getResourceBundle().getResource("manageyourprofile")#
			</a>
		</li>
	</ul>
</cfoutput>