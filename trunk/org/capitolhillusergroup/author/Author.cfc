<cfcomponent
	displayname="Author"
	output="false"
	hint="A bean which models the Author form.">


	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Author" output="false">
		<cfargument name="authorID" type="string" required="false" default="" />
		<cfargument name="firstName" type="string" required="false" default="" />
		<cfargument name="lastName" type="string" required="false" default="" />
		<cfargument name="email" type="string" required="false" default="" />
		<cfargument name="url" type="string" required="false" default="" />
		<cfargument name="audit" type="org.capitolhillusergroup.audit.Audit" required="false" default="#createObject('component', 'org.capitolhillusergroup.audit.Audit').init()#" />

		<!--- run setters --->
		<cfset setAuthorID(arguments.authorID) />
		<cfset setFirstName(arguments.firstName) />
		<cfset setLastName(arguments.lastName) />
		<cfset setEmail(arguments.email) />
		<cfset setUrl(arguments.url) />
		<cfset setAudit(arguments.audit) />

		<cfreturn this />
 	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setAuthorID" access="public" returntype="void" output="false">
		<cfargument name="authorID" type="string" required="true" />
		<cfset variables.instance.authorID = arguments.authorID />
	</cffunction>
	<cffunction name="getAuthorID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.authorID />
	</cffunction>

	<cffunction name="setFirstName" access="public" returntype="void" output="false">
		<cfargument name="firstName" type="string" required="true" />
		<cfset variables.instance.firstName = arguments.firstName />
	</cffunction>
	<cffunction name="getFirstName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.firstName />
	</cffunction>

	<cffunction name="setLastName" access="public" returntype="void" output="false">
		<cfargument name="lastName" type="string" required="true" />
		<cfset variables.instance.lastName = arguments.lastName />
	</cffunction>
	<cffunction name="getLastName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.lastName />
	</cffunction>

	<cffunction name="setEmail" access="public" returntype="void" output="false">
		<cfargument name="email" type="string" required="true" />
		<cfset variables.instance.email = arguments.email />
	</cffunction>
	<cffunction name="getEmail" access="public" returntype="string" output="false">
		<cfreturn variables.instance.email />
	</cffunction>

	<cffunction name="setUrl" access="public" returntype="void" output="false">
		<cfargument name="url" type="string" required="true" />
		<cfset variables.instance.url = arguments.url />
	</cffunction>
	<cffunction name="getUrl" access="public" returntype="string" output="false">
		<cfreturn variables.instance.url />
	</cffunction>

	<cffunction name="setAudit" access="public" returntype="void" output="false">
		<cfargument name="audit" type="org.capitolhillusergroup.audit.Audit" required="true" />
		<cfset variables.instance.audit = arguments.audit />
	</cffunction>
	<cffunction name="getAudit" access="public" returntype="org.capitolhillusergroup.audit.Audit" output="false">
		<cfreturn variables.instance.audit />
	</cffunction>

</cfcomponent>