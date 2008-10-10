<cfcomponent
	displayname="ResourceBundleFacade"
	output="false"
	hint="ResourceBundleFacade component for CHUG app">
	
	<cfproperty name="resourceBundle" type="org.hastings.locale.ResourceBundle" required="false" />
	<cfproperty name="localeUtils" type="org.hastings.locale.utils" required="false" />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" output="false" returntype="ResourceBundleFacade" 
			hint="Constructor for this CFC.">
 		<cfreturn this />
	</cffunction>

	<!---
	ACCESSORS
	--->	
	<cffunction name="setResourceBundle" access="public" output="false" returntype="void">
		<cfargument name="resourceBundle" type="org.hastings.locale.ResourceBundle" required="true" />
		<cfset Application.resourceBundle = arguments.resourceBundle />
	</cffunction>
	<cffunction name="getResourceBundle" access="public" output="false" returntype="org.hastings.locale.ResourceBundle">
		<cfreturn Application.resourceBundle />
	</cffunction>
	
	<cffunction name="setLocaleUtils" access="public" output="false" returntype="void">
		<cfargument name="localeUtils" type="org.hastings.locale.utils" required="true" />
		<cfset Application.localeUtils = arguments.localeUtils />
	</cffunction>
	<cffunction name="getLocaleUtils" access="public" output="false" returntype="org.hastings.locale.utils">
		<cfreturn Application.localeUtils />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="resourceBundleExists" access="public" output="false" returntype="boolean" 
		hint="Returns a boolean indicating whether or not there is a resourceBundle in the Application scope.">
		<cfset var rbExists = false />
		
		<cfif StructKeyExists(Application, "resourceBundle")>
			<cfset rbExists = true />
		</cfif>
		
		<cfreturn rbExists />
	</cffunction>
</cfcomponent>