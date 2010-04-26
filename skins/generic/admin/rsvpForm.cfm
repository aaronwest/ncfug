<cfoutput>
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("rsvpformeeting")#</h2>

	<cfif event.isArgDefined("message")>
		<p style="color:red;">#event.getArg("message")#</p>
	</cfif>
	
	<h2>
		TODO: THIS PAGE IS NOT DISPLAYING ALL THE RIGHT DATA AND THE FORM EDITING DOESN'T WORK!!!
		#meeting.getTitle()#<br />
		#getProperty("resourceBundleService").getLocaleUtils().i18nDateTimeFormat(meeting.getDTMeeting(), 3, 3)#<br />
		#meeting.getLocation().getLocation()#
	</h2>

	<form id="rsvpForm" action="#BuildUrl('admin.processRSVPForm')#" class="standardForm" method="post">
		
		<fieldset>

			<label for="firstName"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("firstname")#</span>
				<input type="text" id="firstName" name="firstName" size="30" maxlength="100" tabindex="1" value="#rsvp.getFirstName()#" /><br />
			</label>
			
			<label for="lastName"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("lastname")#</span>
				<input type="text" id="lastName" name="lastName" size="30" maxlength="100" tabindex="2" value="#rsvp.getLastName()#" /><br />
			</label>
		
			<label for="email"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("email")#</span>
				<input type="text" id="email" name="email" size="30" maxlength="100" tabindex="3" value="#rsvp.getEmail()#" /><br />
			</label>
			
			<label for="comments"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("comments")#</span>
				<textarea id="comments" name="comments" cols="40" tabindex="4" rows="8">#rsvp.getComments()#</textarea><br />
			</label>
			
			<div class="submit-wrap">
				<input type="submit" value="#getProperty('resourceBundleService').getResourceBundle().getResource('submit')#" class="submit" tabindex="5" /><br />
			</div>
			
			<input type="hidden" name="rsvpID" id="rsvpID" value="#rsvp.getRSVPID()#" />
			<input type="hidden" name="personID" id="personID" value="#rsvp.getPersonID()#" />
			<input type="hidden" name="meetingID" id="meetingID" value="#meeting.getMeetingID()#" />
		
		</fieldset>
		
	</form>

	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
		objForm = new qForm("rsvpForm");
		objForm.firstName.required = true;
		objForm.firstName.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('firstName')#";
		objForm.lastName.required = true;
		objForm.lastName.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('lastName')#";
		objForm.email.required = true;
		objForm.email.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('email')#";
		objForm.email.validateEmail("#getProperty('resourceBundleService').getResourceBundle().getResource('emailnotvalid')#");
		//--><!]]>
	</script>

</cfoutput>