<cfcomponent
	displayname="ResourceBundleService"
	output="false"
	hint="ResourceBundleService for CHUG app">

	<!---
	PROPERTIES
	--->
	<cfproperty name="resourceBundleFacade" type="ResourceBundleFacade" 
			required="true" />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" output="false" returntype="ResourceBundleService" 
		hint="Initializes the service.">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getResourceBundleFacade" access="public" output="false" 
			returntype="ResourceBundleFacade">
		<cfreturn variables.resourceBundleFacade />
	</cffunction>
	<cffunction name="setResourceBundleFacade" access="public" output="false" returntype="void"
			hint="Dependency: injected">
		<cfargument name="resourceBundleFacade" type="ResourceBundleFacade" required="true" />
		<cfset variables.resourceBundleFacade = arguments.resourceBundleFacade />
	</cffunction>	
	
	<cffunction name="resourceBundleExists" access="public" output="false" returntype="boolean" 
			hint="Returns a boolean indicating whether or not a resource bundle exists">
		<cfreturn getResourceBundleFacade().resourceBundleExists() />
	</cffunction>
	
	<cffunction name="getResourceBundle" access="public" output="false" returntype="org.hastings.locale.ResourceBundle">
		<cfreturn getResourceBundleFacade().getResourceBundle() />
	</cffunction>
	<cffunction name="setResourceBundle" access="public" output="false" returntype="void" 
			hint="Sets the resource bundle">
		<cfargument name="rb" type="org.hastings.locale.ResourceBundle" required="true" />
		<cfset getResourceBundleFacade().setResourceBundle(arguments.rb) />
	</cffunction>
	
	<cffunction name="getLocaleUtils" access="public" output="false" returntype="org.hastings.locale.utils">
		<cfreturn getResourceBundleFacade().getLocaleUtils() />
	</cffunction>
	<cffunction name="setLocaleUtils" access="public" output="false" returntype="void">
		<cfargument name="localeUtils" type="org.hastings.locale.utils" required="true" />
		<cfset getResourceBundleFacade().setLocaleUtils(arguments.localeUtils) />
	</cffunction>
</cfcomponent>