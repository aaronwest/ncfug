<cfcomponent
	displayname="AppVars"
	extends="MachII.framework.Plugin"
	output="false"
	hint="Plugin to ensure all the application-wide objects and variables needed are set as properties in the property manager.">

	<!---
	INITIALIZATION / CONFIGURATIONS
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the plugin.">
		<cfset setProperty("resourceBundleService", getResourceBundleService()) />
		<cfset getProperty("resourceBundleService").getResourceBundle().loadResourceBundle() />
		<!--- <cfset setProperty("udfs", getUdfs()) /> --->
	</cffunction>

	<cffunction name="setResourceBundleService" access="public" output="false" returntype="void"
		hint="Dependency: injected">
		<cfargument name="resourceBundleService" type="org.capitolhillusergroup.i18n.ResourceBundleService" 
				required="true" />
		<cfset variables.resourceBundleService = arguments.resourceBundleService />
	</cffunction>
	<cffunction name="getResourceBundleService" access="private" output="false" 
				returntype="org.capitolhillusergroup.i18n.ResourceBundleService">
		<cfreturn variables.resourceBundleService />
	</cffunction>
	
	<!--- <cffunction name="setUdfs" access="public" output="false" returntype="void" 
			hint="Dependency: injected">
		<cfargument name="udfs" type="org.capitolhillusergroup.utils.udfs" required="true" />
		<cfset variables.udfs = arguments.udfs />
	</cffunction>
	<cffunction name="getUdfs" access="private" output="false" returntype="org.capitolhillusergroup.utils.udfs">
		<cfreturn variables.udfs />
	</cffunction> --->
	
	<!---
	PUBLIC FUNCTIONS - PLUGIN POINTS
	--->
	<cffunction name="preProcess" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />

		<cfset var firstEvent = arguments.eventContext.getNextEvent() />

		<!--- Set the URL event name --->
		<cfset firstEvent.setArg("mainEvent", firstEvent.getName()) />
	</cffunction>
		
	<!---
	<cffunction name="postEvent" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
	</cffunction>
	
	<cffunction name="preView" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
	</cffunction>
	
	<cffunction name="postView" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
	</cffunction>
	
	<cffunction name="postProcess" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
	</cffunction>
	--->
	
	<cffunction name="handleException" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfargument name="exception" type="MachII.util.Exception" required="true" />
	</cffunction>

</cfcomponent>