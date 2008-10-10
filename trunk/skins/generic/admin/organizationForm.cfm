<cfoutput>
	<h2>#action#</h2>

	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>

	<form id="organizationForm" class="standardForm" action="index.cfm?#getProperty('eventParameter')#=admin.processOrganizationForm" method="post">
		
		<fieldset>
			
			<label for="organization"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("organization")#</span>
				<input type="text" id="organization" name="organization" size="50" maxlength="500" value="#organization.getOrganization()#" /><br />
			</label>
			
			<label for="isActive"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</span>
				<input type="checkbox" id="isActive" name="isActive" class="checkbox right" value="1" <cfif organization.getAudit().getIsActive() eq 1> checked="checked"</cfif> /><br />
			</label>
			
			<div class="submit-wrap">
				<input type="submit" value="#action#" class="submit" tabindex="4" /><br />
			</div>
			
			<input type="hidden" id="organizationID" name="organizationID" value="#organization.getOrganizationID()#" />
			
		</fieldset>

	</form>
	
	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
		objForm = new qForm("organizationForm");
		objForm.organization.required = true;
		objForm.organization.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("organization")#";
		//--><!]]>
	</script>

</cfoutput>