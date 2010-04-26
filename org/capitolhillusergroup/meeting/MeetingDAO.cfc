<cfcomponent 
	displayname="MeetingDAO" 
	output="false" 
	hint="Base MeetingDAO">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" output="false" returntype="MeetingDAO" hint="Constructor for this CFC.">
		<cfreturn this />
	</cffunction>

	<cffunction name="setDatasource" access="public" output="false" returntype="void"
		hint="Dependency: injected">
		<cfargument name="datasource" type="org.capitolhillusergroup.datasource.Datasource" required="true" />
		<cfset variables.datasource = arguments.datasource />
	</cffunction>	
	<cffunction name="getDatasource" access="private" output="false" returntype="org.capitolhillusergroup.datasource.Datasource">
		<cfreturn variables.datasource />
	</cffunction>
	
	<cffunction name="setLocationService" access="public" output="false" returntype="void">
		<cfargument name="locationService" type="org.capitolhillusergroup.location.LocationService" required="true" />
		<cfset variables.locationService = arguments.locationService />
	</cffunction>
	<cffunction name="getLocationService" access="public" output="false" returntype="org.capitolhillusergroup.location.LocationService">
		<cfreturn variables.locationService />
	</cffunction>
	
	<cffunction name="setPresentationService" access="public" output="false" returntype="void">
		<cfargument name="presentationService" type="org.capitolhillusergroup.presentation.PresentationService" required="true" />
		<cfset variables.presentationService = arguments.presentationService />
	</cffunction>
	<cffunction name="getPresentationService" access="public" output="false" returntype="org.capitolhillusergroup.presentation.PresentationService">
		<cfreturn variables.presentationService />
	</cffunction>
	
	<cffunction name="setResourceBundleFacade" access="public" output="false" returntype="void">
		<cfargument name="resourceBundleFacade" type="org.capitolhillusergroup.i18n.ResourceBundleFacade" required="true" />
		<cfset variables.resourceBundleFacade = arguments.resourceBundleFacade />
	</cffunction>
	<cffunction name="getResourceBundleFacade" access="private" output="false" returntype="org.capitolhillusergroup.i18n.ResourceBundleFacade">
		<cfreturn variables.resourceBundleFacade />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS - CRUD - DATABASE SPECIFIC OBJECTS THAT EXTEND THIS OBJECT MUST OVERRIDE THESE METHODS
	--->
	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates a meeting bean">
		<cfargument name="meeting" type="Meeting" required="true" />
	</cffunction>
	
	<cffunction name="fetchDefaults" access="public" output="false" returntype="void" hint="Populates a meeting bean">
		<cfargument name="meeting" type="Meeting" required="true" />
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves a meeting">
		<cfargument name="meeting" type="Meeting" required="true" />
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new meeting">
		<cfargument name="meeting" type="Meeting" required="true" />
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates a meeting">
		<cfargument name="meeting" type="Meeting" required="true" />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes a meeting">
		<cfargument name="meeting" type="Meeting" required="true" />
	</cffunction>
	
</cfcomponent>