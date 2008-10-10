<cfoutput>
	<h1>#getProperty("resourceBundleService").getResourceBundle().getResource("memberMenu")#</h1>
	<p>Please pick an action:</p>
	<ul>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=member.showProfileMenu">
				#getProperty("resourceBundleService").getResourceBundle().getResource("manageyourprofile")#
			</a>
			<ul>
				<li>
					<a href="index.cfm?#getProperty('eventParameter')#=member.showPersonForm">
						#getProperty("resourceBundleService").getResourceBundle().getResource("updateperson")#
					</a>
				</li>
			</ul>
		</li>
	</ul>
</cfoutput>