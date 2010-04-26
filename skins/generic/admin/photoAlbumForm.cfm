<cfoutput>
	<h2>#action#</h2>

	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>

	<form id="photoalbumForm" class="standardForm" action="#BuildUrl('admin.processPhotoAlbumForm')#" method="post">
		
		<fieldset>	

			<label for="title"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("title")#</span>
				<input type="text" id="title" name="title" size="50" maxlength="500" value="#photoalbum.getTitle()#" /><br />
			</label>
			
			<label for="description"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("description")#</span>
				<textarea id="description" name="description" cols="40" rows="8">#photoalbum.getDescription()#</textarea><br />
			</label>
			
			<label for="isActive"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</span>
				<input type="checkbox" id="isActive" name="isActive" class="checkbox right" value="1"<cfif photoalbum.getAudit().getIsActive() eq 1> checked="checked"</cfif> /><br />
			</label>
				
			<div class="submit-wrap">
				<input type="submit" value="#action#" class="submit" tabindex="4" /><br />
			</div>
			
			<input type="hidden" id="photoAlbumID" name="photoAlbumID" value="#photoalbum.getPhotoAlbumID()#" />
			
		</fieldset>	
		
	</form>
	
	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
		objForm = new qForm("photoalbumForm");
		objForm.title.required = true;
		objForm.title.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("title")#";
		objForm.description.required = true;
		objForm.description.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("description")#";
		//--><!]]>
	</script>

</cfoutput>