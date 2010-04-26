<cfcomponent 
	displayname="IMGateway_MySQL" 
	output="false" 
	extends="IMGateway" 
	hint="IMGateway - MySQL">
	
	<cffunction name="init" access="public" output="false" returntype="IMGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getIMsByPersonID" access="public" output="false" returntype="array">
		<cfargument name="personID" type="string" required="true" />
		
		<cfset var getIMs = 0 />
		<cfset var ims = arrayNew(2) />
		
		<cftry>
			<cfquery name="getIMs" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				SELECT 	person_im.im_type_id, 
						person_im.im_handle, 
						im_type.im_type 
				FROM 	person_im 
				LEFT OUTER JOIN im_type ON person_im.im_type_id = im_type.im_type_id 
				WHERE 	person_im.person_id = <cfqueryparam value="#arguments.personID#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfif getIMs.recordCount gt 0>
			<cfloop query="getIMs">
				<cfset ims[getIMs.currentRow][1] = getIMs.im_type />
				<cfset ims[getIMs.currentRow][2] = getIMs.im_handle />
			</cfloop>
		</cfif>
		
		<cfreturn ims />
	</cffunction>
	
	<cffunction name="savePersonIMs" access="public" output="false" returntype="void">
		<cfargument name="personID" type="string" required="true" />
		<cfargument name="ims" type="array" required="true" />
		
		<cfset var insertIMs = 0 />
		<cfset var i = 0 />
		
		<cfloop index="i" from="1" to="#arrayLen(arguments.ims)#" step="1">
			<cftry>
				<cfquery name="insertIMs" datasource="#getDatasource().getDSN()#" 
						username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
					INSERT INTO person_im (
						person_id, 
						im_type_id, 
						im_handle
					) VALUES (
						<cfqueryparam value="#arguments.personID#" cfsqltype="cf_sql_char" maxlength="35" />, 
						<cfqueryparam value="#arguments.ims[i][1]#" cfsqltype="cf_sql_char" maxlength="35" />, 
						<cfqueryparam value="#arguments.ims[i][2]#" cfsqltype="cf_sql_varchar" maxlength="100" />
					)
				</cfquery>
				<cfcatch type="database">
					<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
				</cfcatch>
			</cftry>
		</cfloop>
	</cffunction>
	
	<cffunction name="deletePersonIMs" access="public" output="false" returntype="void">
		<cfargument name="personID" type="string" required="true" />
		
		<cfset var deleteIMs = 0 />
		
		<cftry>
			<cfquery name="deleteIMs" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				DELETE FROM person_im 
				WHERE person_id = <cfqueryparam value="#arguments.personID#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			<cfcatch type="database">
				<cfthrow type="application" message="Database Error" detail="#CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
	</cffunction>

</cfcomponent>