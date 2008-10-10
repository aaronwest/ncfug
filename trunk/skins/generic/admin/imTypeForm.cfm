<cfoutput>
	<h2>#action#</h2>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<form id="imTypeForm" class="standardForm" action="index.cfm?#getProperty('eventParameter')#=admin.processIMTypeForm" method="post">
		
		<fieldset>
			
			<label for="imType"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("imtype")#</span>
				<input type="text" id="imType" name="imType" size="50" maxlength="100" value="#imType.getIMType()#" /><br />
			</label>
			
			<label for="imType"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</span>
				<input type="checkbox" id="isActive" name="isActive" value="1" class="checkbox right" <cfif imType.getAudit().getIsActive() eq 1> checked="checked"</cfif> /><br />
			</label>
			
			<div class="submit-wrap">
				<input type="submit" value="#action#" class="submit" tabindex="4" /><br />
			</div>
			
			<input type="hidden" id="imTypeID" name="imTypeID" value="#imType.getIMTypeID()#" />
			
		</fieldset>
		
		
	</form>
	
	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
		objForm = new qForm("imTypeForm");
		objForm.imType.required = true;
		objForm.imType.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('imtype')#";
		//--><!]]>
	</script>
</cfoutput>