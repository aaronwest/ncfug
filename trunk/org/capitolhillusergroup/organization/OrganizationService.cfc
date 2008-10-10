<cfcomponent 
	displayname="OrganizationService" 
	output="false" 
	hint="OrganizationService">

	<cffunction name="init" access="public" output="false" returntype="OrganizationService">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setOrganizationDAO" access="public" output="false" returntype="void">
		<cfargument name="organizationDAO" type="OrganizationDAO" required="true" />
		<cfset variables.organizationDAO = arguments.organizationDAO />
	</cffunction>
	<cffunction name="getOrganizationDAO" access="public" output="false" returntype="OrganizationDAO">
		<cfreturn variables.organizationDAO />
	</cffunction>
	
	<cffunction name="setOrganizationGateway" access="public" output="false" returntype="void">
		<cfargument name="organizationGateway" type="OrganizationGateway" required="true" />
		<cfset variables.organizationGateway = arguments.organizationGateway />
	</cffunction>
	<cffunction name="getOrganizationGateway" access="public" output="false" returntype="OrganizationGateway">
		<cfreturn variables.organizationGateway />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getOrganizationBean" access="public" output="false" returntype="Organization">
		<cfreturn createObject("component", "Organization").init() />
	</cffunction>
	
	<cffunction name="getOrganizationByID" access="public" output="false" returntype="Organization">
		<cfargument name="organizationID" type="string" required="true" />
		<cfset var organization = getOrganizationBean() />
		<cfset organization.setOrganizationID(arguments.organizationID) />
		
		<cfif arguments.organizationID is not "">
			<cfset getOrganizationDAO().fetch(organization) />
		</cfif>
		
		<cfreturn organization />
	</cffunction>
	
	<cffunction name="getOrganizations" access="public" output="false" returntype="query" hint="Returns a query object containing all organizations">
		<cfreturn getOrganizationGateway().getOrganizations() />
	</cffunction>
	
	<cffunction name="saveOrganization" access="public" output="false" returntype="void" hint="Saves an organization">
		<cfargument name="organization" type="Organization" required="true" />
		<cfset getOrganizationDAO().save(organization) />
	</cffunction>
	
	<cffunction name="deleteOrganization" access="public" output="false" returntype="void" hint="Deletes an organization">
		<cfargument name="organization" type="Organization" required="true" />
		<cfset getOrganizationDAO().delete(organization) />
	</cffunction>
	
</cfcomponent>