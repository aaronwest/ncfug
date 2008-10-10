<cfoutput>
	<script type="text/javascript">
		function deletePhotoAlbum(photoalbumID) {
			if(confirm("#getProperty('resourceBundleService').getResourceBundle().getResource('confirmphotoalbumdelete')#")) {
				location.href = "index.cfm?#getProperty('eventParameter')#=admin.deletePhotoAlbum&photoalbumID=" + photoalbumID;
			}
		}
	</script>
	
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("managephotoalbums")#</h2>
	<ul>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showPhotoAlbumForm">
				#getProperty("resourceBundleService").getResourceBundle().getResource("addnewphotoalbum")#
			</a>
		</li>
	</ul>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<cfif photoalbums.recordCount gt 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("title")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("action")#</th>
				</tr>
				<cfloop query="photoalbums">
					<tr<cfif (photoalbums.currentRow MOD 2) EQ 0> class="odd"</cfif>>
						<td>#photoalbums.title#</td>
						<td class="active">
							<cfif photoalbums.is_active eq 1>
								<img alt="Active" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick.png" />
							<cfelse>
								&nbsp;
							</cfif>
						</td>
						<td class="action">
							<a href="index.cfm?#getProperty('eventParameter')#=admin.showPhotoAlbumForm&amp;photoAlbumID=#photoalbums.photo_album_id#">
								#getProperty("resourceBundleService").getResourceBundle().getResource("edit")#
							</a>
							<a href="javascript:void(0);" onClick="javascript:deletePhotoAlbum('#photoalbums.photo_album_id#');">
								#getProperty("resourceBundleService").getResourceBundle().getResource("delete")#
							</a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	<cfelse>
		<em>#getProperty("resourceBundleService").getResourceBundle().getResource("nophotoalbums")#</em>
	</cfif>
</cfoutput>