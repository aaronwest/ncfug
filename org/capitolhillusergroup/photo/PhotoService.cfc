<cfcomponent 
	displayname="PhotoService" 
	output="false" 
	hint="PhotoService">

	<cffunction name="init" access="public" output="false" returntype="PhotoService">
		<cfreturn this />
	</cffunction>
	
	<!--- dependencies --->
	<cffunction name="setPhotoDAO" access="public" output="false" returntype="void">
		<cfargument name="photoDAO" type="PhotoDAO" required="true" />
		<cfset variables.photoDAO = arguments.photoDAO />
	</cffunction>
	<cffunction name="getPhotoDAO" access="public" output="false" returntype="PhotoDAO">
		<cfreturn variables.photoDAO />
	</cffunction>
	
	<cffunction name="setPhotoGateway" access="public" output="false" returntype="void">
		<cfargument name="photoGateway" type="PhotoGateway" required="true" />
		<cfset variables.photoGateway = arguments.photoGateway />
	</cffunction>
	<cffunction name="getPhotoGateway" access="public" output="false" returntype="PhotoGateway">
		<cfreturn variables.photoGateway />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getPhotoBean" access="public" output="false" returntype="Photo">
		<cfreturn createObject("component", "Photo").init() />
	</cffunction>
	<cffunction name="getPhotos" access="public" output="false" returntype="query">
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		
		<cfreturn getPhotoGateway().getPhotos(arguments.activeOnly) />
	</cffunction>
	<cffunction name="getPhotoByID" access="public" output="false" returntype="Photo">
		<cfargument name="photoID" type="string" required="true" />
		
		<cfset var photo = getPhotoBean() />
		<cfset photo.setPhotoID(arguments.photoID) />
		
		<cfif arguments.photoID is not "">
			<cfset getPhotoDAO().fetch(photo) />
		</cfif>
		
		<cfreturn photo />
	</cffunction>
	<cffunction name="getPhotosByPhotoAlbumID" access="public" output="false" returntype="query" 
			hint="Returns a query object containing photos for a particular photo album">
		<cfargument name="photoAlbumID" type="uuid" required="true" />
		<cfreturn getPhotoGateway().getPhotosByPhotoAlbumID(arguments.photoAlbumID) />
	</cffunction>
	
	<cffunction name="savePhoto" access="public" output="false" returntype="void">
		<cfargument name="photo" type="Photo" required="true" />
		
		<cfset getPhotoDAO().save(arguments.photo) />
	</cffunction>
	
	<cffunction name="deletePhoto" access="public" output="false" returntype="void">
		<cfargument name="photo" type="Photo" required="true" />
		
		<cfset getPhotoDAO().delete(arguments.photo) />
	</cffunction>
</cfcomponent>