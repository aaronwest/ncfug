<cfcomponent displayname="EmailService" output="false" hint="Email Service for CHUG">

	<cffunction name="init" access="public" output="false" returntype="EmailService">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getEmailBean" access="public" output="false" returntype="Email">
		<cfreturn createObject("component", "Email").init() />
	</cffunction>

</cfcomponent>