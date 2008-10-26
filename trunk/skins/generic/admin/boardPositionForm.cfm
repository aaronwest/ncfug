<cfoutput>
	<h2>#action#</h2>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<form id="boardPositionForm" class="standardForm" action="#BuildUrl('admin.processBoardPositionForm')#" method="post">
		
		<fieldset>
			
			<label for="boardPosition"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("boardposition")#</span>
				<input type="text" id="boardPosition" name="boardPosition" size="50" maxlength="250" value="#boardPosition.getBoardPosition()#" /><br />
			</label>
			
			<label for="description"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("description")#</span>
				<input type="text" id="description" name="description" size="50" maxlength="500" value="#boardPosition.getDescription()#" /><br />
			</label>
				
			<label for="sortOrder"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("sortorder")#</span>
				<select id="sortOrder" name="sortOrder">
					<option value="">- #getProperty("resourceBundleService").getResourceBundle().getResource("select")# -</option>
					<cfloop index="i" from="1" to="#boardPositionCount + 1#" step="1">
						<option value="#i#"<cfif boardPosition.getSortOrder() eq i> selected="selected"</cfif>>#i#</option>
					</cfloop>
				</select><br />
			</label>
			
			<label for="isActive"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</span>
				<input type="checkbox" id="isActive" name="isActive" value="1" class="checkbox right" <cfif boardPosition.getAudit().getIsActive() eq 1> checked="checked"</cfif> /><br />
			</label>
				
			<div class="submit-wrap">
				<input type="submit" value="#action#" class="submit" tabindex="4" /><br />
			</div>
			
			<input type="hidden" id="boardPositionID" name="boardPositionID" value="#boardPosition.getBoardPositionID()#" />			
		
		</fieldset>
		
	</form>
	
	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
		objForm = new qForm("boardPositionForm");
		objForm.boardPosition.required = true;
		objForm.boardPosition.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('boardposition')#";
		objForm.sortOrder.required = true;
		objForm.sortOrder.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('sortorder')#";
		//--><!]]>
	</script>
</cfoutput>