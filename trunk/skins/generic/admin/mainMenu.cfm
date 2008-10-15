<cfoutput>
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("adminMenu")#</h2>
	<p>Please pick an action:</p>
	<ul>
		<li>
			<a href="#BuildUrl('admin.showPeopleMenu')#">
				#getProperty("resourceBundleService").getResourceBundle().getResource("managepeople")#
			</a>
			<ul>
				<li>
					<a href="#BuildUrl('admin.showPersonForm')#">
						#getProperty("resourceBundleService").getResourceBundle().getResource("addnewperson")#
					</a>
				</li>
				<li>
					<a href="#BuildUrl('admin.showBoardPositionMenu')#">
						#getProperty("resourceBundleService").getResourceBundle().getResource("manageboardpositions")#
					</a>
				</li>
				<li>
					<a href="#BuildUrl('admin.showIMTypeMenu')#">
						#getProperty("resourceBundleService").getResourceBundle().getResource("manageimtypes")#
					</a>
				</li>
				<li>
					<a href="#BuildUrl('admin.showOrganizationMenu')#">
						#getProperty("resourceBundleService").getResourceBundle().getResource("manageorganizations")#
					</a>
				</li>
				<li>
					<a href="#BuildUrl('admin.showRoleMenu')#">
						#getProperty("resourceBundleService").getResourceBundle().getResource("manageroles")#
					</a>
				</li>
			</ul>
		</li>
		<li>
			<a href="#BuildUrl('admin.showMeetingMenu')#">
				#getProperty("resourceBundleService").getResourceBundle().getResource("managemeetings")#
			</a>
			<ul>
				<li>
					<a href="#BuildUrl('admin.showMeetingForm')#">
						#getProperty("resourceBundleService").getResourceBundle().getResource("addnewmeeting")#
					</a>
				</li>
				<li>
					<a href="#BuildUrl('admin.showLocationMenu')#">
						#getProperty("resourceBundleService").getResourceBundle().getResource("managelocations")#
					</a>
				</li>
				<li>
					<a href="#BuildUrl('admin.showPresentationMenu')#">
						#getProperty("resourceBundleService").getResourceBundle().getResource("managepresentations")#
					</a>
				</li>
			</ul>
		</li>
		<li>
			<a href="#BuildUrl('admin.showNewsMenu')#">
				#getProperty("resourceBundleService").getResourceBundle().getResource("managenews")#
			</a>
			<ul>
				<li>
					<a href="#BuildUrl('admin.showNewsForm')#">
						#getProperty("resourceBundleService").getResourceBundle().getResource("addnewnewsitem")#
					</a>
				</li>
			</ul>
		</li>
		<li>
			<a href="#BuildUrl('admin.showArticleMenu')#">
				#getProperty("resourceBundleService").getResourceBundle().getResource("managearticles")#
			</a>
			<ul>
				<li>
					<a href="#BuildUrl('admin.showArticleForm')#">
						#getProperty("resourceBundleService").getResourceBundle().getResource("addnewarticle")#
					</a>
				</li>
				<li>
					<a href="#BuildUrl('admin.showCategoryMenu')#">
						#getProperty("resourceBundleService").getResourceBundle().getResource("managecategories")#
					</a>
				</li>
			</ul>
		</li>
		<li>
			<a href="#BuildUrl('admin.showBookMenu')#">
				#getProperty("resourceBundleService").getResourceBundle().getResource("managebooks")#
			</a>
			<ul>
				<li>
					<a href="#BuildUrl('admin.showBookForm')#">
						#getProperty("resourceBundleService").getResourceBundle().getResource("addnewbook")#
					</a>
				</li>
				<li>
					<a href="#BuildUrl('admin.showCategoryMenu')#">
						#getProperty("resourceBundleService").getResourceBundle().getResource("managecategories")#
					</a>
				</li>
			</ul>
		</li>
		<li class="last">
			<a href="#BuildUrl('admin.showPhotoMenu')#">
				#getProperty("resourceBundleService").getResourceBundle().getResource("managephotos")#
			</a>
			<ul>
				<li>
					<a href="#BuildUrl('admin.showPhotoForm')#">
						#getProperty("resourceBundleService").getResourceBundle().getResource("addnewphoto")#
					</a>
				</li>
				<li>
					<a href="#BuildUrl('admin.showPhotoAlbumMenu')#">
						#getProperty("resourceBundleService").getResourceBundle().getResource("managephotoalbums")#
					</a>
				</li>
			</ul>
		</li>
	</ul>
</cfoutput>