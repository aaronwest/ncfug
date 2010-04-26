<cfcomponent 
	displayname="AddressService" 
	output="false" 
	hint="AddressService">

	<cffunction name="init" access="public" output="false" returntype="AddressService">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setAddressDAO" access="public" output="false" returntype="void">
		<cfargument name="addressDAO" type="AddressDAO" required="true" />
		<cfset variables.addressDAO = arguments.addressDAO />
	</cffunction>
	<cffunction name="getAddressDAO" access="public" output="false" returntype="AddressDAO">
		<cfreturn variables.addressDAO />
	</cffunction>
	
	<cffunction name="setAddressGateway" access="public" output="false" returntype="void">
		<cfargument name="addressGateway" type="AddressGateway" required="true" />
		<cfset variables.addressGateway = arguments.addressGateway />
	</cffunction>
	<cffunction name="getAddressGateway" access="public" output="false" returntype="AddressGateway">
		<cfreturn variables.addressGateway />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getAddressBean" access="public" output="false" returntype="Address">
		<cfreturn createObject("component", "Address").init() />
	</cffunction>
	
	<cffunction name="getStates" access="public" output="false" returntype="query">
		<cfreturn getAddressGateway().getStates() />
	</cffunction>
	
	<cffunction name="uploadStates" access="public" output="false" returntype="void">
		<cfargument name="states" type="Array" required="true" />
		<cfreturn getAddressDAO().uploadStates(ARGUMENTS.states) />
	</cffunction>
	
	<cffunction name="getCountries" access="public" output="false" returntype="query">
		<cfreturn getAddressGateway().getCountries() />
	</cffunction>
	
	<cffunction name="uploadCountries" access="public" output="false" returntype="void">
		<cfargument name="countries" type="Array" required="true" />
		<cfreturn getAddressDAO().uploadCountries(ARGUMENTS.countries) />
	</cffunction>
	
	<cffunction name="getStateAbbreviations" access="public" output="false" returntype="query">
		<cfreturn getAddressGateway().getStateAbbreviations() />
	</cffunction>
	
	<cffunction name="getAddressByID" access="public" output="false" returntype="Address" hint="Retrieves an address">
		<cfargument name="addressID" type="string" required="true" />
		
		<cfset var address = getAddressBean() />
		<cfset address.setAddressID(arguments.addressID) />
		
		<cfif arguments.addressID is not "">
			<cfset getAddressDAO().fetch(address) />
		</cfif>
		
		<cfreturn address />
	</cffunction>
	
	<cffunction name="getAddressByPersonID" access="public" output="false" returntype="Address" hint="Retrieves an address">
		<cfargument name="personID" type="string" required="true" />
		
		<cfset var address = getAddressBean() />

		<cfif ARGUMENTS.personID is not "">
			<cfset getAddressDAO().getAddressByPersonID(ARGUMENTS.personID,address) />
		</cfif>
		
		<cfreturn address />
	</cffunction>
	
	<cffunction name="saveAddress" access="public" output="false" returntype="void">
		<cfargument name="address" type="Address" required="true" />
		<cfset getAddressDAO().save(arguments.address) />
	</cffunction>
	
	<cffunction name="savePersonAddress" access="public" output="false" returntype="void">
		<cfargument name="personID" type="string" required="true" />
		<cfargument name="addressID" type="string" required="true" />
		<cfset getAddressDAO().savePersonAddress(ARGUMENTS.personID,ARGUMENTS.addressID) />
	</cffunction>
	
	<cffunction name="deleteAddress" access="public" output="false" returntype="void">
		<cfargument name="address" type="Address" required="true" />
		<cfset getAddressDAO().delete(arguments.address) />
	</cffunction>
	
	<cffunction name="deleteAddressByID" access="public" output="false" returntype="void" hint="Deletes an address">
		<cfargument name="addressID" type="string" required="true" />
		
		<cfset var address = createObject("component", "Address").init(arguments.addressID) />
		
		<cfset getAddressDAO().delete(address) />
	</cffunction>

</cfcomponent>