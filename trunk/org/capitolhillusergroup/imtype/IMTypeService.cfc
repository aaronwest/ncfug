<cfcomponent 
	displayname="IMTypeService" 
	output="false" 
	hint="IMTypeService">

	<cffunction name="init" access="public" output="false" returntype="IMTypeService">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setIMTypeDAO" access="public" output="false" returntype="void">
		<cfargument name="imTypeDAO" type="IMTypeDAO" required="true" />
		<cfset variables.imTypeDAO = arguments.imTypeDAO />
	</cffunction>
	<cffunction name="getIMTypeDAO" access="public" output="false" returntype="IMTypeDAO">
		<cfreturn variables.imTypeDAO />
	</cffunction>
	
	<cffunction name="setIMTypeGateway" access="public" output="false" returntype="void">
		<cfargument name="imTypeGateway" type="IMTypeGateway" required="true" />
		<cfset variables.imTypeGateway = arguments.imTypeGateway />
	</cffunction>
	<cffunction name="getIMTypeGateway" access="public" output="false" returntype="IMTypeGateway">
		<cfreturn variables.imTypeGateway />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getIMTypeBean" access="public" output="false" returntype="IMType">
		<cfreturn createObject("component", "IMType").init() />
	</cffunction>

	<cffunction name="getIMTypes" access="public" output="false" returntype="query">
		<cfargument name="getActiveOnly" type="boolean" required="false" default="false" />
		<cfreturn getIMTypeGateway().getIMTypes(getActiveOnly) />
	</cffunction>
	
	<cffunction name="getIMTypeByID" access="public" output="false" returntype="IMType">
		<cfargument name="imTypeID" type="string" required="true" />
		
		<cfset var imType = getIMTypeBean() />
		<cfset imType.setIMTypeID(arguments.imTypeID) />
		
		<cfif arguments.imTypeID is not "">
			<cfset getIMTypeDAO().fetch(imType) />
		</cfif>
		<cfreturn imType />
	</cffunction>
	
	<cffunction name="saveIMType" access="public" output="false" returntype="void">
		<cfargument name="imType" type="IMType" required="true" />
		
		<cfset getIMTypeDAO().save(arguments.imType) />
	</cffunction>
	
	<cffunction name="deleteIMType" access="public" output="false" returntype="void">
		<cfargument name="imType" type="IMType" required="true" />
		
		<cfset getIMTypeDAO().delete(arguments.imType) />
	</cffunction>
	
</cfcomponent>