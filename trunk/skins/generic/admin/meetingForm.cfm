<cfoutput>
	<h2>#action#</h2>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<form id="meetingForm" class="standardForm" action="#BuildUrl('admin.processMeetingForm')#" method="post">
		
		<fieldset>
			
			<label for="title"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("title")#</span>
				<input type="text" name="title" size="100" maxlength="250" value="#meeting.getTitle()#" /><br />
			</label>
			
			<label for="description"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("description")#</span>
				<cfif Len(Trim(getProperty("useWysiwygEditor"))) GT 0 AND getProperty("useWysiwygEditor")>
					<cfswitch expression="#getProperty('wysiwygEditor')#">
						<cfcase value="FCKeditor">
							<cfset bodyEditor = CreateObject("component","org.capitolhillusergroup.fckeditor.fckeditor")>
							<cfset bodyEditor.instanceName = "description">
							<cfset bodyEditor.value = meeting.getDescription()>
							<cfset bodyEditor.basePath = "#getProperty('applicationRoot')#js/fckeditor">
							<cfset bodyEditor.width = "100%" />
							<cfset bodyEditor.height = "300" />
							<div class="input"><cfset bodyEditor.create() /></div><br />
						</cfcase>
						<cfdefaultcase>
							<em>#getProperty("resourceBundleService").getResourceBundle().getResource("wysiwygeditornotvalid")#</em>
						</cfdefaultcase>
					</cfswitch>
				<cfelse>
					<textarea id="description" name="description" cols="40" rows="8">#meeting.getDescription()#</textarea><br />
				</cfif>
			</label>
				
			<label for="locationID"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("location")#</span>
				<select id="locationID" name="locationID">
					<option value="">- #getProperty("resourceBundleService").getResourceBundle().getResource("select")# -</option>
					<cfloop query="locations">
						<option value="#locations.location_id#"<cfif meeting.getLocation().getLocationID() is locations.location_id> selected="selected"</cfif>>#locations.location#</option>
					</cfloop>
				</select><br />
			</label>
			
			<label for="connectURL"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("connecturl")#</span>
				<input type="text" id="connectURL" name="connectURL" size="50" maxlength="255" value="#meeting.getConnectURL()#" /><br />
			</label>
				
			<label for="presentationIDs"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("presentations")#</span>
				<select id="presentationIDs" name="presentationIDs" size="5" multiple="true">
					<cfloop query="presentations">
						<option value="#presentations.presentation_id#"<cfif listFind(currentPresentationIDs, presentations.presentation_id, ",") neq 0> selected="selected"</cfif>>#presentations.title# (#getProperty("resourceBundleService").getLocaleUtils().i18nDateFormat(presentations.dt_created, 3)#)</option>
					</cfloop>
				</select><br />
			</label>
			
			<label for="dtMeeting"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("meetingdatetime")#</span>
				<input type="text" name="dtMeeting" id="dtMeeting" size="30" maxlength="30" readonly="readonly" /><img src="#getProperty('baseURL')#js/calendar/calbutton.gif" id="calendarTrigger" class="button" /><br />
			</label>
			
			<label for="isActive"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</span>
				<input type="checkbox" id="isActive" name="isActive" class="checkbox right" value="1" <cfif meeting.getAudit().getIsActive() eq 1> checked="checked"</cfif> /><br />
			</label>

			<div class="submit-wrap">
				<input type="submit" value="#action#" class="submit" tabindex="4" /><br />
			</div>
			
			<input type="hidden" id="meetingID" name="meetingID" value="#meeting.getMeetingID()#" />
			
		</fieldset>
		
	</form>

	<!--- #getDateTimePattern()# --->
	<script type="text/javascript">
		// calendar settings
		Calendar.setup(
			{
				inputField : "dtMeeting", 
				ifFormat : "#getProperty("resourceBundleService").getLocaleUtils().getJSDateInputPattern(3, 3)#", 
				button : "calendarTrigger", 
				showsTime: true, 
				timeFormat: "12"
			}
		);
		
		var curDate = new Date();
		if (document.forms.meetingForm.meetingID.value != '') {
			curDate = new Date(#getProperty("resourceBundleService").getLocaleUtils().getYear(meeting.getDTMeeting())#, 
										#getProperty("resourceBundleService").getLocaleUtils().getMonth(meeting.getDTMeeting()) - 1#, 
										#getProperty("resourceBundleService").getLocaleUtils().getDay(meeting.getDTMeeting())#, 
										#getProperty("resourceBundleService").getLocaleUtils().getHour(meeting.getDTMeeting())#, 
										#getProperty("resourceBundleService").getLocaleUtils().getMinute(meeting.getDTMeeting())#, 
										#getProperty("resourceBundleService").getLocaleUtils().getSecond(meeting.getDTMeeting())#);
		}else{
			curDate = new Date(#Year(now())#, 
										#Month(now())-1#, 
										#Day(now())#, 
										#getProperty("resourceBundleService").getLocaleUtils().getHour(meeting.getDTMeeting())#, 
										#getProperty("resourceBundleService").getLocaleUtils().getMinute(meeting.getDTMeeting())#, 
										#getProperty("resourceBundleService").getLocaleUtils().getSecond(meeting.getDTMeeting())#);
		
		}
		document.getElementById("dtMeeting").value = curDate.print("#getProperty("resourceBundleService").getLocaleUtils().getJSDateInputPattern(3, 3)#");
		
		<!--//--><![CDATA[//><!--
		objForm = new qForm("meetingForm");
		objForm.title.required = true;
		objForm.title.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('title')#";
		objForm.locationID.required = true;
		objForm.locationID.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('location')#";
		objForm.dtMeeting.required = true;
		objForm.dtMeeting.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('meetingdatetime')#";
		//--><!]]>
	</script>
</cfoutput>