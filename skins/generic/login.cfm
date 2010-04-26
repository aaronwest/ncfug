<cfoutput>
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("pleaselogin")#</h2>

	<cfif event.isArgDefined("message")>
		<p style="color:red;">#event.getArg("message")#</p>
	</cfif>
	
	<form id="loginForm" action="#BuildUrl('processLoginForm')#" class="standardForm" method="post">
		<fieldset>

			<label for="email"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("email")#</span>
				<input type="text" id="email" name="email" size="30" maxlength="100" tabindex="1" /><br />
			</label>
			
			<label for="password"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("password")#</span>
				<input type="password" id="password" name="password" size="30" maxlength="50" tabindex="2" /><br />
			</label>
			
			<div class="submit-wrap">
				<input type="submit" value="#getProperty('resourceBundleService').getResourceBundle().getResource('submit')#" class="submit" tabindex="4" /><br />
			</div>
			
		</fieldset>
	</form>

	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
		objForm = new qForm("loginForm");
		objForm.email.required = true;
		objForm.email.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('email')#";
		objForm.email.validateEmail("#getProperty('resourceBundleService').getResourceBundle().getResource('emailnotvalid')#");
		objForm.password.required = true;
		objForm.password.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('password')#";
		//--><!]]>
	</script>
</cfoutput>
