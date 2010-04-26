<cfcomponent displayname="IMService" output="false" hint="IMService for CHUG">

	<cffunction name="init" access="public" output="false" returntype="IMService">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setIMGateway" access="public" output="false" returntype="void">
		<cfargument name="imGateway" type="IMGateway" required="true" />
		<cfset variables.imGateway = arguments.imGateway />
	</cffunction>
	<cffunction name="getIMGateway" access="public" output="false" returntype="IMGateway">
		<cfreturn variables.imGateway />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getIMsByPersonID" access="public" output="false" returntype="array">
		<cfargument name="personID" type="string" required="true" />
		<cfreturn getIMGateway().getIMsByPersonID(arguments.personID) />
	</cffunction>
	
	<cffunction name="savePersonIMs" access="public" output="false" returntype="void">
		<cfargument name="personID" type="string" required="true" />
		<cfargument name="ims" type="array" required="true" />
		
		<cfset deletePersonIMs(arguments.personID) />
		<cfset getIMGateway().savePersonIMs(arguments.personID, arguments.ims) />
	</cffunction>
	
	<cffunction name="deletePersonIMs" access="public" output="false" returntype="void">
		<cfargument name="personID" type="string" required="true" />
		<cfset getIMGateway().deletePersonIMs(arguments.personID) />
	</cffunction>

</cfcomponent>