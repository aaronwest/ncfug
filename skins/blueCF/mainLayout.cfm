<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<cfoutput>
<head>
	<title>#event.getArg("pageTitle", getProperty("siteName"))#</title>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	
	<!-- **** layout stylesheet **** -->
	<link rel="stylesheet" type="text/css" href="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/style.css" />
	<script type="text/javascript" src="js/common.js"></script>
	
	<!--- include the form validation libraries if needed --->
	<cfif event.isArgDefined("includeqForms") AND event.getArg("includeqForms")>
		<script type="text/javascript" src="js/lib/qforms.js"></script>
		<script type="text/javascript">
			<!--//--><![CDATA[//><!--
			qFormAPI.setLibraryPath("js/lib/");
			qFormAPI.include("*");
			//--><!]]>
		</script>
	</cfif>
	
	<!--- include the calendar if needed --->	
	<cfif event.isArgDefined("includeCalendar") AND event.getArg("includeCalendar")>
		<style type="text/css">@import url(js/calendar/skins/aqua/theme.css);</style>
		<script type="text/javascript" src="js/calendar/calendar.js"></script>
		<script type="text/javascript" src="js/calendar/lang/calendar-en.js"></script>
		<script type="text/javascript" src="js/calendar/calendar-setup.js"></script>
	</cfif>
</head>

<body>
	<div id="page">
		<div id="nonFooter">
			<div id="header">
				<div id="site-name"><h1>#getProperty("siteName")#</h1></div>
				<ul id="nav">
					<li class="first<cfif event.getRequestName() IS "showHome"> active</cfif>">
						<a href="index.cfm?#getProperty('eventParameter')#=showHome">#UCase(getProperty("resourceBundleService").getResourceBundle().getResource("home"))#</a>
					</li>
					<li<cfif event.getRequestName() CONTAINS "showMeeting"> class="active"</cfif>>
						<a href="index.cfm?#getProperty('eventParameter')#=showMeetings">#UCase(getProperty("resourceBundleService").getResourceBundle().getResource("meetings"))#</a>
					</li>
					<li<cfif event.getRequestName() CONTAINS "showNews"> class="active"</cfif>>
						<a href="index.cfm?#getProperty('eventParameter')#=showNews">#UCase(getProperty("resourceBundleService").getResourceBundle().getResource("news"))#</a>
					</li>
					<li<cfif event.getRequestName() CONTAINS "showArticles"> class="active"</cfif>>
						<a href="index.cfm?#getProperty('eventParameter')#=showArticles">#UCase(getProperty("resourceBundleService").getResourceBundle().getResource("articles"))#</a>
					</li>
					<!--- <li<cfif event.getRequestName() CONTAINS "showBooks"> class="active"</cfif>>
						<a href="index.cfm?#getProperty('eventParameter')#=showBooks">#UCase(getProperty("resourceBundleService").getResourceBundle().getResource("books"))#</a>
					</li>
					<li<cfif event.getRequestName() CONTAINS "showPhotos"> class="active"</cfif>>
						<a href="index.cfm?#getProperty('eventParameter')#=showPhotos">#UCase(getProperty("resourceBundleService").getResourceBundle().getResource("photos"))#</a>
					</li> --->
					<li<cfif event.getRequestName() IS "showBoard" OR event.getRequestName() IS "showContactForm"> class="active"</cfif>>
						<a class="haschildren" href="##">#UCase(getProperty("resourceBundleService").getResourceBundle().getResource("about"))#</a>
						<ul>
							<li class="first"><a href="index.cfm?#getProperty('eventParameter')#=showBoard">#getProperty("resourceBundleService").getResourceBundle().getResource("boardmembers")#</a></li>
							<li><a rel="external" href="http://groups.google.com/group/qldcfug/">#getProperty("resourceBundleService").getResourceBundle().getResource("googlegroup")#</a></li>
							<li class="last"><a href="index.cfm?#getProperty('eventParameter')#=showContactForm">#getProperty("resourceBundleService").getResourceBundle().getResource("contact")#</a></li>
						</ul>
					</li>
					
					<cfif event.getArg("authType") IS "member" OR event.getArg("authType") IS "admin">
						<li>
							<a href="##">#UCase(getProperty("resourceBundleService").getResourceBundle().getResource("member"))#</a>
							<ul>
								<li class="first">
									<a href="index.cfm?#getProperty('eventParameter')#=member.showMainMenu">
										#getProperty("resourceBundleService").getResourceBundle().getResource("memberMenu")#
									</a>
								</li>
								<li>
									<a href="index.cfm?#getProperty('eventParameter')#=member.showProfileMenu">
										#getProperty("resourceBundleService").getResourceBundle().getResource("manageyourprofile")#
									</a>
								</li>
							</ul>
						</li>
					</cfif>
					
					<cfif event.getArg("authType") IS "admin">
						<li>
							<a href="##">#UCase(getProperty("resourceBundleService").getResourceBundle().getResource("admin"))#</a>
							<ul>
								<li class="first">
									<a href="index.cfm?#getProperty('eventParameter')#=admin.showMainMenu">
										#getProperty("resourceBundleService").getResourceBundle().getResource("adminmenu")#
									</a>
								</li>
								<li>
									<a href="index.cfm?#getProperty('eventParameter')#=admin.showArticleMenu">
										#getProperty("resourceBundleService").getResourceBundle().getResource("managearticles")#
									</a>
								</li>
								<li>
									<a href="index.cfm?#getProperty('eventParameter')#=admin.showBookMenu">
										#getProperty("resourceBundleService").getResourceBundle().getResource("managebooks")#
									</a>
								</li>
								<li>
									<a href="index.cfm?#getProperty('eventParameter')#=admin.showMeetingMenu">
										#getProperty("resourceBundleService").getResourceBundle().getResource("managemeetings")#
									</a>
								</li>
								<li>
									<a href="index.cfm?#getProperty('eventParameter')#=admin.showNewsMenu">
										#getProperty("resourceBundleService").getResourceBundle().getResource("managenews")#
									</a>
								</li>
								<li>
									<a href="index.cfm?#getProperty('eventParameter')#=admin.showPeopleMenu">
										#getProperty("resourceBundleService").getResourceBundle().getResource("managepeople")#
									</a>
								</li>
								<li>
									<a href="index.cfm?#getProperty('eventParameter')#=admin.showLocationMenu">
										#getProperty("resourceBundleService").getResourceBundle().getResource("managelocations")#
									</a>
								</li>
								<li class="last">
									<a href="index.cfm?#getProperty('eventParameter')#=admin.showPhotoMenu">
										#getProperty("resourceBundleService").getResourceBundle().getResource("managephotos")#
									</a>
								</li>
							</ul>
						</li>
					</cfif>
				</ul>
			</div>
			<div id="content-wrap">
				
				<div id="<cfif event.isArgDefined("sidebar")>content<cfelse>content_nosidebar</cfif>">
					#event.getArg("content")#
				</div>
				
				<cfif event.isArgDefined("sidebar")>
					#event.getArg("sidebar")#
				</cfif>
				
				<div class="clearer">&nbsp;</div>
			</div>
		</div>
	</div>
	<div id="footer">
		<div id="footer-wrap">
			<div id="footer-content">
				<div class="footer-box" id="previous-meetings">
					<h3>#getProperty("resourceBundleService").getResourceBundle().getResource("meetingspast")#</h3>
					<cfif ArrayLen(previousMeetings) gt 0>
						<cfloop index="i" from="1" to="#ArrayLen(previousMeetings)#" step="1">
							<ul>
								<li><a href="index.cfm?#getProperty('eventParameter')#=showMeeting&amp;meetingID=#previousMeetings[i].getMeetingID()#">#getProperty("resourceBundleService").getLocaleUtils().i18nDateFormat(previousMeetings[i].getDtMeeting(), 3, 3)# - #previousMeetings[i].getTitle()#</a></li>
							</ul>
						</cfloop>
					</cfif>
				</div>
				<div class="footer-box" id="contact">
					<h3>#getProperty("resourceBundleService").getResourceBundle().getResource("contact")#</h3>
					<p>
						#getProperty("siteName")#<br />
						<a href="mailto:#getProperty('contactEmail')#">#getProperty("contactEmail")#</a><br />
						#getProperty("siteLocation")#<br />
					</p>
				</div>
				<div class="footer-box" id="links">
					<h3>#getProperty("resourceBundleService").getResourceBundle().getResource("links")#</h3>
					<ul>
						<li><a rel="external" href="http://www.adobe.com/cfusion/usergroups/index.cfm">Adobe User Groups</a></li>
					</ul>
					<ul>
						<li><a rel="external" href="http://www.adobe.com/products/coldfusion">ColdFusion</a></li>
					</ul>
					<ul>
						<li><a rel="external" href="http://www.adobe.com/products/flex">Flex</a></li>
					</ul>
					<ul>
						<li><a rel="external" href="http://www.adobe.com/go/air/">AIR</a></li>
					</ul>
					<ul>
						<li><a rel="external" href="http://www.mozilla.com/firefox">Get Firefox</a></li>
					</ul>
				</div>
				<cfif event.getArg("authType") IS NOT "admin">
					<div class="footer-box" id="login">
						<h3>#getProperty("resourceBundleService").getResourceBundle().getResource("login")#</h3>
						<form id="loginForm" action="index.cfm?#getProperty('eventParameter')#=processLoginForm" method="post">
							<table>
								<tbody>
									<tr>
										<td><input type="text" name="email" size="12" maxlength="100" /></td>
										<td><input type="password" name="password" size="8" maxlength="10" /></td>
										<td><input type="submit" name="submit" value="#getProperty('resourceBundleService').getResourceBundle().getResource('login')#" style="width:50px;" /></td>
									</tr>
									<tr>
										<td colspan="3">
											<a href="index.cfm?#getProperty('eventParameter')#=showForgotPassword">
												#getProperty("resourceBundleService").getResourceBundle().getResource("forgotpassword")#
											</a>
											&nbsp;|&nbsp;								
											<a href="index.cfm?#getProperty('eventParameter')#=showRegistrationForm">
												#getProperty("resourceBundleService").getResourceBundle().getResource("register")#
											</a>
										</td>
									</tr> 
								</tbody>
							</table>
						</form>
					</div>
				<cfelse>
					<div class="footer-box" id="login">
						<h3>#getProperty("resourceBundleService").getResourceBundle().getResource("logout")#</h3>
						Currently logged in as <br />
						<a href="index.cfm?#getProperty('eventParameter')#=logout">#getProperty("resourceBundleService").getResourceBundle().getResource("logout")#</a>
					</div>
				</cfif>
									
				<div class="footer-box" id="photos">
					<h3>#getProperty("resourceBundleService").getResourceBundle().getResource("photos")#</h3>
					<!--- <img src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/images/photos.jpg" alt="photos" /> --->
				</div>
			</div>
			<div id="copyright">
				<div id="copyright-content">#getProperty("copyrightNotice")#</div>
			</div>
		</div>
	</div>
	<cfif Len(getProperty("googleAnalyticsUAccount","")) GT 0>
		<script src="http://www.google-analytics.com/urchin.js" type="text/javascript"></script>
		<script type="text/javascript">
			_uacct = "#getProperty('googleAnalyticsUAccount','')#";
			urchinTracker();
		</script>
	</cfif>
</body>
</cfoutput>
</html>
