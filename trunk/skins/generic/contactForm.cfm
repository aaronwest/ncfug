<cfoutput>
	<cfif message is not "">
		<h3 style="color:red;">#message#</h3>
	</cfif>
	
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("contact")#</h2>
	
	<form id="contactForm" action="index.cfm?#getProperty('eventParameter')#=processContactForm" class="standardForm" method="post">
		
		<fieldset>

			<label for="name"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("name")#</span>
				<input type="text" id="name" name="name" size="30" maxlength="100" tabindex="1" value="" /><br />
			</label>
			
			<label for="email"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("email")#</span>
				<input type="text" id="email" name="email" size="30" maxlength="100" tabindex="2" value="" /><br />
			</label>
			
			
			<label for="reason"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("reasonforcontact")#</span>
				<select name="reason" id="reason" tabindex="3">
					<option selected>General</option>
					<option>Meeting Suggestion</option>
					<option>Advertising/Sponsorship</option>
					<option>Job Posting Request</option>
				</select>
			</label>
			
			
			<label for="comments"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("comments")#</span>
				<textarea id="comments" name="comments" cols="40" rows="5" tabindex="4"></textarea><br />
			</label>
			
			<cfif getProperty("useCaptcha")>
				#event.getArg("captchaSnip")#
			</cfif>
			
			<div class="submit-wrap">
				<input type="submit" value="#getProperty('resourceBundleService').getResourceBundle().getResource('submit')#" class="submit" tabindex="21" /><br />
			</div>
		
		</fieldset>
		
	</form>
	<br />
	
	<!--- <h1>#getProperty("resourceBundleService").getResourceBundle().getResource("googlegroup")#</h1>
	
	<table style="background-color: ##fff; padding: 5px;" cellspacing="0">
		<tr>
			<td>
				<img src="http://groups.google.com/groups/img/3/groups_bar.gif" height="26" width="132" alt="Google Groups" />
			</td>
		</tr>
		<tr>
			<td style="padding-left: 5px;font-size: 125%">
				<strong>CapitolHillUserGroup</strong>
			</td>
		</tr>
		<tr>
			<td style="padding-left: 5px">
				<a href="http://groups.google.com/group/capitolhillusergroup">Visit this group</a>
			</td>
		</tr>
	</table> --->
	
	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
		objForm = new qForm("contactForm");
		objForm.name.required = true;
		objForm.name.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('name')#";
		objForm.email.required = true;
		objForm.email.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('email')#";
		objForm.email.validateEmail("#getProperty('resourceBundleService').getResourceBundle().getResource('emailnotvalid')#");
		<cfif getProperty("useCaptcha")>
			objForm.captchaValidate.required = true;
			objForm.captchaValidate.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('captchalabel')#";
		</cfif>
		objForm.comments.required = true;
		objForm.comments.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('comments')#";
		//--><!]]>
	</script>

</cfoutput>