<cfcomponent 
	displayname="AddressListener" 
	output="false" 
	extends="MachII.framework.Listener">

	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- don't need anything here for now --->
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setAddressService" access="public" output="false" returntype="void">
		<cfargument name="addressService" type="org.capitolhillusergroup.address.AddressService" required="true" />
		<cfset variables.addressService = arguments.addressService />
	</cffunction>
	<cffunction name="getAddressService" access="public" output="false" returntype="org.capitolhillusergroup.address.AddressService">
		<cfreturn variables.addressService />
	</cffunction>
	
	<!--- listener methods --->
	<cffunction name="getStates" access="public" output="false" returntype="query">
		<cfreturn getAddressService().getStates() />
	</cffunction>
	
	<cffunction name="getCountries" access="public" output="false" returntype="query">
		<cfreturn getAddressService().getCountries() />
	</cffunction>
	
	<cffunction name="getStateAbbreviations" access="public" output="false" returntype="query">
		<cfreturn getAddressService().getStateAbbreviations() />
	</cffunction>
	
	<cffunction name="processUploadStatesForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var i = 0 />
		<cfset var exitEvent = "success" />
		<cfset var message = "" />
		<cfset var fileContent = "">
		<cfset var temp = ArrayNew(1)>
		<cfset var states = ArrayNew(1)>
		<cfset var tempPath = ExpandPath(getProperty('temporaryFilePath'))>

		<cfif ARGUMENTS.event.getArg("uploadfile") IS NOT "">
			<cftry>
				<cffile 
					action="upload" 
					filefield="uploadfile" 
					destination="#tempPath#" 
					nameconflict="makeunique"
				/>
						
				<!--- if the upload was successful --->
				<cfif CFFILE.fileWasSaved>
					
					<cffile 
						action="read" 
						file="#tempPath#/#CFFILE.serverFile#" 
						variable="fileContent"
					/>
					
					<cfset temp = ListToArray(fileContent,"#Chr(10)##Chr(13)#")>
					
					<cfloop from="1" to="#ArrayLen(temp)#" index="i">
						<cfset states[i] = StructNew()>
						<cfset states[i].state_id = CreateUUID()>
						<cfset states[i].state_abbr = ListFirst(temp[i],",")>
						<cfset states[i].state = ListRest(temp[i],",")>		
					</cfloop>
										
					<cfset getAddressService().uploadStates(states)>
				</cfif>
			
				<cfcatch type="any">
					<cfset exitEvent = "failure" />
					<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("uploadfilefailed") & " " & CFCATCH.Detail />
				</cfcatch>
			</cftry>
			
			<cftry>
				<cffile action="delete" file="#tempPath#/#CFFILE.serverFile#" />
			<cfcatch type="any">
			</cfcatch>
			</cftry>
		<cfelse>
			<cfset exitEvent = "failure" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("uploadfilefailed")>
		</cfif>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="processUploadCountriesForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var i = 0 />
		<cfset var exitEvent = "success" />
		<cfset var message = "" />
		<cfset var fileContent = "">
		<cfset var temp = ArrayNew(1)>
		<cfset var countries = ArrayNew(1)>
		<cfset var tempPath = ExpandPath(getProperty('temporaryFilePath'))>

		<cfif ARGUMENTS.event.getArg("uploadfile") IS NOT "">
			<cftry>
				<cffile 
					action="upload" 
					filefield="uploadfile" 
					destination="#tempPath#" 
					nameconflict="makeunique"
				/>
						
				<!--- if the upload was successful --->
				<cfif CFFILE.fileWasSaved>
					
					<cffile 
						action="read" 
						file="#tempPath#/#CFFILE.serverFile#" 
						variable="fileContent"
					/>
					
					<cfset temp = ListToArray(fileContent,"#Chr(10)##Chr(13)#")>
					
					<cfloop from="1" to="#ArrayLen(temp)#" index="i">
						<cfset countries[i] = StructNew()>
						<cfset countries[i].country_id = CreateUUID()>
						<cfset countries[i].country_abbr = ListFirst(temp[i],",")>
						<cfset countries[i].country = ListRest(temp[i],",")>
						<cfset countries[i].is_active = 1>
					</cfloop>
										
					<cfset getAddressService().uploadCountries(countries)>
				</cfif>
			
				<cfcatch type="any">
					<cfrethrow />
					<cfset exitEvent = "failure" />
					<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("uploadfilefailed") & " " & CFCATCH.Detail />
				</cfcatch>
			</cftry>
			
			<cftry>
				<cffile action="delete" file="#tempPath#/#CFFILE.serverFile#" />
			<cfcatch type="any">
			</cfcatch>
			</cftry>
		<cfelse>
			<cfset exitEvent = "failure" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("uploadfilefailed")>
		</cfif>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
</cfcomponent>