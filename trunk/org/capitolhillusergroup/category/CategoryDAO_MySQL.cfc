<cfcomponent 
	displayname="CategoryDAO_MySQL" 
	output="false" 
	extends="CategoryDAO" 
	hint="CategoryDAO - MySQL">

	<cffunction name="init" access="public" output="false" returntype="CategoryDAO" hint="Constructor for this CFC.">
		<cfreturn this />
	</cffunction>

	<cffunction name="fetch" access="public" output="false" returntype="void" hint="Populates a category bean">
		<cfargument name="category" type="Category" required="true" />
		
		<cfset var getCategory = 0 />
		<cfset var dtModified = 0 />
		<cfset var audit = createObject("component", "org.capitolhillusergroup.audit.Audit").init() />
		
		<cfquery name="getCategory" datasource="#getDatasource().getDSN()#" 
				username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
			SELECT 	category.category_id, 
					category.category, 
					category.created_by_id, 
					category.dt_created, 
					category.ip_created, 
					category.modified_by_id, 
					category.dt_modified, 
					category.ip_modified, 
					category.is_active, 
					cb.first_name AS cbfn, 
					cb.last_name AS cbln, 
					mb.first_name AS mbfn, 
					mb.last_name AS mbln 
			FROM 	category 
			LEFT OUTER JOIN person AS cb 
				ON category.created_by_id = cb.person_id 
			LEFT OUTER JOIN person AS mb 
				ON category.modified_by_id = mb.person_id 
			WHERE 	category.category_id = <cfqueryparam value="#arguments.category.getCategoryID()#" cfsqltype="cf_sql_char" maxlength="35" />
		</cfquery>
		
		<cfif getCategory.recordCount eq 1>
			<cfif getCategory.dt_modified is not "">
				<cfset dtModified = getCategory.dt_modified />
			</cfif>
			
			<cfset audit.init(getCategory.created_by_id, getCategory.cbfn & " " & getCategory.cbln, getCategory.dt_created, getCategory.ip_created, 
								getCategory.modified_by_id, getCategory.mbfn & " " & getCategory.mbln, dtModified, getCategory.ip_modified, 
								getCategory.is_active) />
			
			<cfset arguments.category.init(getCategory.category_id, getCategory.category, audit) />
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void" hint="Saves a category">
		<cfargument name="category" type="Category" required="true" />
		
		<cfif arguments.category.getCategoryID() is "">
			<cfset arguments.category.setCategoryID(createUUID()) />
			<cfset create(arguments.category) />
		<cfelse>
			<cfset update(arguments.category) />
		</cfif>
	</cffunction>
	
	<cffunction name="create" access="private" output="false" returntype="void" hint="Creates a new category">
		<cfargument name="category" type="Category" required="true" />
		
		<cfset var insertCategory = 0 />
		
		<cfquery name="insertCategory" datasource="#getDatasource().getDSN()#" 
				username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
			INSERT INTO category (
				category_id, 
				category, 
				created_by_id, 
				dt_created, 
				ip_created, 
				is_active
			) VALUES (
				<cfqueryparam value="#arguments.category.getCategoryID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
				<cfqueryparam value="#arguments.category.getCategory()#" cfsqltype="cf_sql_varchar" maxlength="500" />, 
				<cfqueryparam value="#arguments.category.getAudit().getCreatedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
				<cfqueryparam value="#arguments.category.getAudit().getDTCreated()#" cfsqltype="cf_sql_bigint" />, 
				<cfqueryparam value="#arguments.category.getAudit().getIPCreated()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
				<cfqueryparam value="#arguments.category.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" />
			)
		</cfquery>
	</cffunction>

	<cffunction name="update" access="private" output="false" returntype="void" hint="Updates a category">
		<cfargument name="category" type="Category" required="true" />
		
		<cfset var updateCategory = 0 />
		
		<cfquery name="updateCategory" datasource="#getDatasource().getDSN()#" 
				username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
			UPDATE 	category 
			SET 	category = <cfqueryparam value="#arguments.category.getCategory()#" cfsqltype="cf_sql_varchar" maxlength="500" />, 
					modified_by_id = <cfqueryparam value="#arguments.category.getAudit().getModifiedByID()#" cfsqltype="cf_sql_char" maxlength="35" />, 
					dt_modified = <cfqueryparam value="#arguments.category.getAudit().getDTModified()#" cfsqltype="cf_sql_bigint" />, 
					ip_modified = <cfqueryparam value="#arguments.category.getAudit().getIPModified()#" cfsqltype="cf_sql_varchar" maxlength="15" />, 
					is_active = <cfqueryparam value="#arguments.category.getAudit().getIsActive()#" cfsqltype="cf_sql_tinyint" /> 
			WHERE 	category_id = <cfqueryparam value="#arguments.category.getCategoryID()#" cfsqltype="cf_sql_char" maxlength="35" />
		</cfquery>
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void" hint="Deletes a category">
		<cfargument name="category" type="Category" required="true" />
		
		<cfset var deleteCategory = 0 />
		<cfset var deleteArticleCategories = 0 />
		<cfset var deleteBookCategories = 0 />
		
		<cftransaction action="begin">
			<cfquery name="deleteArticleCategories" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				DELETE FROM article_category 
				WHERE category_id = <cfqueryparam value="#arguments.category.getCategoryID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			
			<cfquery name="deleteBookCategories" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				DELETE FROM book_category 
				WHERE category_id = <cfqueryparam value="#arguments.category.getCategoryID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
			
			<cfquery name="deleteCategory" datasource="#getDatasource().getDSN()#" 
					username="#getDatasource().getUserName()#" password="#getDatasource().getPassword()#">
				DELETE FROM category 
				WHERE category_id = <cfqueryparam value="#arguments.category.getCategoryID()#" cfsqltype="cf_sql_char" maxlength="35" />
			</cfquery>
		</cftransaction>
	</cffunction>
	
</cfcomponent>