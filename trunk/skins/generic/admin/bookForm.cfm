<cfoutput>
	<h2>#action#</h2>

	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>

	<form id="bookForm" class="standardForm" action="index.cfm?#getProperty('eventParameter')#=admin.processBookForm" method="post">
		
		<fieldset>	

			<label for="title"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("title")#</span>
				<input type="text" id="title" name="title" size="50" maxlength="500" value="#book.getTitle()#" /><br />
			</label>
			
			<label for="publicationYear"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("publicationyear")#</span>
				<input type="text" id="publicationYear" name="publicationYear" size="10" maxlength="4" value="#book.getPublicationYear()#" /><br />
			</label>
			
			<!--- 
			<label for="publisher_id"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("publisher")#</span>
				<input type="text" id="publisher_id" name="publisher_id" size="35" maxlength="35" value="#book.getPublisher()#" /><br />
			</label> 
			--->
			
			<label for="isbn"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("isbn")#</span>
				<input type="text" id="isbn" name="isbn" size="20" maxlength="20" value="#book.getIsbn()#" /><br />
			</label>
			
			<label for="numPages"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("numberofpages")#</span>
				<input type="text" id="numPages" name="numPages" size="10" maxlength="4" value="#book.getNumPages()#" /><br />
			</label>
			
			<label for="price"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("price")#</span>
				<input type="text" id="price" name="price" size="10" maxlength="12" value="#book.getPrice()#" /><br />
			</label>
			
			<label for="url"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("url")#</span>
				<input type="text" id="url" name="url" size="50" maxlength="255" value="#book.getUrl()#" /><br />
			</label>
			
			<label for="categoryIDs"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("categories")#</span>
				<select id="categoryIDs" name="categoryIDs" size="5" multiple="true">
					<cfloop query="categories">
						<option value="#categories.category_id#"<cfif listFind(currentCategoryIDs, categories.category_id, ",") neq 0> selected="selected"</cfif>>#categories.category#</option>
					</cfloop>
				</select><br />
			</label>

			<label for="authorIDs"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("authors")#</span>
				<select id="authorIDs" name="authorIDs" size="5" multiple="true">
					<cfloop query="authors">
						<option value="#authors.person_id#"<cfif listFind(currentAuthorIDs, authors.person_id, ",") neq 0> selected="selected"</cfif>>#authors.last_name#, #authors.first_name#</option>
					</cfloop>
				</select><br />
			</label>
	
			<label for="isActive"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</span>
				<input type="checkbox" id="isActive" name="isActive" class="checkbox right" value="1"<cfif book.getAudit().getIsActive() eq 1> checked="checked"</cfif> /><br />
			</label>
				
			<div class="submit-wrap">
				<input type="submit" value="#action#" class="submit" tabindex="4" /><br />
			</div>
			
			<input type="hidden" id="bookID" name="bookID" value="#book.getBookID()#" />
			
		</fieldset>	
		
	</form>
	
	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
		objForm = new qForm("bookForm");
		objForm.title.required = true;
		objForm.title.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("title")#";
		objForm.publicationYear.required = true;
		objForm.publicationYear.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("publicationyear")#";
		objForm.isbn.required = true;
		objForm.isbn.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("isbn")#";
		objForm.authorIDs.required = true;
		objForm.authorIDs.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("authors")#";
		objForm.categoryIDs.required = true;
		objForm.categoryIDs.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("categories")#";
		//--><!]]>
	</script>

</cfoutput>