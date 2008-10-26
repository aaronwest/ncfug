<cfoutput>
	<h2>#action#</h2>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<form id="categoryForm" class="standardForm" action="#BuildUrl('admin.processCategoryForm')#" method="post">
		
		<fieldset>
			
			<label for="category"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("category")#</span>
				<input type="text" id="category" name="category" size="50" maxlength="500" value="#category.getCategory()#" /><br />
			</label>		
			
			<label for="isActive"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</span>
				<input type="checkbox" id="isActive" name="isActive" value="1" class="checkbox right"<cfif category.getAudit().getIsActive() eq 1> checked="checked"</cfif> /><br />
			</label>
			
			<div class="submit-wrap">
				<input type="submit" value="#action#" class="submit" tabindex="4" /><br />
			</div>
			
			<input type="hidden" id="categoryID" name="categoryID" value="#category.getCategoryID()#" />
			
		</fieldset>

	</form>
	
	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
		objForm = new qForm("categoryForm");
		objForm.category.required = true;
		objForm.category.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('category')#";
		//--><!]]>
	</script>
</cfoutput>