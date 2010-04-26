<cfcomponent 
	displayname="DAOFactory" 
	output="false" 
	hint="DAO Factory">

	<!---
	INITIALIZATION / CONFIGURATION
	--->	
	<cffunction name="init" access="public" output="false" returntype="DAOFactory">
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
	<cffunction name="setAddressDAO" access="public" output="false" returntype="void">
		<cfargument name="addressDAO" type="org.capitolhillusergroup.address.AddressDAO" required="true" />
		<cfset variables.addressDAO = arguments.addressDAO />
	</cffunction>
	<cffunction name="getAddressDAO" access="public" output="false" returntype="org.capitolhillusergroup.address.AddressDAO">
		<cfset var addressDAO = createObject("component", "org.capitolhillusergroup.address.AddressDAO_" & getDatasource().getDBType()).init() />
		<cfreturn addressDAO />
	</cffunction>

	<cffunction name="setArticleDAO" access="public" output="false" returntype="void">
		<cfargument name="articleDAO" type="org.capitolhillusergroup.article.ArticleDAO" required="true" />
		<cfset variables.articleDAO = arguments.articleDAO />
	</cffunction>
	<cffunction name="getArticleDAO" access="public" output="false" returntype="org.capitolhillusergroup.article.ArticleDAO">
		<cfset var articleDAO = createObject("component", "org.capitolhillusergroup.article.ArticleDAO_" & getDatasource().getDBType()).init() />
		<cfreturn articleDAO />
	</cffunction>
	
	<cffunction name="setBoardPositionDAO" access="public" output="false" returntype="void">
		<cfargument name="boardPositionDAO" type="org.capitolhillusergroup.boardposition.BoardPositionDAO" required="true" />
		<cfset variables.boardPositionDAO = arguments.boardPositionDAO />
	</cffunction>
	<cffunction name="getBoardPositionDAO" access="public" output="false" returntype="org.capitolhillusergroup.boardposition.BoardPositionDAO">
		<cfset var boardPositionDAO = createObject("component", "org.capitolhillusergroup.boardposition.BoardPositionDAO_" & getDatasource().getDBType()).init() />
		<cfreturn boardPositionDAO />
	</cffunction>
	
	<cffunction name="setBookDAO" access="public" output="false" returntype="void">
		<cfargument name="bookDAO" type="org.capitolhillusergroup.book.BookDAO" required="true" />
		<cfset variables.bookDAO = arguments.bookDAO />
	</cffunction>
	<cffunction name="getBookDAO" access="public" output="false" returntype="org.capitolhillusergroup.book.BookDAO">
		<cfset var bookDAO = createObject("component", "org.capitolhillusergroup.book.BookDAO_" & getDatasource().getDBType()).init() />
		<cfreturn bookDAO />
	</cffunction>
	
	<cffunction name="setCategoryDAO" access="public" output="false" returntype="void">
		<cfargument name="categoryDAO" type="org.capitolhillusergroup.category.CategoryDAO" required="true" />
		<cfset variables.categoryDAO = arguments.categoryDAO />
	</cffunction>
	<cffunction name="getCategoryDAO" access="public" output="false" returntype="org.capitolhillusergroup.category.CategoryDAO">
		<cfset var categoryDAO = createObject("component", "org.capitolhillusergroup.category.CategoryDAO_" & getDatasource().getDBType()).init() />
		<cfreturn categoryDAO />
	</cffunction>
	
	<cffunction name="setFileTypeDAO" access="public" output="false" returntype="void">
		<cfargument name="fileTypeDAO" type="org.capitolhillusergroup.filetype.FileTypeDAO" required="true" />
		<cfset variables.fileTypeDAO = arguments.fileTypeDAO />
	</cffunction>
	<cffunction name="getFileTypeDAO" access="public" output="false" returntype="org.capitolhillusergroup.filetype.FileTypeDAO">
		<cfset var fileTypeDAO = createObject("component", "org.capitolhillusergroup.filetype.FileTypeDAO_" & getDatasource().getDBType()).init() />
		<cfreturn fileTypeDAO />
	</cffunction>
	
	<cffunction name="setIMTypeDAO" access="public" output="false" returntype="void">
		<cfargument name="imTypeDAO" type="org.capitolhillusergroup.imtype.IMTypeDAO" required="true" />
		<cfset variables.imTypeDAO = arguments.imTypeDAO />
	</cffunction>
	<cffunction name="getIMTypeDAO" access="public" output="false" returntype="org.capitolhillusergroup.imtype.IMTypeDAO">
		<cfset var imTypeDAO = createObject("component", "org.capitolhillusergroup.imtype.IMTypeDAO_" & getDatasource().getDBType()).init() />
		<cfreturn imTypeDAO />
	</cffunction>
	
	<cffunction name="setLocationDAO" access="public" output="false" returntype="void">
		<cfargument name="locationDAO" type="org.capitolhillusergroup.location.LocationDAO" required="true" />
		<cfset variables.locationDAO = arguments.locationDAO />
	</cffunction>
	<cffunction name="getLocationDAO" access="public" output="false" returntype="org.capitolhillusergroup.location.LocationDAO">
		<cfset var locationDAO = createObject("component", "org.capitolhillusergroup.location.LocationDAO_" & getDatasource().getDBType()).init() />
		<cfreturn locationDAO />
	</cffunction>
	
	<cffunction name="setMeetingDAO" access="public" output="false" returntype="void">
		<cfargument name="meetingDAO" type="org.capitolhillusergroup.meeting.MeetingDAO" required="true" />
		<cfset variables.meetingDAO = arguments.meetingDAO />
	</cffunction>
	<cffunction name="getMeetingDAO" access="public" output="false" returntype="org.capitolhillusergroup.meeting.MeetingDAO">
		<cfset var meetingDAO = createObject("component", "org.capitolhillusergroup.meeting.MeetingDAO_" & getDatasource().getDBType()).init() />
		<cfreturn meetingDAO />
	</cffunction>
	
	<cffunction name="setNewsDAO" access="public" output="false" returntype="void">
		<cfargument name="newsDAO" type="org.capitolhillusergroup.news.NewsDAO" required="true" />
		<cfset variables.newsDAO = arguments.newsDAO />
	</cffunction>
	<cffunction name="getNewsDAO" access="public" output="false" returntype="org.capitolhillusergroup.news.NewsDAO">
		<cfset var newsDAO = createObject("component", "org.capitolhillusergroup.news.NewsDAO_" & getDatasource().getDBType()).init() />
		<cfreturn newsDAO />
	</cffunction>
	
	<cffunction name="setOrganizationDAO" access="public" output="false" returntype="void">
		<cfargument name="organizationDAO" type="org.capitolhillusergroup.organization.OrganizationDAO" required="true" />
		<cfset variables.organizationDAO = arguments.organizationDAO />
	</cffunction>
	<cffunction name="getOrganizationDAO" access="public" output="false" returntype="org.capitolhillusergroup.organization.OrganizationDAO">
		<cfset var organizationDAO = createObject("component", "org.capitolhillusergroup.organization.OrganizationDAO_" & getDatasource().getDBType()).init() />
		<cfreturn organizationDAO />
	</cffunction>
	
	<cffunction name="setPersonDAO" access="public" output="false" returntype="void">
		<cfargument name="personDAO" type="org.capitolhillusergroup.person.PersonDAO" required="true" />
		<cfset variables.personDAO = arguments.personDAO />
	</cffunction>
	<cffunction name="getPersonDAO" access="public" output="false" returntype="org.capitolhillusergroup.person.PersonDAO">
		<cfset var personDAO = createObject("component", "org.capitolhillusergroup.person.PersonDAO_" & getDatasource().getDBType()).init() />
		<cfreturn personDAO />
	</cffunction>
	
	<cffunction name="setPhotoDAO" access="public" output="false" returntype="void">
		<cfargument name="photoDAO" type="org.capitolhillusergroup.photo.PhotoDAO" required="true" />
		<cfset variables.photoDAO = arguments.photoDAO />
	</cffunction>
	<cffunction name="getPhotoDAO" access="public" output="false" returntype="org.capitolhillusergroup.photo.PhotoDAO">
		<cfset var photoDAO = createObject("component", "org.capitolhillusergroup.photo.PhotoDAO_" & getDatasource().getDBType()).init() />
		<cfreturn photoDAO />
	</cffunction>
	
	<cffunction name="setPhotoAlbumDAO" access="public" output="false" returntype="void">
		<cfargument name="photoAlbumDAO" type="org.capitolhillusergroup.photoalbum.PhotoAlbumDAO" required="true" />
		<cfset variables.photoAlbumDAO = arguments.photoAlbumDAO />
	</cffunction>
	<cffunction name="getPhotoAlbumDAO" access="public" output="false" returntype="org.capitolhillusergroup.photoalbum.PhotoAlbumDAO">
		<cfset var photoAlbumDAO = createObject("component", "org.capitolhillusergroup.photoalbum.PhotoAlbumDAO_" & getDatasource().getDBType()).init() />
		<cfreturn photoAlbumDAO />
	</cffunction>
	
	<cffunction name="setPresentationDAO" access="public" output="false" returntype="void">
		<cfargument name="presentationDAO" type="org.capitolhillusergroup.presentation.PresentationDAO" required="true" />
		<cfset variables.presentationDAO = arguments.presentationDAO />
	</cffunction>
	<cffunction name="getPresentationDAO" access="public" output="false" returntype="org.capitolhillusergroup.presentation.PresentationDAO">
		<cfset var presentationDAO = createObject("component", "org.capitolhillusergroup.presentation.PresentationDAO_" & getDatasource().getDBType()).init() />
		<cfreturn presentationDAO />
	</cffunction>
	
	<cffunction name="setPresentationFileDAO" access="public" output="false" returntype="void">
		<cfargument name="presentationFileDAO" type="org.capitolhillusergroup.presentationfile.PresentationFileDAO" required="true" />
		<cfset variables.presentationFileDAO = arguments.presentationFileDAO />
	</cffunction>
	<cffunction name="getPresentationFileDAO" access="public" output="false" returntype="org.capitolhillusergroup.presentationfile.PresentationFileDAO">
		<cfset var presentationFileDAO = createObject("component", "org.capitolhillusergroup.presentationfile.PresentationFileDAO_" & getDatasource().getDBType()).init() />
		<cfreturn presentationFileDAO />
	</cffunction>
	
	<cffunction name="setRoleDAO" access="public" output="false" returntype="void">
		<cfargument name="roleDAO" type="org.capitolhillusergroup.role.RoleDAO" required="true" />
		<cfset variables.roleDAO = arguments.roleDAO />
	</cffunction>
	<cffunction name="getRoleDAO" access="public" output="false" returntype="org.capitolhillusergroup.role.RoleDAO">
		<cfset var roleDAO = createObject("component", "org.capitolhillusergroup.role.RoleDAO_" & getDatasource().getDBType()).init() />
		<cfreturn roleDAO />
	</cffunction>
	
	<cffunction name="setRSVPDAO" access="public" output="false" returntype="void">
		<cfargument name="rsvpDAO" type="org.capitolhillusergroup.rsvp.RSVPDAO" required="true" />
		<cfset variables.rsvpDAO = arguments.rsvpDAO />
	</cffunction>
	<cffunction name="getRSVPDAO" access="public" output="false" returntype="org.capitolhillusergroup.rsvp.RSVPDAO">
		<cfset var rsvpDAO = createObject("component", "org.capitolhillusergroup.rsvp.RSVPDAO_" & getDatasource().getDBType()).init() />
		<cfreturn rsvpDAO />
	</cffunction>
	
</cfcomponent>