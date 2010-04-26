<cfoutput>
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("boardmembers")#</h2>
	
	<table class="standardTable">
		<tbody>
			<tr>
				<th>Position</th>
				<th>Name</th>
			</tr>
			<cfloop query="boardMembers">
				<tr>
					<td class="sub">#boardMembers.board_position#</td>
					<td>#boardMembers.first_name# #boardMembers.last_name#</td>
				</tr>
			</cfloop>
		</tbody>
	</table>
</cfoutput>
