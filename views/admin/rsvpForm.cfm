<cfsilent>
	<cfset meeting = event.getArg("meeting") />
	<cfset rsvp = event.getArg("rsvp") />
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/rsvpForm.cfm" />