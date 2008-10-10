<cfcomponent 
	displayname="PresentationFileService" 
	output="false" 
	hint="PresentationFileService">

	<cffunction name="init" access="public" output="false" returntype="RoleService">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setRoleDAO" access="public" output="false" returntype="void">
		<cfargument name="roleDAO" type="RoleDAO" required="true" />
		<cfset variables.roleDAO = arguments.roleDAO />
	</cffunction>
	<cffunction name="getRoleDAO" access="public" output="false" returntype="RoleDAO">
		<cfreturn variables.roleDAO />
	</cffunction>
	
	<cffunction name="setRoleGateway" access="public" output="false" returntype="void">
		<cfargument name="roleGateway" type="RoleGateway" required="true" />
		<cfset variables.roleGateway = arguments.roleGateway />
	</cffunction>
	<cffunction name="getRoleGateway" access="public" output="false" returntype="RoleGateway">
		<cfreturn variables.roleGateway />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getRoleBean" access="public" output="false" returntype="Role">
		<cfreturn createObject("component", "Role").init() />
	</cffunction>
	
	<cffunction name="getRoleByID" access="public" output="false" returntype="Role">
		<cfargument name="roleID" type="string" required="true" />
		<cfset var role = getRoleBean() />
		<cfset role.setRoleID(arguments.roleID) />
		
		<cfif arguments.roleID is not "">
			<cfset getRoleDAO().fetch(role) />
		</cfif>

		<cfreturn role />
	</cffunction>
	
	<cffunction name="getRoles" access="public" output="false" returntype="query">
		<cfargument name="getActiveOnly" type="boolean" required="false" default="false" />
		<cfreturn getRoleGateway().getRoles(arguments.getActiveOnly) />
	</cffunction>
	
	<cffunction name="saveRole" access="public" output="false" returntype="void">
		<cfargument name="role" type="Role" required="true" />
		<cfset getRoleDAO().save(arguments.role) />
	</cffunction>
	
	<cffunction name="deleteRole" access="public" output="false" returntype="void">
		<cfargument name="role" type="Role" required="true" />
		<cfset getRoleDAO().delete(arguments.role) />
	</cffunction>

</cfcomponent>