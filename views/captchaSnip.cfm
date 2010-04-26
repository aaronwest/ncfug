<cfsilent>
	<cfset captcha = event.getArg("captcha", StructNew()) />
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/captchaSnip.cfm" />