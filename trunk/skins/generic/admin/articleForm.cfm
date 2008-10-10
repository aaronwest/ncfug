<cfoutput>
	<h2>#action#</h2>

	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>

	<form id="articleForm" class="standardForm" action="index.cfm?#getProperty('eventParameter')#=admin.processArticleForm" method="post">
		
		<fieldset>	

			<label for="title"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("title")#</span>
				<input type="text" id="title" name="title" size="50" maxlength="500" value="#article.getTitle()#" /><br />
			</label>
			
			<label for="content"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("content")#</span>
				<cfif Len(Trim(getProperty("useWysiwygEditor"))) GT 0 AND getProperty("useWysiwygEditor")>
					<cfswitch expression="#getProperty('wysiwygEditor')#">
						<cfcase value="FCKeditor">
							<cfset bodyEditor = CreateObject("component","org.capitolhillusergroup.fckeditor.fckeditor")>
							<cfset bodyEditor.instanceName = "content">
							<cfset bodyEditor.value = article.getContent()>
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
					<textarea id="content" name="content" cols="40" rows="8">#article.getContent()#</textarea><br />
				</cfif>
			</label>
			
			<label for="categories"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("categories")#</span>
				<select id="categoryIDs" name="categoryIDs" size="5" multiple="true">
					<cfloop query="categories">
						<option value="#categories.category_id#"<cfif listFind(currentCategoryIDs, categories.category_id, ",") neq 0> selected="selected"</cfif>>#categories.category#</option>
					</cfloop>
				</select><br />
			</label>

			<label for="authors"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("authors")#</span>
				<select id="authorIDs" name="authorIDs" size="5" multiple="true">
					<cfloop query="authors">
						<option value="#authors.person_id#"<cfif listFind(currentAuthorIDs, authors.person_id, ",") neq 0> selected="selected"</cfif>>#authors.last_name#, #authors.first_name#</option>
					</cfloop>
				</select><br />
			</label>
			
			<label for="isActive"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</span>
				<input type="checkbox" id="isActive" name="isActive" class="checkbox right" value="1"<cfif article.getAudit().getIsActive() eq 1> checked="checked"</cfif> /><br />
			</label>
				
			<div class="submit-wrap">
				<input type="submit" value="#action#" class="submit" tabindex="4" /><br />
			</div>
			
			<input type="hidden" id="articleID" name="articleID" value="#article.getArticleID()#" />
			
		</fieldset>	
		
	</form>
	
	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
		objForm = new qForm("articleForm");
		objForm.title.required = true;
		objForm.title.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("title")#";
		objForm.content.required = true;
		objForm.content.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("content")#";
		//--><!]]>
	</script>

</cfoutput>