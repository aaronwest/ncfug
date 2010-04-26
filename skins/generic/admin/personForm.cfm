<cfoutput>
	<script type="text/javascript">
		function doImagePopup(imageURL) {
			window.open(imageURL, 'image', 'width=400,height=400,location=no,status=no');
		}
	</script>

	<h2>#action#</h2>

	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>

	<form id="personForm" class="standardForm" action="#BuildUrl('admin.processPersonForm')#" method="post" enctype="multipart/form-data">
		
		<fieldset>

			<label for="firstName"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("firstname")#</span>
				<input type="text" id="firstName" name="firstName" size="50" maxlength="250" value="#person.getFirstName()#" /><br />
			</label>
			
			<label for="lastName"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("lastname")#</span>
				<input type="text" id="lastName" name="lastName" size="50" maxlength="250" value="#person.getLastName()#" /><br />
			</label>
			
			<label for="title"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("title")#</span>
				<input type="text" id="title" name="title" size="50" maxlength="250" value="#person.getTitle()#" /><br />
			</label>
			
			<cfif CompareNoCase(eventName,"admin.showPersonForm") EQ 0>
				<label for="organizationID"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("organization")#</span>
					<select id="organizationID" name="organizationID">
						<option value="">- #getProperty("resourceBundleService").getResourceBundle().getResource("select")# -</option>
						<cfloop query="organizations">
							<option value="#organization_id#"<cfif person.getOrganization().getOrganizationID() is organization_id> selected="selected"</cfif>>#organization#</option>
						</cfloop>
					</select><br />
				</label>
			</cfif>
			
			<label for="email"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("email")#</span>
				<input type="text" id="email" name="email" size="50" maxlength="250" value="#person.getEmail()#" /><br />
			</label>
			
			<label for="url"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("url")#</span>
				<input type="text" id="url" name="url" size="50" maxlength="255" value="#person.getURL()#" /><br />
			</label>
			
			<cfif CompareNoCase(eventName,"admin.showPersonForm") EQ 0 OR CompareNoCase(eventName,"member.showPersonForm") EQ 0>
				<label for="image"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("image")#</span>
					<input type="file" id="image" name="image" /><br />
					<cfif person.getImage() IS NOT "">
						<span class="detail">
							<a href="javascript:void(0);" onclick="javascript:doImagePopup('#getProperty('baseURL')##getProperty('personImageFilePath')##person.getImage()#')">
								#getProperty("resourceBundleService").getResourceBundle().getResource("viewcurrentimage")#
							</a>
							<label for="deleteFile">
								<input type="checkbox" id="deleteFile" name="deleteFile" class="checkbox" value="1" />
								#getProperty("resourceBundleService").getResourceBundle().getResource("deletefile")#
							</label>
						</span>
					</cfif>
				</label>
			</cfif>
			
			<label for="bio"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("bio")#</span>
				<textarea name="bio">#person.getBio()#</textarea>
			</label>

			<label for="password"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("password")#</span>
				<input type="password" id="password" name="password" size="50" maxlength="50" value="#person.getPassword()#" /><br />
				<!--- <span class="detail">#getProperty("resourceBundleService").getResourceBundle().getResource("passwordmessage")#</span> --->
			</label>
			
			<label for="phone"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("phone")#</span>
				<input type="text" id="phone" name="phone" size="50" maxlength="50" value="#person.getPhone()#" /><br />
			</label>
			
			<cfif CompareNoCase(eventName,"admin.showPersonForm") EQ 0>
				<label for="isActive"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</span>
					<input type="checkbox" class="checkbox right" id="isActive" name="isActive" value="1" <cfif person.getAudit().getIsActive() neq 0> checked="checked"</cfif> /><br />
				</label>
				
				<label for="isAdmin"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("admin")#</span>
					<input type="checkbox" class="checkbox right" id="isAdmin" name="isAdmin" value="1" <cfif person.getIsAdmin() neq 0> checked="checked"</cfif> /><br />
				</label>
			
			
				<label for="roleID"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("role")#</span>
					<select id="roleID" name="roleID">
						<option value="">- #getProperty("resourceBundleService").getResourceBundle().getResource("select")# -</option>
						<cfloop query="roles">
							<option value="#role_id#"<cfif person.getRole().getRoleID() is role_id> selected="selected"</cfif>>#role#</option>
						</cfloop>
					</select><br />
				</label>
			<cfelse>
				<input type="hidden" id="isActive" name="isActive" value="#person.getAudit().getIsActive()#" />
				<input type="hidden" id="isAdmin" name="isAdmin" value="#person.getIsAdmin()#" />
				<input type="hidden" id="roleID" name="roleID" value="#person.getRole().getRoleID()#" />
			</cfif>
		</fieldset>
		
		<fieldset>	
			<legend>#getProperty("resourceBundleService").getResourceBundle().getResource("address")#</legend>
			
			<label for="address1"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("address1")#</span>
				<input type="text" id="address1" name="address1" size="50" maxlength="250" value="#person.getAddress().getAddress1()#" /><br />
			</label>
			
			<label for="address2"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("address2")#</span>
				<input type="text" id="address2" name="address2" size="50" maxlength="250" value="#person.getAddress().getAddress2()#" /><br />
			</label>
			
			<label for="city"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("city")#</span>
				<input type="text" id="city" name="city" size="50" maxlength="250" value="#person.getAddress().getCity()#" /><br />
			</label>
			
			<label for="stateID"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("state")#</span>
				<select id="stateID" name="stateID">
					<option value="">- #getProperty("resourceBundleService").getResourceBundle().getResource("select")# -</option>
					
					<cfif Len(person.getAddress().getStateID()) LTE 0 
					AND Len(getProperty("defaultState")) GT 0 
					AND Len(getProperty("defaultStateName")) GT 0>
						<option value="#getProperty('defaultState')#" selected="selected">#getProperty("defaultStateName")#</option>
					</cfif>
					
					<cfloop query="states">
						<option value="#states.state_id#"<cfif person.getAddress().getStateID() is states.state_id> selected="selected"</cfif>>#states.state#</option>
					</cfloop>
				</select><br />
			</label>
			
			<label for="postalCode"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("postalCode")#</span>
				<input type="text" id="postalCode" name="postalCode" size="50" maxlength="250" value="#person.getAddress().getPostalCode()#" /><br />
			</label>
			
			<label for="countryID"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("country")#</span>
				<select id="countryID" name="countryID">
					<option value="">- #getProperty("resourceBundleService").getResourceBundle().getResource("select")# -</option>
					
					<cfif Len(person.getAddress().getCountryID()) LTE 0
					AND Len(getProperty("defaultCountry")) GT 0 
					AND Len(getProperty("defaultCountryName")) GT 0>
						<option value="#getProperty('defaultCountry')#" selected="selected">#getProperty("defaultCountryName")#</option>
					</cfif>
					
					<cfloop query="countries">
						<option value="#countries.country_id#"<cfif person.getAddress().getCountryID() is countries.country_id> selected="selected"</cfif>>#countries.country#</option>
					</cfloop>
				</select><br />
			</label>
		</fieldset>
				
		<fieldset>	
			<legend>#getProperty("resourceBundleService").getResourceBundle().getResource("imaccounts")#</legend>

			<cfif imTypes.recordCount gt 0>
				<cfset personIMAccounts = person.getIMs() />
				<cfset thisIMAccount = "" />
				
				<cfloop query="imTypes">
					<cfif arrayLen(personIMAccounts) gt 0>
						<cfloop index="i" from="1" to="#arrayLen(personIMAccounts)#" step="1">
							<cfif personIMAccounts[i][1] is imTypes.im_type>
								<cfset thisIMAccount = personIMAccounts[i][2] />
								<cfbreak />
							<cfelse>
								<cfset thisIMAccount = "" />
							</cfif>
						</cfloop>
					</cfif>
					
					<label for="email"><span class="label">#im_type#</span>
						<input type="text" id="imAccount_#im_type_id#" name="imAccount_#im_type_id#" size="50" maxlength="100" value="#thisIMAccount#" /><br />
					</label>
				</cfloop>
			<cfelse>
				<span class="notice">- #getProperty("resourceBundleService").getResourceBundle().getResource("noimtypesdefined")# -</span>
			</cfif>
		</fieldset>

		<fieldset>	
			<legend>#getProperty("resourceBundleService").getResourceBundle().getResource("other")#</legend>
	
			<cfif getProperty("useCaptcha")>
				#event.getArg("captchaSnip")#
			</cfif>
			
			<cfif CompareNoCase(eventName,"admin.showPersonForm") EQ 0 OR CompareNoCase(eventName,"member.showPersonForm") EQ 0>
				<div class="submit-wrap">
					<input type="submit" value="#action#" class="submit" tabindex="4" /><br />
				</div>
				
				<input type="hidden" id="addressID" name="addressID" value="#person.getAddress().getAddressID()#" />
				<input type="hidden" id="personID" name="personID" value="#person.getPersonID()#" />
				<input type="hidden" id="oldImage" name="oldImage" value="#person.getImage()#" />
			<cfelse>
				<div class="submit-wrap">
					<input type="submit" value="#action#" class="submit" tabindex="4" /><br />
				</div>
			</cfif>
			
		</fieldset>
		
	</form>
	
	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
		objForm = new qForm("personForm");
		objForm.firstName.required = true;
		objForm.firstName.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("firstname")#";
		objForm.lastName.required = true;
		objForm.lastName.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("lastname")#";
		objForm.title.required = true;
		objForm.title.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("title")#";
		objForm.email.required = true;
		objForm.email.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("email")#";
		//--><!]]>
	</script>

</cfoutput>