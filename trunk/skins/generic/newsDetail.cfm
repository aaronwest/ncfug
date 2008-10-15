<cfoutput>
	<h2>#news.getHeadline()#</h2>
	
	<h3>#getProperty("resourceBundleService").getLocaleUtils().i18nDateTimeFormat(news.getDTToPost(), 3, 3)#</h3>
	
	<p>#news.getBody()#</p>
	
	<p><a href="#getProperty('baseURL')##getProperty('eventParameter')#/news">&lt;&lt;#getProperty("resourceBundleService").getResourceBundle().getResource("backtonews")#</a></p>
</cfoutput>
