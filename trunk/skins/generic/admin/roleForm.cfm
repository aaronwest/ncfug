<cfoutput>
	<h2>#action#</h2>
	
	<form id="roleForm" class="standardForm" action="index.cfm?#getProperty('eventParameter')#=admin.processRoleForm" method="post">
		
		<fieldset>
			
			<label for="role"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("role")#</span>
				<input type="text" id="role" name="role" size="50" maxlength="100" value="#role.getRole()#" /><br />
			</label>
			
			<label for="description"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("description")#</span>
				<input type="text" id="description" name="description" size="50" maxlength="500" value="#role.getDescription()#" /><br />
			</label>
			
			<label for="isActive"><span class="label">#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</span>
				<input type="checkbox" id="isActive" name="isActive" value="1" class="checkbox right"<cfif role.getAudit().getIsActive() eq 1> checked="checked"</cfif> /><br />
			</label>
			
			<div class="submit-wrap">
				<input type="submit" value="#action#" class="submit" tabindex="4" /><br />
			</div>
			
			<input type="hidden" id="roleID" name="roleID" value="#role.getRoleID()#" />
			
		</fieldset>
		
	</form>
	
	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
		objForm = new qForm("roleForm");
		objForm.role.required = true;
		objForm.role.description = "#getProperty("resourceBundleService").getResourceBundle().getResource("role")#";
		//--><!]]>
	</script>

</cfoutput>