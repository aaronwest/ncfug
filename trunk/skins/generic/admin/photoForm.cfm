<cfoutput>
	<h2>#action#</h2>

	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>

	<form id="photoForm" class="standardForm" action="#BuildUrl('admin.processPhotoForm')#" method="post">
		
		<fieldset>	

			<label for="title"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("title")#</span>
				<input type="text" id="title" name="title" size="50" maxlength="500" value="#photo.getTitle()#" /><br />
			</label>
			
			<label for="caption"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("caption")#</span>
				<textarea id="caption" name="caption" cols="40" rows="8">#photo.getCaption()#</textarea><br />
			</label>
			
			<label for="isActive"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</span>
				<input type="checkbox" id="isActive" name="isActive" class="checkbox right" value="1"<cfif photo.getAudit().getIsActive() eq 1> checked="checked"</cfif> /><br />
			</label>
				
			<div class="submit-wrap">
				<input type="submit" value="#action#" class="submit" tabindex="4" /><br />
			</div>
			
			<input type="hidden" id="photoID" name="photoID" value="#photo.getPhotoID()#" />
			
		</fieldset>	
		
	</form>
	
	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
		objForm = new qForm("photoForm");
		objForm.title.required = true;
		objForm.title.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("title")#";
		objForm.caption.required = true;
		objForm.caption.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("description")#";
		//--><!]]>
	</script>

</cfoutput>