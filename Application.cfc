<cfcomponent displayname="Application.cfc" 
				output="false" 
				extends="MachII.mach-ii" 
				hint="Application.cfc for CHUG">
	
	<!--- application settings - allows multiple user groups and sites per application --->
	
	<!--- cf settings --->
	<cfset this.name = "chug" />
	<cfset this.clientManagement = false />
	<cfset this.sessionManagement = true />
	<cfset this.sessionTimeout = createTimeSpan(0, 0, 30, 0) />
	<cfset this.setClientCookies = true />

	<!--- mach-ii settings --->
	<cfset baseDirectory = "#getDirectoryFromPath(GetCurrentTemplatePath())#">
	<cfset MACHII_CONFIG_PATH = "#baseDirectory#/config/mach-ii.xml.cfm" />
	<cfset MACHII_CONFIG_MODE = 0 />

	<cffunction name="onApplicationStart" output="false" returntype="boolean">
		<cfset loadFramework() />
		<cfreturn true />
	</cffunction>
	
	<cffunction name="onApplicationEnd" output="false" returntype="void">
		<cfargument name="applicationScope" type="struct" required="true" />
	</cffunction>
	
	<cffunction name="onSessionStart" output="false" returntype="void">
	</cffunction>
	
	<cffunction name="onSessionEnd" output="false" returntype="void">
		<cfargument name="sessionScope" type="struct" required="true" />
		<cfargument name="applicationScope" type="struct" required="false" />
	</cffunction>
	
	<cffunction name="onRequestStart" output="true" returntype="boolean">
		<cfargument name="thePage" type="string" required="true" />

		<cfif NOT CompareNoCase(ExpandPath("."),REReplaceNoCase(baseDirectory,"[\\|/]{1}$",""))>
			<cfif structKeyExists(url,"reinit")>
				<cfset MACHII_CONFIG_MODE = 1 />
				<cfset onApplicationStart()>
			</cfif>

			<cfset handleRequest() />
		</cfif>
		
		<cfreturn true />
	</cffunction>
	
	<!---
	<cffunction name="onRequest" output="true" returntype="void">
		<cfargument name="thePage" type="string" required="true" />
		<cfinclude template="#arguments.thePage#" />
	</cffunction>
	--->
	
	<!---
	<cffunction name="onRequestEnd" output="false" returntype="void">
		<cfargument name="thePage" type="string" required="true" />
	</cffunction>
	--->
	
	<!--- 
	<cffunction name="onError" output="false" returntype="void">
		<cfargument name="exception" required="true" />
		<cfargument name="eventName" type="string" required="true" />
	</cffunction>
	--->
</cfcomponent>