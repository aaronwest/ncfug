<!-- <cfsetting enablecfoutputonly="true" /> -->
<mach-ii version="1.0">

	<!-- PROPERTIES -->
	<properties>
		<!-- mach-ii required -->
		<property name="applicationRoot" value="/" />
		<property name="defaultEvent" value="home" />
		<property name="eventParameter" value="go" />
		<property name="parameterPrecedence" value="form" />
		<property name="maxEvents" value="10" />
		<property name="exceptionEvent" value="exceptionEvent" />
		<!-- application specific -->
		<property name="dsn" value="ncfug" />
		<property name="dbType" value="MySQL" />
		<property name="dbUserName" value="ncfug" />
		<property name="dbPassword" value="8KrJM9qE" />
		<!--- <property name="dbUserName" value="root" />
		<property name="dbPassword" value="" /> --->
		<property name="dbVersion" value="0.1" />
		
		<property name="devMode" value="false" />
		<property name="numPreviousMeetingItems" value="4" />
		<property name="numUpcomingMeetingItems" value="1" />
		<property name="numPublicNewsItems" value="3" />
		<property name="siteName" value="Nashville ColdFusion User Group" />
		<property name="adminEmail" value="a.west@me.com" />
		<property name="contactName" value="Aaron West" />
		<property name="contactEmail" value="a.west@me.com" />
		<property name="notificationFromAddress" value="info@ncfug.com" />
		<property name="baseURL" value="http://www.ncfug.com/" />
		<property name="personImageFilePath" value="uploads/personImages/" />
		<property name="presentationFilePath" value="uploads/presentations/" />
		<property name="temporaryFilePath" value="uploads/temp/" />
		<property name="skin" value="ncfug" />
		<property name="rbFile" value="/i18n/main" />
		<property name="rbLocale" value="en_US" />
		<property name="copyrightNotice" value="Copyright © 2008 Nashville ColdFusion User Group" />
		<property name="defaultState" value="TN" />
		<property name="defaultStateName" value="Tennessee" />
		<property name="defaultCountry" value="US" />
		<property name="defaultCountryName" value="United States" />
		<!-- mail/server config related -->
		<property name="mailServer" value="localhost" />
		<!-- coldspring related -->
		<property name="coldspringConfigFile" value="config/services.xml"/>
		<!-- Wysiwyg related -->
		<property name="useWysiwygEditor" value="true" />
		<property name="wysiwygEditor" value="FCKeditor" />
		<!-- Captcha related -->
		<property name="captchaConfigFile" value="config/captcha.xml"/>
		<property name="useCaptcha" value="false" />
		<property name="captchaType" value="file"/><!-- stream/file -->
		<!-- Google Related -->
		<!-- This Google Analytics ID is tied to Aaron's global account. -->
		<property name="googleAnalyticsUAccount" value="UA-3548918-3" />
		<!-- SES URL Settings. These are needed for <redirect> events to work properly. -->
		<property name="urlParseSES" value="true" />
		<property name="urlDelimiters" value="/|/|/" />
		<property name="urlBase" value="http://www.ncfug.com" />
		
		<!-- Homepage CategoryID -->
		<!-- <property name="homepageCategoryID" value="26BFCADF-0A33-6FFF-1ADD6B5B98948EC2" /> -->
	</properties>

	<!-- PLUGINS -->
	<plugins>
		<plugin name="coldspringPlugin" type="coldspring.machii.ColdspringPlugin">
			<parameters>
				<parameter name="beanFactoryPropertyName" value="serviceFactory"/>
				<parameter name="configFilePropertyName" value="coldspringConfigFile"/>
				<parameter name="configFilePathIsRelative" value="true"/>
				<parameter name="resolveMachiiDependencies" value="true"/>
			</parameters>
		</plugin>
		<plugin name="appVars" type="org.capitolhillusergroup.plugins.AppVars" />
		<plugin name="checkAuthentication" type="org.capitolhillusergroup.plugins.CheckAuthentication" />
		<!--<plugin name="tracePlugin" type="MachII.plugins.TracePlugin" />-->
	</plugins>
	
	<!-- EVENT-FILTERS -->
	<event-filters>
	</event-filters>

	<!-- LISTENERS -->
	<listeners>
		<listener name="addressListener" type="org.capitolhillusergroup.listeners.AddressListener" />
		<listener name="articleListener" type="org.capitolhillusergroup.listeners.ArticleListener" />
		<listener name="boardPositionListener" type="org.capitolhillusergroup.listeners.BoardPositionListener" />
		<listener name="bookListener" type="org.capitolhillusergroup.listeners.BookListener" />
		<listener name="captchaListener" type="org.capitolhillusergroup.listeners.CaptchaListener"/>
		<listener name="categoryListener" type="org.capitolhillusergroup.listeners.CategoryListener" />
		<listener name="contactListener" type="org.capitolhillusergroup.listeners.ContactListener" />
		<listener name="fileTypeListener" type="org.capitolhillusergroup.listeners.FileTypeListener" />
		<listener name="imTypeListener" type="org.capitolhillusergroup.listeners.IMTypeListener" />
		<listener name="locationListener" type="org.capitolhillusergroup.listeners.LocationListener" />
		<listener name="meetingListener" type="org.capitolhillusergroup.listeners.MeetingListener" />
		<listener name="newsListener" type="org.capitolhillusergroup.listeners.NewsListener" />
		<listener name="organizationListener" type="org.capitolhillusergroup.listeners.OrganizationListener" />
		<listener name="personListener" type="org.capitolhillusergroup.listeners.PersonListener" />
		<listener name="photoAlbumListener" type="org.capitolhillusergroup.listeners.PhotoAlbumListener" />
		<listener name="photoListener" type="org.capitolhillusergroup.listeners.PhotoListener" />
		<listener name="presentationListener" type="org.capitolhillusergroup.listeners.PresentationListener" />
		<listener name="roleListener" type="org.capitolhillusergroup.listeners.RoleListener" />
		<listener name="rsvpListener" type="org.capitolhillusergroup.listeners.RSVPListener" />
		<listener name="securityListener" type="org.capitolhillusergroup.listeners.SecurityListener" />
	</listeners>
	
	<!-- EVENT-HANDLERS -->
	<event-handlers>
	
		<!-- THANKYOU -->
		<event-handler event="thankyou" access="public">
			<view-page name="thankyou" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="thankyou_redirect" access="private">
			<redirect event="thankyou" args="message" />
		</event-handler>
		
		<!-- PENDING -->
		<event-handler event="pending" access="public">
			<view-page name="pending" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="pending_redirect" access="private">
			<redirect event="pending" args="message" />
		</event-handler>
	
		<!-- RSVP -->
		<event-handler event="rsvpform" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="captchaListener" method="getHashReference" resultArg="captcha"/>
			<notify listener="meetingListener" method="getMeetingByID" resultArg="meeting" />
			<notify listener="rsvpListener" method="getRSVPByID" resultArg="rsvp" />
			<view-page name="captchaSnip" contentArg="captchaSnip" />
			<view-page name="rsvpForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="rsvpform_error" access="private">
			<event-arg name="includeqForms" value="true" />
			<notify listener="captchaListener" method="getHashReference" resultArg="captcha"/>
			<notify listener="meetingListener" method="getMeetingByID" resultArg="meeting" />
			<notify listener="rsvpListener" method="getRSVPByID" resultArg="rsvp" />
			<view-page name="captchaSnip" contentArg="captchaSnip" />
			<view-page name="rsvpForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="rsvpform_redirect" access="private">
			<redirect event="rsvpform" args="message,meetingID" />
		</event-handler>
		
		<event-handler event="processRSVPForm" access="public">
			<event-mapping event="success" mapping="thankyou_redirect" />
			<event-mapping event="failure" mapping="rsvpform_error" />
			<event-bean name="rsvp" type="org.capitolhillusergroup.rsvp.RSVP" fields="rsvpID,meetingID,personID,firstName,lastName,email,comments" />
			<notify listener="captchaListener" method="validateCaptcha" />
			<notify listener="rsvpListener" method="processRSVPForm" />
		</event-handler>
		
		<!-- LAYOUT -->
		<event-handler event="mainLayout" access="private">
			<event-arg name="activeOnly" value="true" />
			<notify listener="newsListener" method="getNews" resultArg="news" />
			<notify listener="meetingListener" method="getUpcomingMeetings" resultArg="upcomingMeetings" />
			<notify listener="meetingListener" method="getPreviousMeetings" resultArg="previousMeetings" />
			<view-page name="mainLayout" />
		</event-handler>
		
		<!-- CAPTCHA -->
		<event-handler event="captcha.displayImage" access="public">
			<notify listener="captchaListener" method="createCaptchaFromHashReference" resultArg="captcha" />
			<view-page name="captcha.displayImage"/>
		</event-handler>
		
		<!-- LOGIN -->
		<event-handler event="login" access="public">
			<event-arg name="includeqForms" value="true" />
			<view-page name="login" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="login_redirect" access="private">
			<redirect event="login" args="message" />
		</event-handler>
		
		<event-handler event="logout" access="public">
			<notify listener="securityListener" method="logout" />
			<redirect event="home" args="message" />
		</event-handler>
		
		<event-handler event="processLoginForm" access="public">
			<event-mapping event="failure" mapping="login_redirect" />
			<notify listener="securityListener" method="validateLoginAttempt" />
		</event-handler>
		
		<!-- FORGOT PASSWORD -->
		<event-handler event="forgotpassword" access="public">
			<event-arg name="includeqForms" value="true" />
			<view-page name="forgotPassword" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="forgotpassword_redirect" access="public">
			<redirect event="forgotpassword" args="message" />
		</event-handler>
		
		<event-handler event="processForgotPassword" access="public">
			<event-mapping event="success" mapping="forgotpassword_redirect" />
			<event-mapping event="failure" mapping="forgotpassword" />
			<notify listener="securityListener" method="processForgotPassword" />
		</event-handler>
		
		<!-- BOARD MEMBERS -->
		<event-handler event="board" access="public">
			<notify listener="boardPositionListener" method="getBoardMembers" resultArg="boardMembers" />
			<view-page name="board" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<!-- CONTACT -->
		<event-handler event="contact" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="captchaListener" method="getHashReference" resultArg="captcha"/>
			<view-page name="captchaSnip" contentArg="captchaSnip" />
			<view-page name="contactForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="contact_redirect" access="private">
			<redirect event="contact" args="message" />
		</event-handler>

		<event-handler event="processContactForm" access="public">
			<event-mapping event="success" mapping="thankyou_redirect" />
			<event-mapping event="failure" mapping="contact" />
			<event-bean name="contact" type="org.capitolhillusergroup.contact.Contact" fields="name,email,reason,comments" />
			<notify listener="captchaListener" method="validateCaptcha" />
			<notify listener="contactListener" method="processContactForm" />
		</event-handler>
		
		<!-- HOME -->
		<event-handler event="home" access="public">
			<event-arg name="activeOnly" value="true" />
			<notify listener="articleListener" method="getHomePageArticles" resultArg="welcome" />
			<notify listener="meetingListener" method="getUpcomingMeetings" resultArg="upcomingMeetings" />
			<view-page name="home" contentArg="content" />
			<view-page name="sidebar" contentArg="sidebar" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<!-- MEETINGS -->
		<event-handler event="meeting" access="public">
			<notify listener="meetingListener" method="getMeetingByID" resultArg="meeting" />
			<view-page name="meeting" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="meetings" access="public">
			<notify listener="meetingListener" method="getActiveMeetingsAsArray" resultArg="meetings" />
			<view-page name="meetings" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<!-- NEWS -->
		<event-handler event="news" access="public">
			<event-arg name="activeOnly" value="true" />
			<event-arg name="numToGet" value="-1" />
			<notify listener="newsListener" method="getNews" resultArg="news" />
			<view-page name="news" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>

		<event-handler event="newsdetail" access="public">
			<notify listener="newsListener" method="getNewsByID" resultArg="news" />
			<view-page name="newsDetail" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<!-- ARTICLES -->
		<event-handler event="articles" access="public">
			<event-arg name="activeOnly" value="true" />
			<event-arg name="numToGet" value="-1" />
			<notify listener="articleListener" method="getArticlesAsArray" resultArg="articles" />
			<view-page name="articles" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="articledetail" access="public">
			<notify listener="articleListener" method="getArticleByID" resultArg="article" />
			<view-page name="articleDetail" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<!-- REGISTRATION -->
		<event-handler event="registrationform" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="organizationListener" method="getOrganizations" resultArg="organizations" />
			<notify listener="addressListener" method="getStates" resultArg="states" />
			<notify listener="addressListener" method="getCountries" resultArg="countries" />
			<notify listener="roleListener" method="getRoles" resultArg="roles" />
			<notify listener="imTypeListener" method="getIMTypes" resultArg="imTypes" />
			<notify listener="personListener" method="getPersonByID" resultArg="person" />
			<notify listener="captchaListener" method="getHashReference" resultArg="captcha"/>
			<view-page name="captchaSnip" contentArg="captchaSnip" />
			<view-page name="admin.personForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="registrationform_redirect" access="private">
			<redirect event="registrationform" args="message" />
		</event-handler>
		
		<event-handler event="registrationform_error" access="private">
			<event-arg name="includeqForms" value="true" />
			<notify listener="organizationListener" method="getOrganizations" resultArg="organizations" />
			<notify listener="addressListener" method="getStates" resultArg="states" />
			<notify listener="addressListener" method="getCountries" resultArg="countries" />
			<notify listener="roleListener" method="getRoles" resultArg="roles" />
			<notify listener="imTypeListener" method="getIMTypes" resultArg="imTypes" />
			<notify listener="personListener" method="getPersonByID" resultArg="person" />
			<notify listener="captchaListener" method="getHashReference" resultArg="captcha"/>
			<view-page name="captchaSnip" contentArg="captchaSnip" />
			<view-page name="admin.personForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="processRegistrationForm" access="public">
			<event-mapping event="success" mapping="pending_redirect" />
			<event-mapping event="failure" mapping="registrationform_error" />
			<event-bean name="person" type="org.capitolhillusergroup.person.Person" fields="personID,firstName,lastName,title,email,url,password,phone" />
			<event-bean name="address" type="org.capitolhillusergroup.address.Address" fields="addressID,address1,address2,city,stateID,postalCode,countryID" />
			<event-bean name="organization" type="org.capitolhillusergroup.organization.Organization" fields="organizationID" />
			<event-bean name="role" type="org.capitolhillusergroup.role.Role" fields="roleID" />
			<notify listener="captchaListener" method="validateCaptcha" />
			<notify listener="personListener" method="processRegistrationForm" />
		</event-handler>
		
		<!-- ADMIN EVENTS -->
		<!-- MAIN MENU -->
		<event-handler event="admin.showMainMenu" access="public">
			<view-page name="admin.mainMenu" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showMainMenu_redirect" access="private">
			<redirect event="admin.showMainMenu" args="message" />
		</event-handler>
		
		<!-- ARTICLES -->
		<event-handler event="admin.showArticleMenu" access="public">
			<event-arg name="activeOnly" value="false" />
			<notify listener="articleListener" method="getArticles" resultArg="articles" />
			<view-page name="admin.articleMenu" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showArticleMenu_redirect" access="private">
			<redirect event="admin.showArticleMenu" args="message" />
		</event-handler>
		
		<event-handler event="admin.showArticleForm" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="articleListener" method="getArticleByID" resultArg="article" />
			<notify listener="categoryListener" method="getCategories" resultArg="categories" />
			<notify listener="personListener" method="getActivePeople" resultArg="authors" />
			<view-page name="admin.articleForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.showArticleForm_error" access="public">
			<view-page name="admin.articleMenu" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.processArticleForm" access="public">
			<event-mapping event="success" mapping="admin.showArticleMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showArticleForm_error" />
			<event-bean name="article" type="org.capitolhillusergroup.article.Article" 
					fields="ArticleID,Title,Content,Authors,Categories" />
			<notify listener="articleListener" method="processArticleForm" />
		</event-handler>
		
		<event-handler event="admin.deleteArticle" access="public">
			<event-mapping event="exitEvent" mapping="admin.showArticleMenu_redirect" />
			<event-bean name="news" type="org.capitolhillusergroup.article.Article" fields="articleID" />
			<notify listener="articleListener" method="deleteArticle" />
		</event-handler>
		
		<!-- BOARD POSITIONS AND BOARD MEMBERS -->
		<event-handler event="admin.showBoardPositionMenu" access="public">
			<notify listener="boardPositionListener" method="getBoardPositions" resultArg="boardPositions" />
			<notify listener="boardPositionListener" method="getBoardMembers" resultArg="boardMembers" />
			<view-page name="admin.boardPositionMenu" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showBoardPositionMenu_redirect" access="private">
			<redirect event="admin.showBoardPositionMenu" args="message" />
		</event-handler>
		
		<event-handler event="admin.showBoardPositionForm" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="boardPositionListener" method="getBoardPositionByID" resultArg="boardPosition" />
			<notify listener="boardPositionListener" method="getBoardPositionCount" resultArg="boardPositionCount" />
			<view-page name="admin.boardPositionForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showBoardPositionForm_error" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="boardPositionListener" method="getBoardPositionCount" resultArg="boardPositionCount" />
			<view-page name="admin.boardPositionForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.processBoardPositionForm" access="public">
			<event-mapping event="success" mapping="admin.showBoardPositionMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showBoardPositionForm_error" />
			<event-bean name="boardPosition" type="org.capitolhillusergroup.boardposition.BoardPosition" 
					fields="boardPositionID,boardPosition,description,sortOrder" />
			<notify listener="boardPositionListener" method="processBoardPositionForm" />
		</event-handler>
		
		<event-handler event="admin.deleteBoardPosition" access="public">
			<event-mapping event="success" mapping="admin.showBoardPositionMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showBoardPositionMenu" />
			<notify listener="boardPositionListener" method="deleteBoardPosition" />
		</event-handler>
		
		<event-handler event="admin.showBoardMemberForm" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="boardPositionListener" method="getOpenBoardPositions" resultArg="boardPositions" />
			<notify listener="boardPositionListener" method="getNonBoardMembers" resultArg="members" />
			<view-page name="admin.boardMemberForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.processBoardMemberForm" access="public">
			<event-mapping event="success" mapping="admin.showBoardPositionMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showBoardMemberForm" />
			<notify listener="boardPositionListener" method="processBoardMemberForm" />
		</event-handler>
		
		<event-handler event="admin.deleteBoardMember" access="public">
			<event-mapping event="success" mapping="admin.showBoardPositionMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showBoardPositionMenu" />
			<notify listener="boardPositionListener" method="deleteBoardMember" />
		</event-handler>
		
		<!-- BOOKS -->
		<event-handler event="admin.showBookMenu" access="public">
			<event-arg name="activeOnly" value="false" />
			<notify listener="bookListener" method="getBooks" resultArg="books" />
			<view-page name="admin.bookMenu" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showBookMenu_redirect" access="private">
			<redirect event="admin.showBookMenu" args="message" />
		</event-handler>
		
		<event-handler event="admin.showBookForm" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="bookListener" method="getBookByID" resultArg="book" />
			<notify listener="categoryListener" method="getCategories" resultArg="categories" />
			<notify listener="personListener" method="getActivePeople" resultArg="authors" />
			<view-page name="admin.bookForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showBookForm_error" access="public">
			<view-page name="admin.bookForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>

		<event-handler event="admin.processBookForm" access="public">
			<event-mapping event="success" mapping="admin.showBookMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showBookForm_error" />
			<event-bean name="book" type="org.capitolhillusergroup.book.Book" 
					fields="bookID,title,publicationYear,isbn,numPages,price,url,authors,categories" />
			<notify listener="bookListener" method="processBookForm" />
		</event-handler>
		
		<event-handler event="admin.deleteBook" access="public">
			<event-mapping event="exitEvent" mapping="admin.showBookMenu_redirect" />
			<event-bean name="book" type="org.capitolhillusergroup.book.Book" fields="bookID" />
			<notify listener="bookListener" method="deleteBook" />
		</event-handler>
		
		<!-- CATEGORY -->
		<event-handler event="admin.showCategoryForm" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="categoryListener" method="getCategoryByID" resultArg="category" />
			<view-page name="admin.categoryForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showCategoryForm_error" access="public">
			<view-page name="admin.categoryForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.processCategoryForm" access="public">
			<event-mapping event="success" mapping="admin.showCategoryMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showCategoryForm_error" />
			<event-bean name="category" type="org.capitolhillusergroup.category.Category" 
					fields="categoryID,category" />
			<notify listener="categoryListener" method="processCategoryForm" />
		</event-handler>
		
		<event-handler event="admin.deleteCategory" access="public">
			<event-bean name="category" type="org.capitolhillusergroup.category.Category" 
					fields="categoryID" />
			<notify listener="categoryListener" method="deleteCategory" />
		</event-handler>
		
		<event-handler event="admin.showCategoryMenu" access="public">
			<event-arg name="activeOnly" value="false" />
			<notify listener="categoryListener" method="getCategories" resultArg="categories" />
			<view-page name="admin.categoryMenu" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showCategoryMenu_redirect" access="public">
			<redirect event="admin.showCategoryMenu" args="message" />
		</event-handler>
		
		<!-- IM TYPE -->
		<event-handler event="admin.showIMTypeMenu" access="public">
			<notify listener="imTypeListener" method="getIMTypes" resultArg="imTypes" />
			<view-page name="admin.imTypeMenu" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showIMTypeMenu_redirect" access="private">
			<redirect event="admin.showIMTypeMenu" args="message" />
		</event-handler>
		
		<event-handler event="admin.showIMTypeForm" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="imTypeListener" method="getIMTypeByID" resultArg="imType" />
			<view-page name="admin.imTypeForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showIMTypeForm_error" access="private">
			<event-arg name="includeqForms" value="true" />
			<view-page name="admin.imTypeForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.processIMTypeForm" access="public">
			<event-mapping event="success" mapping="admin.showIMTypeMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showIMTypeForm_error" />
			<event-bean name="imType" type="org.capitolhillusergroup.imtype.IMType" 
					fields="imTypeID,imType" />
			<notify listener="imTypeListener" method="processIMTypeForm" />
		</event-handler>
		
		<event-handler event="admin.deleteIMType" access="public">
			<event-mapping event="success" mapping="admin.showIMTypeMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showIMTypeMenu" />
			<notify listener="imTypeListener" method="deleteIMType" />
		</event-handler>
		
		<!-- LOCATIONS -->
		<event-handler event="admin.showLocationMenu" access="public">
			<notify listener="locationListener" method="getLocations" resultArg="locations" />
			<view-page name="admin.locationMenu" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.showLocationMenu_redirect" access="private">
			<redirect event="admin.showLocationMenu" args="message" />
		</event-handler>
		
		<event-handler event="admin.showLocationForm" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="addressListener" method="getStateAbbreviations" resultArg="states" />
			<notify listener="locationListener" method="getLocationByID" resultArg="location" />
			<view-page name="admin.locationForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.showLocationForm_error" access="private">
			<event-arg name="includeqForms" value="true" />
			<notify listener="addressListener" method="getStateAbbreviations" resultArg="states" />
			<view-page name="admin.locationForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.processLocationForm" access="public">
			<event-mapping event="success" mapping="admin.showLocationMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showLocationForm_error" />
			<event-bean name="location" type="org.capitolhillusergroup.location.Location" 
					fields="locationID,location,mapLink,description" />
			<event-bean name="address" type="org.capitolhillusergroup.address.Address" 
					fields="addressID,address1,address2,city,stateID,postalCode,countryID" />
			<notify listener="locationListener" method="processLocationForm" />
		</event-handler>
		
		<event-handler event="admin.deleteLocation" access="public">
			<event-mapping event="success" mapping="admin.showLocationMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showLocationMenu" />
			<notify listener="locationListener" method="deleteLocation" />
		</event-handler>
		
		<!-- COUNTRY -->
		<event-handler event="admin.showUploadCountriesForm" access="public">
			<event-arg name="includeqForms" value="true" />
			<view-page name="admin.uploadCountriesForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.processUploadCountriesForm" access="public">
			<event-mapping event="success" mapping="admin.showLocationMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showUploadCountriesForm_error" />
			<notify listener="addressListener" method="processUploadCountriesForm" />
		</event-handler>
		
		<event-handler event="admin.showUploadCountriesForm_error" access="private">
			<event-arg name="includeqForms" value="true" />
			<view-page name="admin.uploadCountriesForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<!-- STATE -->
		<event-handler event="admin.showUploadStatesForm" access="public">
			<event-arg name="includeqForms" value="true" />
			<view-page name="admin.uploadStatesForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.showUploadStatesForm_error" access="private">
			<event-arg name="includeqForms" value="true" />
			<view-page name="admin.uploadStatesForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.processUploadStatesForm" access="public">
			<event-mapping event="success" mapping="admin.showLocationMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showUploadStatesForm_error" />
			<notify listener="addressListener" method="processUploadStatesForm" />
		</event-handler>
		
		<!-- MEETINGS -->
		<event-handler event="admin.showMeetingMenu" access="public">
			<notify listener="meetingListener" method="getMeetings" resultArg="meetings" />
			<view-page name="admin.meetingMenu" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showMeetingMenu_redirect" access="private">
			<redirect event="admin.showMeetingMenu" args="message" />
		</event-handler>
		
		<event-handler event="admin.showMeetingForm" access="public">
			<event-arg name="includeqForms" value="true" />
			<event-arg name="includeCalendar" value="true" />
			<event-arg name="orderBy" value="title" />
			<notify listener="meetingListener" method="getMeetingByID" resultArg="meeting" />
			<notify listener="locationListener" method="getActiveLocations" resultArg="locations" />
			<notify listener="presentationListener" method="getPresentationsAsQuery" resultArg="presentations" />
			<view-page name="admin.meetingForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.showMeetingForm_error" access="private">
			<event-arg name="includeqForms" value="true" />
			<event-arg name="includeCalendar" value="true" />
			<event-arg name="orderBy" value="title" />
			<notify listener="locationListener" method="getActiveLocations" resultArg="locations" />
			<notify listener="presentationListener" method="getPresentationsAsQuery" resultArg="presentations" />
			<view-page name="admin.meetingForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.processMeetingForm" access="public">
			<event-mapping event="success" mapping="admin.showMeetingMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showMeetingForm_error" />
			<event-bean name="meeting" type="org.capitolhillusergroup.meeting.Meeting" 
					fields="meetingID,title,description,connectURL" />
			<event-bean name="location" type="org.capitolhillusergroup.location.Location" 
					fields="locationID" />
			<notify listener="meetingListener" method="processMeetingForm" />
		</event-handler>
		
		<event-handler event="admin.deleteMeeting" access="public">
			<event-mapping event="success" mapping="admin.showMeetingMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showMeetingMenu" />
			<notify listener="meetingListener" method="deleteMeeting" />
		</event-handler>
		
		<!-- NEWS -->
		<event-handler event="admin.showNewsMenu" access="public">
			<event-arg name="activeOnly" value="false" />
			<notify listener="newsListener" method="getNews" resultArg="news" />
			<view-page name="admin.newsMenu" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showNewsMenu_redirect" access="private">
			<redirect event="admin.showNewsMenu" args="message" />
		</event-handler>
		
		<event-handler event="admin.showNewsForm" access="public">
			<event-arg name="includeqForms" value="true" />
			<event-arg name="includeCalendar" value="true" />
			<notify listener="newsListener" method="getNewsByID" resultArg="news" />
			<view-page name="admin.newsForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.showNewsForm_error" access="private">
			<event-arg name="includeqForms" value="true" />
			<event-arg name="includeCalendar" value="true" />
			<view-page name="admin.newsForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.processNewsForm" access="public">
			<event-mapping event="success" mapping="admin.showNewsMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showNewsForm_error" />
			<event-bean name="news" type="org.capitolhillusergroup.news.News" 
						fields="newsID,headline,body,dtToPost" />
			<notify listener="newsListener" method="processNewsForm" />
		</event-handler>
		
		<event-handler event="admin.deleteNews" access="public">
			<event-mapping event="exitEvent" mapping="admin.showNewsMenu_redirect" />
			<event-bean name="news" type="org.capitolhillusergroup.news.News" fields="newsID" />
			<notify listener="newsListener" method="deleteNews" />
		</event-handler>
		
		<!-- ORGANIZATION -->
		<event-handler event="admin.showOrganizationMenu" access="public">
			<notify listener="organizationListener" method="getOrganizations" resultArg="organizations" />
			<view-page name="admin.organizationMenu" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showOrganizationMenu_redirect" access="private">
			<redirect event="admin.showOrganizationMenu" args="message" />
		</event-handler>
		
		<event-handler event="admin.showOrganizationForm" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="organizationListener" method="getOrganizationByID" resultArg="organization" />
			<view-page name="admin.organizationForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.showOrganizationForm_error" access="private">
			<event-arg name="includeqForms" value="true" />
			<view-page name="admin.organizationForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.processOrganizationForm" access="public">
			<event-mapping event="success" mapping="admin.showOrganizationMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showOrganizationForm_error" />
			<event-bean name="organization" type="org.capitolhillusergroup.organization.Organization" 
					fields="organizationID,organization" />
			<notify listener="organizationListener" method="processOrganizationForm" />
		</event-handler>
		
		<event-handler event="admin.deleteOrganization" access="public">
			<event-mapping event="success" mapping="admin.showOrganizationMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showOrganizationMenu" />
			<notify listener="organizationListener" method="deleteOrganization" />
		</event-handler>
		
		<!-- PEOPLE -->
		<event-handler event="admin.showPeopleMenu" access="public">
			<notify listener="personListener" method="getAllPeople" resultArg="people" />
			<view-page name="admin.peopleMenu" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showPeopleMenu_redirect" access="private">
			<redirect event="admin.showPeopleMenu" args="message" />
		</event-handler>
		
		<event-handler event="admin.showPersonForm" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="organizationListener" method="getOrganizations" resultArg="organizations" />
			<notify listener="addressListener" method="getStates" resultArg="states" />
			<notify listener="addressListener" method="getCountries" resultArg="countries" />
			<notify listener="roleListener" method="getRoles" resultArg="roles" />
			<notify listener="imTypeListener" method="getIMTypes" resultArg="imTypes" />
			<notify listener="personListener" method="getPersonByID" resultArg="person" />
			<view-page name="admin.personForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.showPersonForm_error" access="private">
			<event-arg name="includeqForms" value="true" />
			<notify listener="organizationListener" method="getOrganizations" resultArg="organizations" />
			<notify listener="addressListener" method="getStates" resultArg="states" />
			<notify listener="addressListener" method="getCountries" resultArg="countries" />
			<notify listener="roleListener" method="getRoles" resultArg="roles" />
			<notify listener="imTypeListener" method="getIMTypes" resultArg="imTypes" />
			<view-page name="admin.personForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.processPersonForm" access="public">
			<event-mapping event="success" mapping="admin.showPeopleMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showPersonForm_error" />
			<event-bean name="person" type="org.capitolhillusergroup.person.Person" fields="personID,firstName,lastName,title,email,url,password,phone,isAdmin,bio" />
			<event-bean name="organization" type="org.capitolhillusergroup.organization.Organization" fields="organizationID" />
			<event-bean name="role" type="org.capitolhillusergroup.role.Role" fields="roleID" />
			<event-bean name="address" type="org.capitolhillusergroup.address.Address" fields="addressID,address1,address2,city,stateID,postalCode,countryID" />
			<notify listener="personListener" method="processPersonForm" />
		</event-handler>
		
		<event-handler event="admin.deletePerson" access="public">
			<event-mapping event="success" mapping="admin.showPeopleMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showPeopleMenu" />
			<notify listener="personListener" method="deletePerson" />
		</event-handler>
		
		<event-handler event="admin.updateStatusPerson" access="public">
			<event-mapping event="success" mapping="admin.showPeopleMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showPeopleMenu" />
			<notify listener="personListener" method="updateStatusPerson" />
		</event-handler>
		
		<!-- PHOTO ALBUMS AND PHOTOS -->
		<event-handler event="admin.showPhotoMenu" access="public">
			<event-arg name="activeOnly" value="false" />
			<notify listener="photoListener" method="getPhotos" resultArg="photos" />
			<view-page name="admin.photoMenu" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showPhotoMenu_redirect" access="private">
			<redirect event="admin.showPhotoMenu" args="message" />
		</event-handler>
		
		<event-handler event="admin.showPhotoForm" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="photoListener" method="getPhotoById" resultArg="photo" />
			<view-page name="admin.photoForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showPhotoForm_error" access="private">
			<event-arg name="includeqForms" value="true" />
			<view-page name="admin.photoForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.processPhotoForm" access="public">
			<event-mapping event="success" mapping="admin.showPhotoMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showPhotoForm_error" />
			<event-bean name="photo" type="org.capitolhillusergroup.photo.Photo" fields="photoID,title,caption" />
			<notify listener="photoListener" method="processPhotoForm" />
		</event-handler>
		<event-handler event="admin.deletePhoto" access="public">
			<event-mapping event="success" mapping="admin.showPhotoMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showPhotoMenu" />
			<event-bean name="photo" type="org.capitolhillusergroup.photo.Photo" fields="photoID" />
			<notify listener="photoListener" method="deletePhoto" />
		</event-handler>
		
		<event-handler event="admin.showPhotoAlbumMenu" access="public">
			<event-arg name="activeOnly" value="false" />
			<notify listener="photoAlbumListener" method="getPhotoAlbums" resultArg="photoAlbums" />
			<view-page name="admin.photoAlbumMenu" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showPhotoAlbumMenu_redirect" access="private">
			<redirect event="admin.showPhotoAlbumMenu" args="message" />
		</event-handler>

		<event-handler event="admin.showPhotoAlbumForm" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="photoAlbumListener" method="getPhotoAlbumById" resultArg="photoAlbum" />
			<view-page name="admin.photoAlbumForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showPhotoAlbumForm_error" access="private">
			<event-arg name="includeqForms" value="true" />
			<view-page name="admin.photoAlbumForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.processPhotoAlbumForm" access="public">
			<event-mapping event="success" mapping="admin.showPhotoAlbumMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showPhotoAlbumForm_error" />
			<event-bean name="photoalbum" type="org.capitolhillusergroup.photoalbum.PhotoAlbum" fields="photoAlbumID,title,description" />
			<notify listener="photoAlbumListener" method="processPhotoAlbumForm" />
		</event-handler>
		
		<event-handler event="admin.deletePhotoAlbum" access="public">
			<event-mapping event="success" mapping="admin.showPhotoAlbumMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showPhotoAlbumMenu" />
			<event-bean name="photoalbum" type="org.capitolhillusergroup.photoalbum.PhotoAlbum" fields="photoAlbumID,title,description" />
			<notify listener="photoAlbumListener" method="deletePhotoAlbum" />
		</event-handler>
		
		<!-- PRESENTATIONS -->
		<event-handler event="admin.showPresentationMenu" access="public">
			<notify listener="presentationListener" method="getPresentations" resultArg="presentations" />
			<view-page name="admin.presentationMenu" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showPresentationMenu_redirect" access="private">
			<redirect event="admin.showPresentationMenu" args="message" />
		</event-handler>
		
		<event-handler event="admin.showPresentationForm" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="personListener" method="getActivePeople" resultArg="presenters" />
			<notify listener="presentationListener" method="getPresentationByID" resultArg="presentation" />
			<view-page name="admin.presentationForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showPresentationForm_error" access="private">
			<event-arg name="includeqForms" value="true" />
			<notify listener="personListener" method="getActivePeople" resultArg="presenters" />
			<view-page name="admin.presentationForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.processPresentationForm" access="public">
			<event-mapping event="success" mapping="admin.showPresentationMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showPresentationForm_error" />
			<event-bean name="presentation" type="org.capitolhillusergroup.presentation.Presentation" fields="presentationID,title,summary,presentationFileTitle,presentationFileDescription" />
			<notify listener="presentationListener" method="processPresentationForm" />
		</event-handler>
		
		<event-handler event="admin.deletePresentation" access="public">
			<event-mapping event="success" mapping="admin.showPresentationMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showPresentationMenu" />
			<notify listener="presentationListener" method="deletePresentation" />
		</event-handler>
		
		<!-- ROLE -->
		<event-handler event="admin.showRoleMenu" access="public">
			<notify listener="roleListener" method="getRoles" resultArg="roles" />
			<view-page name="admin.roleMenu" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showRoleMenu_redirect" access="private">
			<redirect event="admin.showRoleMenu" args="message" />
		</event-handler>
		
		<event-handler event="admin.showRoleForm" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="roleListener" method="getRoleByID" resultArg="role" />
			<view-page name="admin.roleForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		<event-handler event="admin.showRoleForm_error" access="private">
			<event-arg name="includeqForms" value="true" />
			<view-page name="admin.roleForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.processRoleForm" access="public">
			<event-mapping event="success" mapping="admin.showRoleMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showRoleForm_error" />
			<event-bean name="role" type="org.capitolhillusergroup.role.Role" fields="roleID,role,description" />
			<notify listener="roleListener" method="processRoleForm" />
		</event-handler>
		
		<event-handler event="admin.deleteRole" access="public">
			<event-mapping event="success" mapping="admin.showRoleMenu_redirect" />
			<event-mapping event="failure" mapping="admin.showRoleMenu" />
			<notify listener="roleListener" method="deleteRole" />
		</event-handler>
		
		<!-- RSVPS -->
		<event-handler event="admin.showRSVPForm" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="meetingListener" method="getMeetingByID" resultArg="meeting" />
			<notify listener="rsvpListener" method="getRSVPByID" resultArg="rsvp" />
			<view-page name="admin.rsvpForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.showRSVPForm_error" access="private">
			<event-arg name="includeqForms" value="true" />
			<notify listener="meetingListener" method="getMeetingByID" resultArg="meeting" />
			<notify listener="rsvpListener" method="getRSVPByID" resultArg="rsvp" />
			<view-page name="admin.rsvpForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.showRSVPForm_redirect" access="private">
			<redirect event="admin.showRSVPs" args="meetingID" />
		</event-handler>
		
		<event-handler event="admin.processRSVPForm" access="public">
			<event-mapping event="success" mapping="admin.showRSVPForm_redirect" />
			<event-mapping event="failure" mapping="admin.showRSVPForm_error" />
			<event-bean name="rsvp" type="org.capitolhillusergroup.rsvp.RSVP" fields="rsvpID,meetingID,personID,firstName,lastName,email,comments" />
			<notify listener="rsvpListener" method="processRSVPForm" />
		</event-handler>
		
		<event-handler event="admin.showRSVPs" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="meetingListener" method="getMeetingByID" resultArg="meeting" />
			<notify listener="rsvpListener" method="getRSVPsByMeetingID" resultArg="rsvps" />
			<view-page name="admin.rsvps" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="admin.processRSVPNotificationForm" access="public">
			<notify listener="rsvpListener" method="getRSVPsByMeetingID" resultArg="rsvps" />
			<notify listener="rsvpListener" method="processRSVPNotificationForm" />
		</event-handler>
		
		<event-handler event="admin.deleteRSVP" access="public">
			<notify listener="rsvpListener" method="getRSVPByID" resultArg="rsvp" />
			<notify listener="rsvpListener" method="deleteRSVP" />
		</event-handler>
		
		<!-- MEMBER EVENTS -->
		<event-handler event="member.showMainMenu" access="public">
			<view-page name="member.mainMenu" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="member.showMainMenu_redirect" access="private">
			<redirect event="member.showMainMenu" args="message" />
		</event-handler>
		
		<event-handler event="member.showProfile" access="public">
			<view-page name="member.profileMenu" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="member.showProfileMenu" access="public">
			<view-page name="member.profileMenu" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="member.showProfileMenu_redirect" access="private">
			<redirect event="member.showProfileMenu" args="message" />
		</event-handler>

		<event-handler event="member.showPersonForm" access="public">
			<event-arg name="includeqForms" value="true" />
			<notify listener="organizationListener" method="getOrganizations" resultArg="organizations" />
			<notify listener="addressListener" method="getStates" resultArg="states" />
			<notify listener="addressListener" method="getCountries" resultArg="countries" />
			<notify listener="roleListener" method="getRoles" resultArg="roles" />
			<notify listener="imTypeListener" method="getIMTypes" resultArg="imTypes" />
			<notify listener="personListener" method="getPersonByID" resultArg="person" />
			<view-page name="admin.personForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="member.showPersonForm_error" access="private">
			<event-arg name="includeqForms" value="true" />
			<notify listener="organizationListener" method="getOrganizations" resultArg="organizations" />
			<notify listener="addressListener" method="getStates" resultArg="states" />
			<notify listener="addressListener" method="getCountries" resultArg="countries" />
			<notify listener="roleListener" method="getRoles" resultArg="roles" />
			<notify listener="imTypeListener" method="getIMTypes" resultArg="imTypes" />
			<view-page name="admin.personForm" contentArg="content" />
			<announce event="mainLayout" copyEventArgs="true" />
		</event-handler>
		
		<event-handler event="member.processPersonForm" access="public">
			<event-mapping event="success" mapping="member.showProfileMenu_redirect" />
			<event-mapping event="failure" mapping="member.showPersonForm_error" />
			<event-bean name="person" type="org.capitolhillusergroup.person.Person" fields="personID,firstName,lastName,title,email,url,password,phone,bio" />
			<event-bean name="organization" type="org.capitolhillusergroup.organization.Organization" fields="organizationID" />
			<event-bean name="role" type="org.capitolhillusergroup.role.Role" fields="roleID" />
			<event-bean name="address" type="org.capitolhillusergroup.address.Address" fields="addressID,address1,address2,city,stateID,postalCode,countryID" />
			<notify listener="personListener" method="processPersonForm" />
		</event-handler>
		
		<!-- EXCEPTION EVENT -->
		<event-handler event="exceptionEvent" access="private">
			<view-page name="exception" />
		</event-handler>
	</event-handlers>
	
	<!-- PAGE-VIEWS -->
	<page-views>
		<!-- BASIC/PUBLIC VIEWS -->
		<page-view name="board" page="/views/board.cfm" />
		<page-view name="contactForm" page="/views/contactForm.cfm" />
		<page-view name="home" page="/views/home.cfm" />
		<page-view name="login" page="/views/login.cfm" />
		<page-view name="forgotPassword" page="/views/forgotPassword.cfm" />
		<page-view name="meeting" page="/views/meeting.cfm" />
		<page-view name="meetings" page="/views/meetings.cfm" />
		<page-view name="news" page="/views/news.cfm" />
		<page-view name="newsDetail" page="/views/newsDetail.cfm" />
		<page-view name="articles" page="/views/articles.cfm" />
		<page-view name="articleDetail" page="/views/articleDetail.cfm" />
		<page-view name="rsvpForm" page="/views/rsvpForm.cfm" />
		<page-view name="mainLayout" page="/views/mainLayout.cfm" />
		<page-view name="sidebar" page="/views/sidebar.cfm" />
		<page-view name="pending" page="/views/pending.cfm" />
		<page-view name="thankyou" page="/views/thankyou.cfm" />
		
		<!-- CAPTCHA VIEWS -->
		<page-view name="captchaSnip" page="/views/captchaSnip.cfm" />
		<page-view name="captcha.displayImage" page="/views/captcha/displayImage.cfm" />
		
		<!-- MEMBER VIEWS -->
		<page-view name="member.mainMenu" page="/views/member/mainMenu.cfm" />
		<page-view name="member.profileMenu" page="/views/member/profileMenu.cfm" />
		
		<!-- ADMIN VIEWS -->
		<page-view name="admin.articleMenu" page="/views/admin/articleMenu.cfm" />
		<page-view name="admin.articleForm" page="/views/admin/articleForm.cfm" />
		<page-view name="admin.boardMemberForm" page="/views/admin/boardMemberForm.cfm" />
		<page-view name="admin.boardPositionForm" page="/views/admin/boardPositionForm.cfm" />
		<page-view name="admin.boardPositionMenu" page="/views/admin/boardPositionMenu.cfm" />
		<page-view name="admin.bookMenu" page="/views/admin/bookMenu.cfm" />
		<page-view name="admin.bookForm" page="/views/admin/bookForm.cfm" />
		<page-view name="admin.categoryForm" page="/views/admin/categoryForm.cfm" />
		<page-view name="admin.categoryMenu" page="/views/admin/categoryMenu.cfm" />
		<page-view name="admin.imTypeForm" page="/views/admin/imTypeForm.cfm" />
		<page-view name="admin.imTypeMenu" page="/views/admin/imTypeMenu.cfm" />
		<page-view name="admin.uploadCountriesForm" page="/views/admin/countryUpload.cfm" />
		<page-view name="admin.uploadStatesForm" page="/views/admin/stateUpload.cfm" />
		<page-view name="admin.locationForm" page="/views/admin/locationForm.cfm" />
		<page-view name="admin.locationMenu" page="/views/admin/locationMenu.cfm" />
		<page-view name="admin.mainMenu" page="/views/admin/mainMenu.cfm" />
		<page-view name="admin.meetingForm" page="/views/admin/meetingForm.cfm" />
		<page-view name="admin.meetingMenu" page="/views/admin/meetingMenu.cfm" />
		<page-view name="admin.newsForm" page="/views/admin/newsForm.cfm" />
		<page-view name="admin.newsMenu" page="/views/admin/newsMenu.cfm" />
		<page-view name="admin.organizationForm" page="/views/admin/organizationForm.cfm" />
		<page-view name="admin.organizationMenu" page="/views/admin/organizationMenu.cfm" />
		<page-view name="admin.peopleMenu" page="/views/admin/peopleMenu.cfm" />
		<page-view name="admin.personForm" page="/views/admin/personForm.cfm" />
		<page-view name="admin.photoForm" page="/views/admin/photoForm.cfm" />	
		<page-view name="admin.photoMenu" page="/views/admin/photoMenu.cfm" />
		<page-view name="admin.photoAlbumForm" page="/views/admin/photoAlbumForm.cfm" />
		<page-view name="admin.photoAlbumMenu" page="/views/admin/photoAlbumMenu.cfm" />
		<page-view name="admin.presentationForm" page="/views/admin/presentationForm.cfm" />
		<page-view name="admin.presentationMenu" page="/views/admin/presentationMenu.cfm" />
		<page-view name="admin.roleForm" page="/views/admin/roleForm.cfm" />
		<page-view name="admin.roleMenu" page="/views/admin/roleMenu.cfm" />
		<page-view name="admin.rsvps" page="/views/admin/rsvps.cfm" />
		<page-view name="admin.rsvpForm" page="/views/admin/rsvpForm.cfm" />
		
		<!-- EXCEPTION VIEW -->
		<page-view name="exception" page="/views/exception.cfm" />
	</page-views>

</mach-ii>
