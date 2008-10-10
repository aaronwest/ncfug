<cfoutput>
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("boardmembers")#</h2>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<form id="boardMemberForm" class="standardForm" action="index.cfm?#getProperty('eventParameter')#=admin.processBoardMemberForm" method="post">
	
		<fieldset>
			
			<label for="boardPositionID"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("boardposition")#</span>	
				<select id="boardPositionID" name="boardPositionID">
					<option value="">- #getProperty("resourceBundleService").getResourceBundle().getResource("select")# -</option>
					<cfloop query="boardPositions">
						<option value="#boardPositions.board_position_id#">#boardPositions.board_position#</option>
					</cfloop>
				</select><br />
			</label>
			
			<label for="personID"><span class="label"><span class="required">*</span>#getProperty("resourceBundleService").getResourceBundle().getResource("member")#</span>
				<select id="personID" name="personID">
					<option value="">- #getProperty("resourceBundleService").getResourceBundle().getResource("select")# -</option>
					<cfloop query="members">
						<option value="#members.person_id#">#members.last_name#, #members.first_name#</option>
					</cfloop>
				</select><br />
			</label>
			
			<div class="submit-wrap">
				<input type="submit" value="#getProperty('resourceBundleService').getResourceBundle().getResource('addboardmember')#" class="submit" tabindex="4" /><br />
			</div>
			
		</fieldset>
		
	</form>
	
	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
		objForm = new qForm("boardMemberForm");
		objForm.boardPositionID.required = true;
		objForm.boardPositionID.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('boardposition')#";
		objForm.personID.required = true;
		objForm.personID.description = "#getProperty('resourceBundleService').getResourceBundle().getResource('member')#";
		//--><!]]>
	</script>
</cfoutput>