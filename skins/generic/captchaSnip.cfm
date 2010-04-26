<cfif NOT StructIsEmpty(captcha)>
	<cfoutput>
		<label for="captchaValidate"><span class="label">&nbsp;</span>
			<span class="detail">
				<input type="hidden" name="captchaHash" value="#variables.captcha.hash#" />
				<img
					src="index.cfm?#getProperty('eventParameter')#=captcha.displayImage&amp;hashReference=#captcha.hash#"
					width="#variables.captcha.width#"
					height="#variables.captcha.height#"
					alt="" 
				/><br />
			</span>
		</label>
		<label for="captchaValidate"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("captchalabel")#<br />(#getProperty("resourceBundleService").getResourceBundle().getResource("notcasesensitive")#)</span>
			<input id="captchaValidate" name="captchaValidate" type="text" size="10" tabindex="20" maxlength="7" value="" /><br />
		</label>
	</cfoutput>
</cfif>
