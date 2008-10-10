<cfoutput>
	<h2>#action#</h2>

	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>

	<form id="newsForm" class="standardForm" action="index.cfm?#getProperty('eventParameter')#=admin.processNewsForm" method="post">
		
		<fieldset>	

			<label for="headline"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("headline")#</span>
				<input type="text" id="headline" name="headline" size="50" maxlength="500" value="#news.getHeadline()#" /><br />
			</label>
			
			<label for="body"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("body")#</span>
				<cfif Len(Trim(getProperty("useWysiwygEditor"))) GT 0 AND getProperty("useWysiwygEditor")>
					<cfswitch expression="#getProperty('wysiwygEditor')#">
						<cfcase value="FCKeditor">
							<cfset bodyEditor = CreateObject("component","org.capitolhillusergroup.fckeditor.fckeditor")>
							<cfset bodyEditor.instanceName = "body">
							<cfset bodyEditor.value = news.getBody()>
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
					<textarea id="body" name="body" cols="40" rows="8">#news.getBody()#</textarea><br />
				</cfif>
			</label>
			
			<label for="dtToPost"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("datetopost")#</span>
				<input type="text" name="dtToPost" id="dtToPost" size="30" maxlength="30" readonly="true" /><img src="js/calendar/calbutton.gif" id="calendarTrigger" class="button" /><br />
			</label>
			
			<label for="isActive"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</span>
				<input type="checkbox" id="isActive" name="isActive" class="checkbox right" value="1"<cfif news.getAudit().getIsActive() eq 1> checked="checked"</cfif> /><br />
			</label>
				
			<div class="submit-wrap">
				<input type="submit" value="#action#" class="submit" tabindex="4" /><br />
			</div>
			
			<input type="hidden" id="newsID" name="newsID" value="#news.getNewsID()#" />
			
		</fieldset>	
		
	</form>
	
	<script type="text/javascript">
		// calendar settings
		Calendar.setup(
			{
				inputField : "dtToPost", 
				ifFormat : "#getProperty("resourceBundleService").getLocaleUtils().getJSDateInputPattern(3, 3)#", 
				button : "calendarTrigger", 
				showsTime: true, 
				timeFormat: "12"
			}
		);
		
		var curDate = new Date();
		if (document.forms.newsForm.newsID.value != '') {
			curDate = new Date(#getProperty("resourceBundleService").getLocaleUtils().getYear(news.getDTToPost())#, 
										#getProperty("resourceBundleService").getLocaleUtils().getMonth(news.getDTToPost()) - 1#, 
										#getProperty("resourceBundleService").getLocaleUtils().getDay(news.getDTToPost())#, 
										#getProperty("resourceBundleService").getLocaleUtils().getHour(news.getDTToPost())#, 
										#getProperty("resourceBundleService").getLocaleUtils().getMinute(news.getDTToPost())#, 
										#getProperty("resourceBundleService").getLocaleUtils().getSecond(news.getDTToPost())#);
		}
		document.getElementById("dtToPost").value = curDate.print("#getProperty("resourceBundleService").getLocaleUtils().getJSDateInputPattern(3, 3)#");

		<!--//--><![CDATA[//><!--
		objForm = new qForm("newsForm");
		objForm.headline.required = true;
		objForm.headline.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("headline")#";
		objForm.dtToPost.required = true;
		objForm.dtToPost.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("dtToPost")#";
		//--><!]]>
	</script>

</cfoutput>