<cfcomponent displayname="CategoryListener" output="false" extends="MachII.framework.Listener">

	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- don't need anything here --->
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setCategoryService" access="public" output="false" returntype="void">
		<cfargument name="categoryService" type="org.capitolhillusergroup.category.CategoryService" 
					required="true" />
		<cfset variables.categoryService = arguments.categoryService />
	</cffunction>
	<cffunction name="getCategoryService" access="public" output="false" 
				returntype="org.capitolhillusergroup.category.CategoryService">
		<cfreturn variables.categoryService />
	</cffunction>
	
	<cffunction name="setSessionService" access="public" output="false" returntype="void">
		<cfargument name="sessionService" type="org.capitolhillusergroup.session.SessionService" 
					required="true" />
		<cfset variables.sessionService = arguments.sessionService />
	</cffunction>
	<cffunction name="getSessionService" access="public" output="false" 
				returntype="org.capitolhillusergroup.session.SessionService">
		<cfreturn variables.sessionService />
	</cffunction>
	
	<!--- listener methods --->
	<cffunction name="getCategories" access="public" output="false" returntype="query" 
			hint="Returns a query containing either all or only active categories">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getCategoryService().getCategories(arguments.event.getArg("activeOnly", true)) />
	</cffunction>
	
	<cffunction name="getCategoriesAsArray" access="public" output="false" returntype="array" 
			hint="Returns an array of category beans, either all or only active categories">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getCategoryService().getCategoriesAsArray(arguments.event.getArg("activeOnly", true)) />
	</cffunction>
	
	<cffunction name="getCategoryByID" access="public" output="false" 
				returntype="org.capitolhillusergroup.category.Category">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getCategoryService().getCategoryByID(arguments.event.getArg("categoryID", "")) />
	</cffunction>
	
	<cffunction name="processCategoryForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var category = event.getArg("category") />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		<cfset var exitEvent = "success" />
		<cfset var message = "" />
		<cfset var action = "" />
		
		<cfset audit.setIsActive(arguments.event.getArg("isActive", 0)) />
		
		<cfif category.getCategoryID() is "">
			<cfset action = "add" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addcategorysuccessful") />
			<cfset audit.setCreatedByID(getSessionService().getUser().getPersonID()) />
			<cfset audit.setDTCreated(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset audit.setIPCreated(CGI.REMOTE_ADDR) />
		<cfelse>
			<cfset action = "update" />
			<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("updatecategorysuccessful") />
			<cfset audit.setModifiedByID(getSessionService().getUser().getPersonID()) />
			<cfset audit.setDTModified(getProperty("resourceBundleService").getLocaleUtils().toEpoch(now())) />
			<cfset audit.setIPModified(CGI.REMOTE_ADDR) />
		</cfif>
		
		<cfset category.setAudit(audit) />
		
		<cftry>
			<cfset getCategoryService().saveCategory(category) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("addupdatecategoryfailed") />
				<cfif action is "add">
					<cfset category.setCategoryID("") />
				</cfif>
				<cfset arguments.event.setArg("category", category) />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="deleteCategory" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var message = getProperty("resourceBundleService").getResourceBundle().getResource("deletecategorysuccessful") />
		
		<cftry>
			<cfset getCategoryService().deleteCategory(arguments.event.getArg("category")) />
			<cfcatch type="any">
				<cfset message = getProperty("resourceBundleService").getResourceBundle().getResource("deletecategoryfailed") />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		
		<cfset announceEvent("admin.showCategoryMenu_redirect", arguments.event.getArgs()) />
	</cffunction>
</cfcomponent>