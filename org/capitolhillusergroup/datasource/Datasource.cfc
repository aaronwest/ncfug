<cfcomponent displayname="Datasource" output="false" hint="Datasource bean">
	
	<cfset variables._dsn = "">
	<cfset variables._dbType = "">
	<cfset variables._userName = "">
	<cfset variables._password = "">
	<cfset variables._dbversion = "0.1">
	
	<cffunction name="init" access="public" output="false" returntype="Datasource" 
			hint="Constructor for this CFC">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setDSN" access="public" output="false" returntype="void">
		<cfargument name="dsn" type="string" required="true" />
		<cfset variables._dsn = arguments.dsn />
	</cffunction>
	<cffunction name="getDSN" access="public" output="false" returntype="string">
		<cfreturn variables._dsn />
	</cffunction>
	
	<cffunction name="setDBType" access="public" output="false" returntype="void">
		<cfargument name="dbType" type="string" required="true" />
		<cfset variables._dbType = arguments.dbType />
	</cffunction>
	<cffunction name="getDBType" access="public" output="false" returntype="string">
		<cfreturn variables._dbType />
	</cffunction>
	
	<cffunction name="setUserName" access="public" output="false" returntype="void">
		<cfargument name="userName" type="string" required="true" />
		<cfset variables._userName = arguments.userName />
	</cffunction>
	<cffunction name="getUserName" access="public" output="false" returntype="string">
		<cfreturn variables._userName />
	</cffunction>
	
	<cffunction name="setPassword" access="public" output="false" returntype="void">
		<cfargument name="password" type="string" required="true" />
		<cfset variables._password = arguments.password />
	</cffunction>
	<cffunction name="getPassword" access="public" output="false" returntype="string">
		<cfreturn variables._password />
	</cffunction>
	
	<cffunction name="setDBVersion" access="public" output="false" returntype="void">
		<cfargument name="dbversion" type="string" required="true" />
		<cfset variables._dbversion = arguments.dbversion />
	</cffunction>
	<cffunction name="getDBVersion" access="public" output="false" returntype="string">
		<cfreturn variables._dbversion />
	</cffunction>
	
	<cffunction name="getColumnExists" access="public" output="false" returntype="boolean">
		<cfargument name="column" type="string" required="true" />

		<cfset var result = false>
		
		<cfif variables._dbversion LTE 0.1>
		<cfelseif variables._dbversion GT 0.1>
			<cfif ARGUMENTS.column EQ "person.bio">
				<cfset result = true>
			</cfif>
		</cfif>
		
		<cfreturn result>
	</cffunction>
	
</cfcomponent>
