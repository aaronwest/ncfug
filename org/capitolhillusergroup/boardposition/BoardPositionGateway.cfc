<cfcomponent 
	displayname="BoardPositionGateway" 
	output="false" 
	hint="Base BoardPositionGateway">
	
	<cffunction name="init" access="public" output="false" returntype="BoardPositionGateway">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setDatasource" access="public" output="false" returntype="void"
		hint="Dependency: injected">
		<cfargument name="datasource" type="org.capitolhillusergroup.datasource.Datasource" required="true" />
		<cfset variables.datasource = arguments.datasource />
	</cffunction>	
	<cffunction name="getDatasource" access="private" output="false" returntype="org.capitolhillusergroup.datasource.Datasource">
		<cfreturn variables.datasource />
	</cffunction>
	
	<!--- gateway methods --->
	<cffunction name="getBoardPositions" access="public" output="false" returntype="query">
	</cffunction>
	
	<cffunction name="getOpenBoardPositions" access="public" output="false" returntype="query">
	</cffunction>
	
	<cffunction name="getBoardPositionCount" access="public" output="false" returntype="numeric">
	</cffunction>
	
	<cffunction name="getBoardMembers" access="public" output="false" returntype="query">
	</cffunction>
	
	<cffunction name="getNonBoardMembers" access="public" output="false" returntype="query">
	</cffunction>
	
	<cffunction name="addBoardMember" access="public" output="false" returntype="void">
		<cfargument name="boardPositionID" type="uuid" required="true" />
		<cfargument name="personID" type="uuid" required="true" />
	</cffunction>
	
	<cffunction name="deleteBoardMember" access="public" output="false" returntype="void">
		<cfargument name="boardPositionID" type="uuid" required="true" />
	</cffunction>
	
</cfcomponent>