<cfoutput>
	<script type="text/javascript">
		function deleteBoardPosition(boardPositionID) {
			if(confirm("#getProperty('resourceBundleService').getResourceBundle().getResource('confirmboardpositiondelete')#")) {
				location.href = "#BuildUrl('admin.deleteBoardPosition')#boardPositionID/" + boardPositionID;
			}
		}
		
		function deleteBoardMember(boardPositionID) {
			if(confirm("#getProperty('resourceBundleService').getResourceBundle().getResource('confirmboardmemberdelete')#")) {
				location.href = "#BuildUrl('admin.deleteBoardMember')#boardPositionID/" + boardPositionID;
			}
		}
	</script>
	
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("manageboardpositions")#</h2>
	
	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<ul>
		<li>
			<a href="#BuildUrl('admin.showBoardPositionForm')#">
				#getProperty("resourceBundleService").getResourceBundle().getResource("addnewboardposition")#
			</a>
		</li>
	</ul>
	
	<cfif boardPositions.recordCount gt 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("boardposition")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("action")#</th>
				</tr>
				<cfloop query="boardPositions">
					<tr<cfif (boardPositions.currentRow MOD 2) EQ 0> class="odd"</cfif>>
						<td>#boardPositions.board_position#</td>
						<td class="action">
							<a href="#BuildUrl('admin.showBoardPositionForm')#boardPositionID/#boardPositions.board_position_id#">
								#getProperty("resourceBundleService").getResourceBundle().getResource("edit")#
							</a>
							<a href="javascript:void(0);" onClick="javascript:deleteBoardPosition('#boardPositions.board_position_id#');">
								#getProperty("resourceBundleService").getResourceBundle().getResource("delete")#
							</a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	<cfelse>
		<em>#getProperty("resourceBundleService").getResourceBundle().getResource("noboardpositions")#</em>
	</cfif>
	<br />
	<h1>#getProperty("resourceBundleService").getResourceBundle().getResource("boardmembers")#</h1>
	
	<ul>
		<li>
			<a href="#BuildUrl('admin.showBoardMemberForm')#">
				#getProperty("resourceBundleService").getResourceBundle().getResource("addnewboardmember")#
			</a>
		</li>
	</ul>
	
	<cfif boardMembers.recordCount gt 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("boardposition")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("name")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("action")#</th>
				</tr>
				<cfloop query="boardMembers">
					<tr<cfif (boardMembers.currentRow MOD 2) EQ 0> class="odd"</cfif>>
						<td>#boardMembers.board_position#</td>
						<td>#boardMembers.last_name#, #boardMembers.first_name#</td>
						<td>
							<a href="javascript:void(0);" onClick="javascript:deleteBoardMember('#boardMembers.board_position_id#');">
								#getProperty("resourceBundleService").getResourceBundle().getResource("delete")#
							</a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	<cfelse>
		<em>#getProperty("resourceBundleService").getResourceBundle().getResource("noboardmembers")#</em>
	</cfif>
</cfoutput>