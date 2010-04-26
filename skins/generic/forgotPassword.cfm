<cfoutput>
	<cfif message is not "">
		<h3 style="color:red;">#message#</h3>
	</cfif>
	
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("forgotpassword")#</h2>
	
	<form id="forgotpasswordForm" action="#BuildUrl('processForgotPassword')#" class="standardForm" method="post">
		
		<fieldset>

			<label for="email"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("email")#</span>
				<input type="text" id="email" name="email" size="30" maxlength="100" tabindex="2" value="" /><br />
			</label>
		
			<div class="submit-wrap">
				<input type="submit" value="#getProperty('resourceBundleService').getResourceBundle().getResource('submit')#" class="submit" tabindex="4" /><br />
			</div>
		
		</fieldset>
		
	</form>
	<br />
	
	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
		objForm = new qForm("forgotpasswordForm");
		objForm.email.required = true;
		objForm.email.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('email')#";
		objForm.email.validateEmail("#getProperty('resourceBundleService').getResourceBundle().getResource('emailnotvalid')#");
		//--><!]]>
	</script>

</cfoutput>