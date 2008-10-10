<cfcomponent displayname="Audit" output="false" hint="Audit bean">

	<cffunction name="init" access="public" output="false" returntype="Audit" hint="Constructor for this CFC">
		<cfargument name="createdByID" type="string" required="false" default="" />
		<cfargument name="createdByName" type="string" required="false" default="" />
		<cfargument name="dtCreated" type="numeric" required="false" default="0" />
		<cfargument name="ipCreated" type="string" required="false" default="" />
		<cfargument name="modifiedByID" type="string" required="false" default="" />
		<cfargument name="modifiedByName" type="string" required="false" default="" />
		<cfargument name="dtModified" type="numeric" required="false" default="0" />
		<cfargument name="ipModified" type="string" required="false" default="" />
		<cfargument name="isActive" type="boolean" required="false" default="false" />
		
		<cfscript>
			setCreatedByID(arguments.createdById);
			setCreatedByName(arguments.createdByName);
			setDTCreated(arguments.dtCreated);
			setIPCreated(arguments.ipCreated);
			setModifiedByID(arguments.modifiedById);
			setModifiedByName(arguments.modifiedByName);
			setDTModified(arguments.dtModified);
			setIPModified(arguments.ipModified);
			setIsActive(arguments.isActive);
		</cfscript>
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setCreatedByID" access="public" output="false" returntype="void">
		<cfargument name="createdByID" type="string" required="true" />
		<cfset variables.createdByID = arguments.createdByID />
	</cffunction>
	<cffunction name="getCreatedByID" access="public" output="false" returntype="string">
		<cfreturn variables.createdByID />
	</cffunction>
	
	<cffunction name="setCreatedByName" access="public" output="false" returntype="void">
		<cfargument name="createdByName" type="string" required="true" />
		<cfset variables.createdByName = arguments.createdByName />
	</cffunction>
	<cffunction name="getCreatedByName" access="public" output="false" returntype="string">
		<cfreturn variables.createdByName />
	</cffunction>
	
	<cffunction name="setDTCreated" access="public" output="false" returntype="void">
		<cfargument name="dtCreated" type="numeric" required="true" />
		<cfset variables.dtCreated = arguments.dtCreated />
	</cffunction>
	<cffunction name="getDTCreated" access="public" output="false" returntype="numeric">
		<cfreturn variables.dtCreated />
	</cffunction>
	
	<cffunction name="setIPCreated" access="public" output="false" returntype="void">
		<cfargument name="ipCreated" type="string" required="true" />
		<cfset variables.ipCreated = arguments.ipCreated />
	</cffunction>
	<cffunction name="getIPCreated" access="public" output="false" returntype="string">
		<cfreturn variables.ipCreated />
	</cffunction>
	
	<cffunction name="setModifiedByID" access="public" output="false" returntype="void">
		<cfargument name="modifiedByID" type="string" required="true" />
		<cfset variables.modifiedByID = arguments.modifiedByID />
	</cffunction>
	<cffunction name="getModifiedByID" access="public" output="false" returntype="string">
		<cfreturn variables.modifiedByID />
	</cffunction>
	
	<cffunction name="setModifiedByName" access="public" output="false" returntype="void">
		<cfargument name="modifiedByName" type="string" required="true" />
		<cfset variables.modifiedByName = arguments.modifiedByName />
	</cffunction>
	<cffunction name="getModifiedByName" access="public" output="false" returntype="string">
		<cfreturn variables.modifiedByName />
	</cffunction>
	
	<cffunction name="setDTModified" access="public" output="false" returntype="void">
		<cfargument name="dtModified" type="numeric" required="true" />
		<cfset variables.dtModified = arguments.dtModified />
	</cffunction>
	<cffunction name="getDTModified" access="public" output="false" returntype="numeric">
		<cfreturn variables.dtModified />
	</cffunction>
	
	<cffunction name="setIPModified" access="public" output="false" returntype="void">
		<cfargument name="ipModified" type="string" required="true" />
		<cfset variables.ipModified = arguments.ipModified />
	</cffunction>
	<cffunction name="getIPModified" access="public" output="false" returntype="string">
		<cfreturn variables.ipModified />
	</cffunction>
	
	<cffunction name="setIsActive" access="public" output="false" returntype="void">
		<cfargument name="isActive" type="boolean" required="true" />
		<cfset variables.isActive = arguments.isActive />
	</cffunction>
	<cffunction name="getIsActive" access="public" output="false" returntype="boolean">
		<cfreturn variables.isActive />
	</cffunction>
	
</cfcomponent>
