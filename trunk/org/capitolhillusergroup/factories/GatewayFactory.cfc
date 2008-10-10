<cfcomponent 
	displayname="GatewayFactory" 
	output="false" 
	hint="Gateway Factory">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" output="false" returntype="GatewayFactory">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setDatasource" access="public" output="false" returntype="void">
		<cfargument name="datasource" type="org.capitolhillusergroup.datasource.Datasource" required="true" />
		<cfset variables.datasource = arguments.datasource />
	</cffunction>
	<cffunction name="getDatasource" access="public" output="false" returntype="org.capitolhillusergroup.datasource.Datasource">
		<cfreturn variables.datasource />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getAddressGateway" access="public" output="false" returntype="org.capitolhillusergroup.address.AddressGateway">
		<cfset var addressGateway = CreateObject("component", "org.capitolhillusergroup.address.AddressGateway_" & getDatasource().getDBType()).init() />
		<cfreturn addressGateway />
	</cffunction>
	<cffunction name="setAddressGateway" access="public" output="false" returntype="void">
		<cfargument name="aggregatorGateway" type="org.capitolhillusergroup.address.AddressGateway" required="true" />
		<cfset variables.addressGateway = arguments.addressGateway />
	</cffunction>
	
	<cffunction name="setArticleGateway" access="public" output="false" returntype="void">
		<cfargument name="articleGateway" type="org.capitolhillusergroup.article.ArticleGateway" required="true" />
		<cfset variables.articleGateway = arguments.articleGateway />
	</cffunction>
	<cffunction name="getArticleGateway" access="public" output="false" returntype="org.capitolhillusergroup.article.ArticleGateway">
		<cfset var articleGateway = createObject("component", "org.capitolhillusergroup.article.ArticleGateway_" & getDatasource().getDBType()).init() />
		<cfreturn articleGateway />
	</cffunction>
	
	<cffunction name="setBoardPositionGateway" access="public" output="false" returntype="void">
		<cfargument name="boardPositionGateway" type="org.capitolhillusergroup.boardposition.BoardPositionGateway" required="true" />
		<cfset variables.boardPositionGateway = arguments.boardPositionGateway />
	</cffunction>
	<cffunction name="getBoardPositionGateway" access="public" output="false" returntype="org.capitolhillusergroup.boardposition.BoardPositionGateway">
		<cfset var boardPositionGateway = createObject("component", "org.capitolhillusergroup.boardposition.BoardPositionGateway_" & getDatasource().getDBType()).init() />
		<cfreturn boardPositionGateway />
	</cffunction>

	<cffunction name="setBookGateway" access="public" output="false" returntype="void">
		<cfargument name="bookGateway" type="org.capitolhillusergroup.book.BookGateway" required="true" />
		<cfset variables.bookGateway = arguments.bookGateway />
	</cffunction>
	<cffunction name="getBookGateway" access="public" output="false" returntype="org.capitolhillusergroup.book.BookGateway">
		<cfset var bookGateway = createObject("component", "org.capitolhillusergroup.book.BookGateway_" & getDatasource().getDBType()).init() />
		<cfreturn bookGateway />
	</cffunction>

	<cffunction name="setCategoryGateway" access="public" output="false" returntype="void">
		<cfargument name="categoryGateway" type="org.capitolhillusergroup.category.CategoryGateway" required="true" />
		<cfset variables.categoryGateway = arguments.categoryGateway />
	</cffunction>
	<cffunction name="getCategoryGateway" access="public" output="false" returntype="org.capitolhillusergroup.category.CategoryGateway">
		<cfset var categoryGateway = createObject("component", "org.capitolhillusergroup.category.CategoryGateway_" & getDatasource().getDBType()).init() />
		<cfreturn categoryGateway />
	</cffunction>

	<cffunction name="setFileTypeGateway" access="public" output="false" returntype="void">
		<cfargument name="fileTypeGateway" type="org.capitolhillusergroup.filetype.FileTypeGateway" required="true" />
		<cfset variables.fileTypeGateway = arguments.fileTypeGateway />
	</cffunction>
	<cffunction name="getFileTypeGateway" access="public" output="false" returntype="org.capitolhillusergroup.filetype.FileTypeGateway">
		<cfset var fileTypeGateway = createObject("component", "org.capitolhillusergroup.filetype.FileTypeGateway_" & getDatasource().getDBType()).init() />
		<cfreturn fileTypeGateway />
	</cffunction>

	<cffunction name="setIMGateway" access="public" output="false" returntype="void">
		<cfargument name="imGateway" type="org.capitolhillusergroup.im.IMGateway" required="true" />
		<cfset variables.imGateway = arguments.imGateway />
	</cffunction>
	<cffunction name="getIMGateway" access="public" output="false" returntype="org.capitolhillusergroup.im.IMGateway">
		<cfset var imGateway = createObject("component", "org.capitolhillusergroup.im.IMGateway_" & getDatasource().getDBType()).init() />
		<cfreturn imGateway />
	</cffunction>

	<cffunction name="setIMTypeGateway" access="public" output="false" returntype="void">
		<cfargument name="imTypeGateway" type="org.capitolhillusergroup.imtype.IMTypeGateway" required="true" />
		<cfset variables.imTypeGateway = arguments.imTypeGateway />
	</cffunction>
	<cffunction name="getIMTypeGateway" access="public" output="false" returntype="org.capitolhillusergroup.imtype.IMTypeGateway">
		<cfset var imTypeGateway = createObject("component", "org.capitolhillusergroup.imtype.IMTypeGateway_" & getDatasource().getDBType()).init() />
		<cfreturn imTypeGateway />
	</cffunction>

	<cffunction name="setLocationGateway" access="public" output="false" returntype="void">
		<cfargument name="locationGateway" type="org.capitolhillusergroup.location.LocationGateway" required="true" />
		<cfset variables.locationGateway = arguments.locationGateway />
	</cffunction>
	<cffunction name="getLocationGateway" access="public" output="false" returntype="org.capitolhillusergroup.location.LocationGateway">
		<cfset var locationGateway = createObject("component", "org.capitolhillusergroup.location.LocationGateway_" & getDatasource().getDBType()).init() />
		<cfreturn locationGateway />
	</cffunction>

	<cffunction name="setMeetingGateway" access="public" output="false" returntype="void">
		<cfargument name="meetingGateway" type="org.capitolhillusergroup.meeting.MeetingGateway" required="true" />
		<cfset variables.meetingGateway = arguments.meetingGateway />
	</cffunction>
	<cffunction name="getMeetingGateway" access="public" output="false" returntype="org.capitolhillusergroup.meeting.MeetingGateway">
		<cfset var meetingGateway = createObject("component", "org.capitolhillusergroup.meeting.MeetingGateway_" & getDatasource().getDBType()).init() />
		<cfreturn meetingGateway />
	</cffunction>

	<cffunction name="setNewsGateway" access="public" output="false" returntype="void">
		<cfargument name="newsGateway" type="org.capitolhillusergroup.news.NewsGateway" required="true" />
		<cfset variables.newsGateway = arguments.newsGateway />
	</cffunction>
	<cffunction name="getNewsGateway" access="public" output="false" returntype="org.capitolhillusergroup.news.NewsGateway">
		<cfset var newsGateway = createObject("component", "org.capitolhillusergroup.news.NewsGateway_" & getDatasource().getDBType()).init() />
		<cfreturn newsGateway />
	</cffunction>

	<cffunction name="setOrganizationGateway" access="public" output="false" returntype="void">
		<cfargument name="organizationGateway" type="org.capitolhillusergroup.organization.OrganizationGateway" required="true" />
		<cfset variables.organizationGateway = arguments.organizationGateway />
	</cffunction>
	<cffunction name="getOrganizationGateway" access="public" output="false" returntype="org.capitolhillusergroup.organization.OrganizationGateway">
		<cfset var organizationGateway = createObject("component", "org.capitolhillusergroup.organization.OrganizationGateway_" & getDatasource().getDBType()).init() />
		<cfreturn organizationGateway />
	</cffunction>

	<cffunction name="setPersonGateway" access="public" output="false" returntype="void">
		<cfargument name="personGateway" type="org.capitolhillusergroup.person.PersonGateway" required="true" />
		<cfset variables.personGateway = arguments.personGateway />
	</cffunction>
	<cffunction name="getPersonGateway" access="public" output="false" returntype="org.capitolhillusergroup.person.PersonGateway">
		<cfset var personGateway = createObject("component", "org.capitolhillusergroup.person.PersonGateway_" & getDatasource().getDBType()).init() />
		<cfreturn personGateway />
	</cffunction>

	<cffunction name="setPhotoGateway" access="public" output="false" returntype="void">
		<cfargument name="photoGateway" type="org.capitolhillusergroup.photo.PhotoGateway" required="true" />
		<cfset variables.photoGateway = arguments.photoGateway />
	</cffunction>
	<cffunction name="getPhotoGateway" access="public" output="false" returntype="org.capitolhillusergroup.photo.PhotoGateway">
		<cfset var photoGateway = createObject("component", "org.capitolhillusergroup.photo.PhotoGateway_" & getDatasource().getDBType()).init() />
		<cfreturn photoGateway />
	</cffunction>

	<cffunction name="setPhotoAlbumGateway" access="public" output="false" returntype="void">
		<cfargument name="photoAlbumGateway" type="org.capitolhillusergroup.photoalbum.PhotoAlbumGateway" required="true" />
		<cfset variables.photoAlbumGateway = arguments.photoAlbumGateway />
	</cffunction>
	<cffunction name="getPhotoAlbumGateway" access="public" output="false" returntype="org.capitolhillusergroup.photoalbum.PhotoAlbumGateway">
		<cfset var photoAlbumGateway = createObject("component", "org.capitolhillusergroup.photoalbum.PhotoAlbumGateway_" & getDatasource().getDBType()).init() />
		<cfreturn photoAlbumGateway />
	</cffunction>

	<cffunction name="setPresentationGateway" access="public" output="false" returntype="void">
		<cfargument name="presentationGateway" type="org.capitolhillusergroup.presentation.PresentationGateway" required="true" />
		<cfset variables.presentationGateway = arguments.presentationGateway />
	</cffunction>
	<cffunction name="getPresentationGateway" access="public" output="false" returntype="org.capitolhillusergroup.presentation.PresentationGateway">
		<cfset var presentationGateway = createObject("component", "org.capitolhillusergroup.presentation.PresentationGateway_" & getDatasource().getDBType()).init() />
		<cfreturn presentationGateway />
	</cffunction>

	<cffunction name="setPresentationFileGateway" access="public" output="false" returntype="void">
		<cfargument name="presentationFileGateway" type="org.capitolhillusergroup.presentationfile.PresentationFileGateway" required="true" />
		<cfset variables.presentationFileGateway = arguments.presentationFileGateway />
	</cffunction>
	<cffunction name="getPresentationFileGateway" access="public" output="false" returntype="org.capitolhillusergroup.presentationfile.PresentationFileGateway">
		<cfset var presentationFileGateway = createObject("component", "org.capitolhillusergroup.presentationfile.PresentationFileGateway_" & getDatasource().getDBType()).init() />
		<cfreturn presentationFileGateway />
	</cffunction>

	<cffunction name="setRoleGateway" access="public" output="false" returntype="void">
		<cfargument name="roleGateway" type="org.capitolhillusergroup.role.RoleGateway" required="true" />
		<cfset variables.roleGateway = arguments.roleGateway />
	</cffunction>
	<cffunction name="getRoleGateway" access="public" output="false" returntype="org.capitolhillusergroup.role.RoleGateway">
		<cfset var roleGateway = createObject("component", "org.capitolhillusergroup.role.RoleGateway_" & getDatasource().getDBType()).init() />
		<cfreturn roleGateway />
	</cffunction>

	<cffunction name="setRSVPGateway" access="public" output="false" returntype="void">
		<cfargument name="rsvpGateway" type="org.capitolhillusergroup.rsvp.RSVPGateway" required="true" />
		<cfset variables.rsvpGateway = arguments.rsvpGateway />
	</cffunction>
	<cffunction name="getRSVPGateway" access="public" output="false" returntype="org.capitolhillusergroup.rsvp.RSVPGateway">
		<cfset var rsvpGateway = createObject("component", "org.capitolhillusergroup.rsvp.RSVPGateway_" & getDatasource().getDBType()).init() />
		<cfreturn rsvpGateway />
	</cffunction>

</cfcomponent>