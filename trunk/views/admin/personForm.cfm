<cfsilent>
	<cfset person = event.getArg("person") />
	<cfset authType = event.getArg("authType")>
	<cfset eventName = event.getName()>

	<cfset organizations = event.getArg("organizations",queryNew("id")) />
	<cfset countries = event.getArg("countries",queryNew("id")) />
	<cfset states = event.getArg("states",queryNew("id")) />
	<cfset roles = event.getArg("roles", queryNew("id")) />
	<cfset imTypes = event.getArg("imTypes", queryNew("id")) />
	
	<cfset personFormAction = "processRegistrationForm">
	<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("register")>
	
	<cfif CompareNoCase(eventName,"admin.showPersonForm") EQ 0>
		<cfset personFormAction = "admin.processPersonForm">
		
		<cfif person.getPersonID() IS "">
			<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("addperson") />
		<cfelse>
			<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("updateperson") />
		</cfif>
		
	<cfelseif CompareNoCase(eventName,"member.showPersonForm") EQ 0>
		<cfset personFormAction = "member.processPersonForm">
		<cfset action = getProperty("resourceBundleService").getResourceBundle().getResource("updateperson") />
	</cfif>
	
</cfsilent>
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/personForm.cfm" />