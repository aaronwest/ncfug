<cfoutput>
	<h2>#action#</h2>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<form id="presentationForm" class="standardForm" action="index.cfm?#getProperty('eventParameter')#=admin.processPresentationForm" method="post" enctype="multipart/form-data">
		<fieldset>
			<label for="title"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("title")#</span>
				<input type="text" id="title" name="title" size="50" maxlength="250" value="#presentation.getTitle()#" /></td>
			</label>			

			<label for="summary"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("summary")#</span>
				<cfif Len(Trim(getProperty("useWysiwygEditor"))) GT 0 AND getProperty("useWysiwygEditor")>
					<cfswitch expression="#getProperty('wysiwygEditor')#">
						<cfcase value="FCKeditor">
							<cfset bodyEditor = CreateObject("component","org.capitolhillusergroup.fckeditor.fckeditor")>
							<cfset bodyEditor.instanceName = "summary">
							<cfset bodyEditor.value = presentation.getSummary()>
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
					<textarea id="summary" name="summary" cols="40" rows="8">#presentation.getSummary()#</textarea><br />
				</cfif>
			</label>	
			
			<label for="email"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("presenters")#</span>
				<select id="presenterIDs" name="presenterIDs" size="5" multiple="true">
					<cfloop query="presenters">
						<option value="#presenters.person_id#"<cfif listFind(currentPresenterIDs, presenters.person_id, ",") neq 0> selected="selected"</cfif>>#presenters.last_name#, #presenters.first_name#</option>
					</cfloop>
				</select><br />				
			</label>
			
			<label for="isActive"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</span>
				<input type="checkbox" class="checkbox right" id="isActive" name="isActive" value="1" <cfif presentation.getAudit().getIsActive() EQ 1> checked="checked"</cfif> /><br />
			</label>	
		</fieldset>
		
		<fieldset>
			<legend>#getProperty("resourceBundleService").getResourceBundle().getResource("presentationfile")#</legend>
			
			<label for="presentationFile"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("presentationfile")#</span>
				<input type="file" id="presentationFile" name="presentationFile" /><br />
				<cfif presentation.getPresentationFile() is not ""><br />
					<span class="detail">
						#getProperty("resourceBundleService").getResourceBundle().getResource("currentfile")#: 
						#presentation.getPresentationFileTitle()# (<a href="#getProperty('presentationFilePath')##presentation.getPresentationFile()#">#presentation.getPresentationFile()#</a>)<br />
						<label for="deleteFile">
							<input type="checkbox" id="deleteFile" name="deleteFile" class="checkbox" value="1" />
							#getProperty("resourceBundleService").getResourceBundle().getResource("deletefile")#
						</label>
					</span>	
				</cfif>
			</label>	
			
			<label for="presentationFileTitle"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("title")#</span>
				<input type="text" id="presentationFileTitle" name="presentationFileTitle" size="50" maxlength="250" value="#presentation.getPresentationFileTitle()#" /><br />
			</label>	
			
			<label for="presentationFileDescription"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("description")#</span>
				<input type="text" id="presentationFileDescription" name="presentationFileDescription" size="50" maxlength="500" value="#presentation.getPresentationFileDescription()#" /><br />
			</label>	
			
			<div class="submit-wrap">
				<input type="submit" value="#action#" class="submit" tabindex="4" /><br />
			</div>
			
			<input type="hidden" name="presentationID" value="#presentation.getPresentationID()#" />
			<input type="hidden" name="oldPresentationFile" value="#presentation.getPresentationFile()#" />
			
		</fieldset>
		
	</form>
	
	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
		objForm = new qForm("presentationForm");
		objForm.title.required = true;
		objForm.title.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('title')#";
		objForm.presenterIDs.required = true;
		objForm.presenterIDs.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('presenters')#";
		//--><!]]>
	</script>
</cfoutput>