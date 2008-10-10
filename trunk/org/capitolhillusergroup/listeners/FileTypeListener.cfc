<cfcomponent 
	displayname="FileTypeListener" 
	output="false" 
	extends="MachII.framework.Listener">

	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- don't need anything here for now --->
	</cffunction>
	
	<cffunction name="setFileTypeService" access="public" output="false" returntype="void">
		<cfargument name="fileTypeService" type="org.capitolhillusergroup.filetype.FileTypeService" required="true" />
		<cfset variables.fileTypeService = arguments.fileTypeService />
	</cffunction>
	<cffunction name="getFileTypeService" access="public" output="false" returntype="org.capitolhillusergroup.filetype.FileTypeService">
		<cfreturn variables.fileTypeService />
	</cffunction>

</cfcomponent>