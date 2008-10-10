<cfcomponent 
	displayname="LocationService" 
	output="false" 
	hint="LocationService">

	<cffunction name="init" access="public" output="false" returntype="LocationService">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setLocationDAO" access="public" output="false" returntype="void">
		<cfargument name="locationDAO" type="LocationDAO" required="true" />
		<cfset variables.locationDAO = arguments.locationDAO />
	</cffunction>
	<cffunction name="getLocationDAO" access="public" output="false" returntype="LocationDAO">
		<cfreturn variables.locationDAO />
	</cffunction>
	
	<cffunction name="setLocationGateway" access="public" output="false" returntype="void">
		<cfargument name="locationGateway" type="LocationGateway" required="true" />
		<cfset variables.locationGateway = arguments.locationGateway />
	</cffunction>
	<cffunction name="getLocationGateway" access="public" output="false" returntype="LocationGateway">
		<cfreturn variables.locationGateway />
	</cffunction>
	
	<cffunction name="setAddressService" access="public" output="false" returntype="void">
		<cfargument name="addressService" type="org.capitolhillusergroup.address.AddressService" required="true" />
		<cfset variables.addressService = arguments.addressService />
	</cffunction>
	<cffunction name="getAddressService" access="public" output="false" returntype="org.capitolhillusergroup.address.AddressService">
		<cfreturn variables.addressService />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getLocationBean" access="public" output="false" returntype="Location">
		<cfreturn createObject("component", "Location").init() />
	</cffunction>
	
	<cffunction name="getLocationByID" access="public" output="false" returntype="Location" hint="Retrieves a location based on the ID passed in">
		<cfargument name="locationID" type="string" required="true" />
		
		<cfset var location = getLocationBean() />
		<cfset location.setLocationID(arguments.locationID) />
		
		<cfif arguments.locationID is not "">
			<cfset getLocationDAO().fetch(location) />
		</cfif>
		
		<cfreturn location />
	</cffunction>
	
	<cffunction name="getLocations" access="public" output="false" returtntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="false" />
		<cfreturn getLocationGateway().getLocations(arguments.activeOnly) />
	</cffunction>
	
	<cffunction name="getActiveLocations" access="public" output="false" returtntype="query">
		<cfreturn getLocations(true) />
	</cffunction>
	
	<cffunction name="saveLocation" access="public" output="false" returntype="void">
		<cfargument name="location" type="Location" required="true" />
		
		<cfset getLocationDAO().save(arguments.location) />
	</cffunction>
	
	<cffunction name="deleteLocationByID" access="public" output="false" returntype="void">
		<cfargument name="locationID" type="string" required="true" />

		<cfset getLocationDAO().delete(createObject("component", "Location").init(arguments.locationID)) />
	</cffunction>

</cfcomponent>