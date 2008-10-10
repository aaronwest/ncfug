<cfoutput>
	<h2>#action#</h2>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<form id="locationForm" class="standardForm" action="index.cfm?#getProperty('eventParameter')#=admin.processLocationForm" method="post">
		
		<fieldset>
			
			<label for="location"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("location")#</span>
				<input type="text" id="location" name="location" size="50" maxlength="250" value="#location.getLocation()#" /><br />
			</label>
			
			<label for="mapLink"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("maplink")#</span>
				<input type="text" id="mapLink" name="mapLink" size="50" maxlength="250" value="#location.getMapLink()#" /><br />
			</label>
			
			<label for="description"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("description")#</span>
				<textarea id="description" name="description" cols="40" rows="4">#location.getDescription()#</textarea><br />
			</label>
			
			<label for="address1"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("address")#</span>
				<input type="text" id="address1" name="address1" size="50" maxlength="" value="#location.getAddress().getAddress1()#" /><br />
			</label>
			
			<label for="address2"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("addresscont")#</span>
				<input type="text" id="address2" name="address2" size="50" maxlength="250" value="#location.getAddress().getAddress2()#" /><br />
			</label>
			
			<label for="city"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("city")#</span>
				<input type="text" id="city" name="city" size="50" maxlength="250" value="#location.getAddress().getCity()#" /><br />
			</label>
			
			<label for="stateID"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("state")#</span>
				<select id="stateID" name="stateID">
					<option value="">- #getProperty("resourceBundleService").getResourceBundle().getResource("select")# -</option>
					<cfloop query="states">
						<option value="#states.state_id#"<cfif location.getAddress().getStateID() is states.state_id> selected="selected"</cfif>>#states.state_abbr#</option>
					</cfloop>
				</select><br />
			</label>
			
			<label for="postalCode"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("postalcode")#</span>
				<input type="text" id="postalCode" name="postalCode" size="50" maxlength="100" value="#location.getAddress().getPostalCode()#" /><br />
			</label>
			
			<label for="isActive"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</span>
				<input type="checkbox" class="checkbox right" id="isActive" name="isActive" value="1" <cfif location.getAudit().getIsActive() eq 1> checked="checked"</cfif> /><br />
			</label>
			
			<div class="submit-wrap">
				<input type="submit" value="#action#" class="submit" tabindex="4" /><br />
			</div>
			
			<input type="hidden" id="locationID" name="locationID" value="#location.getLocationID()#" />
			<input type="hidden" id="addressID" name="addressID" value="#location.getAddress().getAddressID()#" />
				
		</fieldset>

	</form>
	
	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
		objForm = new qForm("locationForm");
		objForm.location.required = true;
		objForm.location.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('location')#";
		//--><!]]>
	</script>
</cfoutput>