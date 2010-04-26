<cfcomponent 
	displayname="FileTypeService" 
	output="false" 
	hint="FileTypeService">

	<cffunction name="init" access="public" output="false" returntype="FileTypeService">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setFileTypeDAO" access="public" output="false" returntype="void">
		<cfargument name="fileTypeDAO" type="FileTypeDAO" required="true" />
		<cfset variables.fileTypeDAO = arguments.fileTypeDAO />
	</cffunction>
	<cffunction name="getFileTypeDAO" access="public" output="false" returntype="FileTypeDAO">
		<cfreturn variables.fileTypeDAO />
	</cffunction>
	
	<cffunction name="setFileTypeGateway" access="public" output="false" returntype="void">
		<cfargument name="fileTypeGateway" type="FileTypeGateway" required="true" />
		<cfset variables.fileTypeGateway = arguments.fileTypeGateway />
	</cffunction>
	<cffunction name="getFileTypeGateway" access="public" output="false" returntype="FileTypeGateway">
		<cfreturn variables.fileTypeGateway />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getFileTypeBean" access="public" output="false" returntype="FileType">
		<cfreturn createObject("component", "FileType").init() />
	</cffunction>

	<cffunction name="getFileTypeByID" access="public" output="false" returntype="FileType">
		<cfargument name="fileTypeID" type="uuid" required="true" />
		<cfset var fileType = getFileTypeBean() />
		<cfset fileType.setFileTypeID(arguments.fileTypeID) />
		
		<cfif arguments.fileTypeID is not "">
			<cfreturn getFileTypeDAO().fetch(fileType) />
		</cfif>
		
		<cfreturn fileType />
	</cffunction>
	
</cfcomponent>