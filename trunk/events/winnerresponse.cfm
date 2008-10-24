<cfset variables.excludelist = "jay@cyber-jay.com,a.west@me.com,sgordon@vaco.com">


<cfquery name="qryRegistrants" datasource="ncfug">
	SELECT first_name, last_name, email
	FROM rsvp
	WHERE meeting_ID = <cfqueryparam value="#FORM.meeting_id#" cfsqltype="cf_sql_varchar">
	and email NOT IN (<cfqueryparam value="#variables.excludelist#" list="true" cfsqltype="cf_sql_varchar">)
	ORDER BY RAND() LIMIT 0,1
</cfquery>



<cfoutput>
<h1>#qryRegistrants.first_name# #qryRegistrants.last_name#</h1>
<h5>#qryRegistrants.email#</h5>
</cfoutput>