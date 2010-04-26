<cfsilent>
	<cfset message = event.getArg("message", "") />
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/forgotPassword.cfm" />