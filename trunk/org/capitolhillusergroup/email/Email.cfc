<cfcomponent
	displayname="Email"
	output="false"
	hint="Email bean for CHUG">

	<!---
	PROPERTIES
	--->
	<cfproperty name="toEmail" type="string" required="false" default="" />
	<cfproperty name="fromEmail" type="string" required="false" default="" />
	<cfproperty name="subject" type="string" required="false" default="" />
	<cfproperty name="body" type="string" required="false" default="" />
	<cfproperty name="ccEmail" type="string" required="false" default="" />
	<cfproperty name="bccEmail" type="string" required="false" default="" />
	<cfproperty name="replyToEmail" type="string" required="false" default="" />
	<cfproperty name="emailType" type="string" required="false" default="text/plain" />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" output="false" returntype="Email" 
		hint="Constructor for this CFC.">
		<cfargument name="toEmail" type="string" required="false" default="" />
		<cfargument name="fromEmail" type="string" required="false" default="" />
		<cfargument name="subject" type="string" required="false" default="" />
		<cfargument name="body" type="string" required="false" default="" />
		<cfargument name="ccEmail" type="string" required="false" default="" />
		<cfargument name="bccEmail" type="string" required="false" default="" />
		<cfargument name="replyToEmail" type="string" required="false" default="" />
		<cfargument name="emailType" type="string" required="false" default="text/plain" />
		
		<cfscript>
			setToEmail(arguments.toEmail);
			setFromEmail(arguments.fromEmail);
			setSubject(arguments.subject);
			setBody(arguments.body);
			setCcEmail(arguments.ccEmail);
			setBccEmail(arguments.bccEmail);
			setReplyToEmail(arguments.replyToEmail);
			setEmailType(arguments.emailType);
		</cfscript>
		
		<cfreturn this />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setToEmail" access="public" output="false" returntype="void">
		<cfargument name="toEmail" type="string" required="true" />
		<cfset variables.toEmail = arguments.toEmail />
	</cffunction>
	<cffunction name="getToEmail" access="public" output="false" returntype="string">
		<cfreturn variables.toEmail />
	</cffunction>
	
	<cffunction name="setFromEmail" access="public" output="false" returntype="void">
		<cfargument name="fromEmail" type="string" required="true" />
		<cfset variables.fromEmail = arguments.fromEmail />
	</cffunction>
	<cffunction name="getFromEmail" access="public" output="false" returntype="string">
		<cfreturn variables.fromEmail />
	</cffunction>
	
	<cffunction name="setSubject" access="public" output="false" returntype="void">
		<cfargument name="subject" type="string" required="true" />
		<cfset variables.subject = arguments.subject />
	</cffunction>
	<cffunction name="getSubject" access="public" output="false" returntype="string">
		<cfreturn variables.subject />
	</cffunction>
	
	<cffunction name="setBody" access="public" output="false" returntype="void">
		<cfargument name="body" type="string" required="true" />
		<cfset variables.body = arguments.body />
	</cffunction>
	<cffunction name="getBody" access="public" output="false" returntype="string">
		<cfreturn variables.body />
	</cffunction>
	
	<cffunction name="setCcEmail" access="public" output="false" returntype="void">
		<cfargument name="ccEmail" type="string" required="true" />
		<cfset variables.ccEmail = arguments.ccEmail />
	</cffunction>
	<cffunction name="getCcEmail" access="public" output="false" returntype="string">
		<cfreturn variables.ccEmail />
	</cffunction>
	
	<cffunction name="setBccEmail" access="public" output="false" returntype="void">
		<cfargument name="bccEmail" type="string" required="true" />
		<cfset variables.bccEmail = arguments.bccEmail />
	</cffunction>
	<cffunction name="getBccEmail" access="public" output="false" returntype="string">
		<cfreturn variables.bccEmail />
	</cffunction>
	
	<cffunction name="setReplyToEmail" access="public" output="false" returntype="void">
		<cfargument name="replyToEmail" type="string" required="true" />
		<cfset variables.replyToEmail = arguments.replyToEmail />
	</cffunction>
	<cffunction name="getReplyToEmail" access="public" output="false" returntype="string">
		<cfreturn variables.replyToEmail />
	</cffunction>
	
	<cffunction name="setEmailType" access="public" output="false" returntype="void">
		<cfargument name="emailType" type="string" required="true" />
		<cfset variables.emailType = arguments.emailType />
	</cffunction>
	<cffunction name="getEmailType" access="public" output="false" returntype="string">
		<cfreturn variables.emailType />
	</cffunction>
</cfcomponent>