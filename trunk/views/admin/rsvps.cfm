<cfsilent>
	<cfset meeting = event.getArg("meeting") />
	<cfset rsvps = event.getArg("rsvps") />
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/rsvps.cfm" />