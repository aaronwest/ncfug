<cfoutput>
	<script type="text/javascript">
		function deletePhoto(photoID) {
			if(confirm("#getProperty('resourceBundleService').getResourceBundle().getResource('confirmphotodelete')#")) {
				location.href = "#BuildUrl('admin.deletePhoto')#photoID/" + photoID;
			}
		}
	</script>
	
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("managephotos")#</h2>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
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
	
 	<cfif photos.recordCount gt 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("name")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("caption")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("action")#</th>
				</tr>
				<cfloop query="photos">
					<tr<cfif (photos.currentRow MOD 2) EQ 0> class="odd"</cfif>>
						<td>#photos.title#</td>
						<td>#photos.caption#</td>
						<td class="active">
							<cfif photos.is_active eq 1>
								<img alt="Active" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick.png" />
							<cfelse>
								<img alt="Inactive" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick_disabled.png" />
							</cfif>
						</td>
						<td class="action">
							<a href="#BuildUrl('admin.showPhotoForm')#photoID/#photos.photo_id#">
								#getProperty("resourceBundleService").getResourceBundle().getResource("edit")#
							</a>
							<a href="javascript:void(0);" onClick="javascript:deletePhoto('#photos.photo_id#');">
								#getProperty("resourceBundleService").getResourceBundle().getResource("delete")#
							</a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	<cfelse>
		<em>#getProperty("resourceBundleService").getResourceBundle().getResource("nophotos")#</em>
	</cfif>
</cfoutput>