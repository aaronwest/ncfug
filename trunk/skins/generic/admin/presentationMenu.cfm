<cfoutput>
	<script type="text/javascript">
		function deletePresentation(presentationID) {
			if(confirm("#getProperty('resourceBundleService').getResourceBundle().getResource('confirmpresentationdelete')#")) {
				location.href = "index.cfm?#getProperty('eventParameter')#=admin.deletePresentation&presentationID=" + presentationID;
			}
		}
	</script>
	
<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("managepresentations")#</h2>

	<cfif event.isArgDefined("message")>
		<p class="message">#event.getArg("message")#</p>
	</cfif>
	
	<ul>
		<li>
			<a href="index.cfm?#getProperty('eventParameter')#=admin.showPresentationForm">
				#getProperty("resourceBundleService").getResourceBundle().getResource("addnewpresentation")#
			</a>
		</li>
	</ul>
	
	<cfif ArrayLen(presentations) GT 0>
		<table class="standardTable">
			<tbody>
				<tr>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("presentation")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("presenters")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("datecreated")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("active")#</th>
					<th>#getProperty("resourceBundleService").getResourceBundle().getResource("action")#</th>
				</tr>
				<cfloop index="i" from="1" to="#ArrayLen(presentations)#" step="1">
					<cfset presentation = presentations[i] />
					<cfset presenters = presentation.getPresenters() />
					<tr<cfif (i MOD 2) EQ 0> class="odd"</cfif>>
						<td>#presentation.getTitle()#</td>
						<td>
							<cfloop index="j" from="1" to="#arrayLen(presenters)#" step="1">
								<cfset presenter = presenters[j] />
								#presenter.getLastName()#, #presenter.getFirstName()#<cfif j lt arrayLen(presenters)><br /></cfif>
							</cfloop>
						</td>
						<td class="datetime">#getProperty("resourceBundleService").getLocaleUtils().i18nDateTimeFormat(presentation.getAudit().getDTCreated(), 3, 3)#</td>
						<td class="active">
							<cfif presentation.getAudit().getIsActive() eq 1>
								<img alt="Active" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick.png" />
							<cfelse>
								<img alt="Inactive" src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/images/tick_disabled.png" />
							</cfif>
						</td>
						<td class="action">
							<a href="index.cfm?#getProperty('eventParameter')#=admin.showPresentationForm&amp;presentationID=#presentation.getPresentationID()#">
								#getProperty("resourceBundleService").getResourceBundle().getResource("edit")#
							</a>
							<a href="javascript:void(0);" onClick="javascript:deletePresentation('#presentation.getPresentationID()#');">
								#getProperty("resourceBundleService").getResourceBundle().getResource("delete")#
							</a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	<cfelse>
		<em>#getProperty("resourceBundleService").getResourceBundle().getResource("nopresentations")#</em>
	</cfif>
</cfoutput>