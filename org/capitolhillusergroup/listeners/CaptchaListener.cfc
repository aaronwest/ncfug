<!---
Copyright: Maestro Publishing
Author: Peter J. Farrell (pjf@maestropublishing.com)
$Id: CaptchaListener.cfc 1187 2007-07-07 02:40:10Z pfarrell $

Notes:
--->
<cfcomponent
	displayname="captchaListener"
	extends="MachII.framework.Listener"	
	output="false"
	hint="Performs captcha listener actions.">

	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />
	<cfset variables.captchaService = "" />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Initializes the listener.">
	</cffunction>

	<cffunction name="setCaptchaService" access="public" returntype="void" output="false">
		<cfargument name="captchaService" type="org.lyla.captcha.captchaService" required="true" />
		<cfset variables.captchaService = arguments.captchaService />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getHashReference" access="public" returntype="any" output="false"
		hint="Gets a hash reference struct.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var results = StructNew() />
		
		<cfif getProperty("useCaptcha")>
			<cfset results = variables.captchaService.createHashReference() />
		</cfif>
		
		<cfreturn results />
	</cffunction>
	
	<cffunction name="createCaptchaFromHashReference" access="public" returntype="struct" output="false"
		hint="Gets a captcha stream from hash reference.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfreturn variables.captchaService.createCaptchaFromHashReference(getProperty("captchaType"), arguments.event.getArg("hashReference", "")) />
	</cffunction>

	<cffunction name="validateCaptcha" access="public" returntype="void" output="false"
		hint="Validates a captcha. Bypassed when in dev mode.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var captchaValidate = arguments.event.getArg("captchaValidate", "") />
		<cfset var captchaHash = arguments.event.getArg("captchaHash", "") />
		<cfset var message = "" />
		
		<cfif getProperty("useCaptcha") AND NOT variables.captchaService.validateCaptcha(captchaHash, captchaValidate)>
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("captchafail") />
			<cfset event.setArg("captchaMessage", message) />
		</cfif>
	</cffunction>

</cfcomponent>