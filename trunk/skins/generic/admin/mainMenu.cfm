<cfoutput>
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("adminMenu")#</h2>
	<p>Please pick an action:</p>
	<ul>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showPeopleMenu">
				#getProperty("resourceBundleService").getResourceBundle().getResource("managepeople")#
			</a>
			<ul>
				<li>
					<a href="index.cfm?#getProperty('eventParameter')#=admin.showPersonForm">
						#getProperty("resourceBundleService").getResourceBundle().getResource("addnewperson")#
					</a>
				</li>
				<li>
					<a href="index.cfm?#getProperty('eventParameter')#=admin.showBoardPositionMenu">
						#getProperty("resourceBundleService").getResourceBundle().getResource("manageboardpositions")#
					</a>
				</li>
				<li>
					<a href="index.cfm?#getProperty('eventParameter')#=admin.showIMTypeMenu">
						#getProperty("resourceBundleService").getResourceBundle().getResource("manageimtypes")#
					</a>
				</li>
				<li>
					<a href="index.cfm?#getProperty('eventParameter')#=admin.showOrganizationMenu">
						#getProperty("resourceBundleService").getResourceBundle().getResource("manageorganizations")#
					</a>
				</li>
				<li>
					<a href="index.cfm?#getProperty('eventParameter')#=admin.showRoleMenu">
						#getProperty("resourceBundleService").getResourceBundle().getResource("manageroles")#
					</a>
				</li>
			</ul>
		</li>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showMeetingMenu">
				#getProperty("resourceBundleService").getResourceBundle().getResource("managemeetings")#
			</a>
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
		</li>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showNewsMenu">
				#getProperty("resourceBundleService").getResourceBundle().getResource("managenews")#
			</a>
			<ul>
				<li>
					<a href="index.cfm?#getProperty('eventParameter')#=admin.showNewsForm">
						#getProperty("resourceBundleService").getResourceBundle().getResource("addnewnewsitem")#
					</a>
				</li>
			</ul>
		</li>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showArticleMenu">
				#getProperty("resourceBundleService").getResourceBundle().getResource("managearticles")#
			</a>
			<ul>
				<li>
					<a href="index.cfm?#getProperty('eventParameter')#=admin.showArticleForm">
						#getProperty("resourceBundleService").getResourceBundle().getResource("addnewarticle")#
					</a>
				</li>
				<li>
					<a href="index.cfm?#getProperty('eventParameter')#=admin.showCategoryMenu">
						#getProperty("resourceBundleService").getResourceBundle().getResource("managecategories")#
					</a>
				</li>
			</ul>
		</li>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showBookMenu">
				#getProperty("resourceBundleService").getResourceBundle().getResource("managebooks")#
			</a>
			<ul>
				<li>
					<a href="index.cfm?#getProperty('eventParameter')#=admin.showBookForm">
						#getProperty("resourceBundleService").getResourceBundle().getResource("addnewbook")#
					</a>
				</li>
				<li>
					<a href="index.cfm?#getProperty('eventParameter')#=admin.showCategoryMenu">
						#getProperty("resourceBundleService").getResourceBundle().getResource("managecategories")#
					</a>
				</li>
			</ul>
		</li>
		<li class="last">
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showPhotoMenu">
				#getProperty("resourceBundleService").getResourceBundle().getResource("managephotos")#
			</a>
			<ul>
				<li>
					<a href="index.cfm?#getProperty('eventParameter')#=admin.showPhotoForm">
						#getProperty("resourceBundleService").getResourceBundle().getResource("addnewphoto")#
					</a>
				</li>
				<li>
					<a href="index.cfm?#getProperty('eventParameter')#=admin.showPhotoAlbumMenu">
						#getProperty("resourceBundleService").getResourceBundle().getResource("managephotoalbums")#
					</a>
				</li>
			</ul>
		</li>
	</ul>
</cfoutput>