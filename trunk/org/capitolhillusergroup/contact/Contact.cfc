<cfcomponent
	displayname="Contact"
	output="false"
	hint="A bean which models the Contact form.">

	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Contact" output="false">
		<cfargument name="name" type="string" required="false" default="" />
		<cfargument name="email" type="string" required="false" default="" />
		<cfargument name="reason" type="string" required="false" default="" />
		<cfargument name="comments" type="string" required="false" default="" />

		<!--- run setters --->
		<cfset setName(arguments.name) />
		<cfset setEmail(arguments.email) />
		<cfset setReason(arguments.reason) />
		<cfset setComments(arguments.comments) />

		<cfreturn this />
 	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfset variables.instance.name = arguments.name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.name />
	</cffunction>

	<cffunction name="setEmail" access="public" returntype="void" output="false">
		<cfargument name="email" type="string" required="true" />
		<cfset variables.instance.email = arguments.email />
	</cffunction>
	<cffunction name="getEmail" access="public" returntype="string" output="false">
		<cfreturn variables.instance.email />
	</cffunction>
	
	<cffunction name="setReason" access="public" returntype="void" output="false">
		<cfargument name="reason" type="string" required="true" />
		<cfset variables.instance.reason = arguments.reason />
	</cffunction>
	<cffunction name="getReason" access="public" returntype="string" output="false">
		<cfreturn variables.instance.reason />
	</cffunction>

	<cffunction name="setComments" access="public" returntype="void" output="false">
		<cfargument name="comments" type="string" required="true" />
		<cfset variables.instance.comments = arguments.comments />
	</cffunction>
	<cffunction name="getComments" access="public" returntype="string" output="false">
		<cfreturn variables.instance.comments />
	</cffunction>

</cfcomponent>