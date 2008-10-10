<cfoutput>
	<h2>#getProperty("resourceBundleService").getResourceBundle().getResource("thankyou")#</h2>

	<cfif event.isArgDefined("message")>
		<p style="color:red;">#event.getArg("message")#</p>
	</cfif>
</cfoutput>