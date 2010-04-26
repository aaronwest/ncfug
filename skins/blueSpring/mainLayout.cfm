<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<cfoutput>
<head>
	<title>#event.getArg("pageTitle", getProperty("siteName"))#</title>
	<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />

	<!-- **** layout stylesheet **** -->
	<link rel="stylesheet" type="text/css" href="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/style.css" />

	<!-- **** colour scheme stylesheet **** -->
	<link rel="stylesheet" type="text/css" href="#getProperty('applicationRoot')#skins/#getProperty('skin')#/style/colour.css" />

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
	<div id="main">
		<div id="links">
			<form name="search" action="" method="post">
				<input type="text" name="searchText" style="width:150px;" /><input type="submit" value="#getProperty('resourceBundleService').getResourceBundle().getResource('search')#" style="width:70px;" />
			</form>
		</div>
		<div id="logo"><h1>#getProperty("siteName")#</h1></div>
		<div id="content">
			<div id="menu">
				<ul>
					<li>
						<a<cfif event.getRequestName() is "showHome"> id="selected"</cfif> href="index.cfm?#getProperty('eventParameter')#=showHome">
							#getProperty("resourceBundleService").getResourceBundle().getResource("home")#
						</a>
					<li>
						<a<cfif event.getRequestName() is "showMeetings" or event.getRequestName() is "showMeeting"> id="selected"</cfif> href="index.cfm?#getProperty('eventParameter')#=showMeetings">
							#getProperty("resourceBundleService").getResourceBundle().getResource("meetings")#
						</a>
					</li>
					<li>
						<a<cfif event.getRequestName() is "showNews"> id="selected"</cfif> href="index.cfm?#getProperty('eventParameter')#=showNews">
							#getProperty("resourceBundleService").getResourceBundle().getResource("news")#
						</a>
					</li> 
					<li>
						<a<cfif event.getRequestName() is "showArticles"> id="selected"</cfif> href="index.cfm?#getProperty('eventParameter')#=showArticles">
							#getProperty("resourceBundleService").getResourceBundle().getResource("articles")#
						</a>
					</li>
					<!--- <li>
						<a<cfif event.getRequestName() is "showBooks"> id="selected"</cfif> href="index.cfm?#getProperty('eventParameter')#=showBooks">
							#getProperty("resourceBundleService").getResourceBundle().getResource("books")#
						</a>
					</li>
					<li>
						<a<cfif event.getRequestName() is "showPhotos"> id="selected"</cfif> href="index.cfm?#getProperty('eventParameter')#=showPhotos">
							#getProperty("resourceBundleService").getResourceBundle().getResource("photos")#
						</a>
					</li> --->
					<li>
						<a<cfif event.getRequestName() is "showBoard"> id="selected"</cfif> href="index.cfm?#getProperty('eventParameter')#=showBoard">
							#getProperty("resourceBundleService").getResourceBundle().getResource("board")#
						</a>
					</li>
					<li>
						<a<cfif event.getRequestName() is "showContactForm"> id="selected"</cfif> href="index.cfm?#getProperty('eventParameter')#=showContactForm">
							#getProperty("resourceBundleService").getResourceBundle().getResource("contact")#
						</a>
					</li>
				</ul>
			</div>
			<div id="column1">
				<div class="sidebaritem">
					<div class="sbihead">
						<h1>#getProperty("resourceBundleService").getResourceBundle().getResource("upcomingmeetings")#</h1>
					</div>
					<cfif arrayLen(upcomingMeetings) gt 0>
						<cfloop index="i" from="1" to="#arrayLen(upcomingMeetings)#" step="1">
							<cfif nextMeeting.getLocation().getMapLink() is not "">
								<cfset tempLinkMain = Replace(nextMeeting.getLocation().getMapLink(),"&","&amp;","ALL")>
							</cfif>
							<div class="sbicontent">
								<h2>#getProperty("resourceBundleService").getLocaleUtils().i18nDateTimeFormat(upcomingMeetings[i].getDTMeeting(), 3, 3)#</h2>
								<p><a href="index.cfm?#getProperty('eventParameter')#=showMeeting&meetingID=#upcomingMeetings[i].getMeetingID()#">#upcomingMeetings[i].getTitle()#</a><br />
								#upcomingMeetings[i].getLocation().getLocation()#</p>
								<p>#nextMeeting.getLocation().getAddress().getAddress1()#,<br />
								#nextMeeting.getLocation().getAddress().getCity()#, #nextMeeting.getLocation().getAddress().getState()# #nextMeeting.getLocation().getAddress().getPostalCode()#</p>
								<cfif isDefined("tempLinkMain")>
									<p><a href="#tempLinkMain#">#getProperty("resourceBundleService").getResourceBundle().getResource("mapoflocation")#</a></p>
								</cfif>
								<p><a href="index.cfm?#getProperty('eventParameter')#=showRSVPForm&amp;meetingID=#nextMeeting.getMeetingID()#">#getProperty("resourceBundleService").getResourceBundle().getResource("rsvpforthismeeting")#</a></p>
							</div>
						</cfloop>
					<cfelse>
						<div class="sbicontent">
						#getProperty("resourceBundleService").getResourceBundle().getResource("noupcomingmeetings")#
						</div>
					</cfif>
					<cfif getProperty("groupCalendar","") is not "">
						<div align="center">
							<a target="_blank" href="http://www.google.com/calendar/render?cid=#getProperty('groupCalendar')#%40group.calendar.google.com">
								<img src="http://www.google.com/calendar/images/ext/gc_button1_en.gif" border="0" />
							</a>
						</div>
					</cfif>
				</div>
				
				<cfif news.recordCount gt 0>
				<div class="sidebaritem">
					<div class="sbihead">
						<h1>#getProperty("resourceBundleService").getResourceBundle().getResource("latestnews")#</h1>
					</div>
					<div class="sbicontent">
						<cfloop query="news">
						<h2>#getProperty("resourceBundleService").getLocaleUtils().i18nDateTimeFormat(news.dt_to_post, 3, 3)#</h2>
						<p>#news.headline#</p>
						<p><a href="index.cfm?#getProperty('eventParameter')#=showNewsDetail&newsID=#news.news_id#">#getProperty("resourceBundleService").getResourceBundle().getResource("readmore")#</a></p>
						</cfloop>
					</div>
				</div>
				</cfif>
				<div class="sidebaritem">
					<div class="sbihead">
						<h1>#getProperty("resourceBundleService").getResourceBundle().getResource("links")#</h1>
					</div>
					<div class="sbilinks">
						<ul>
							<li><a href="http://www.adobe.com/cfusion/usergroups/index.cfm">Adobe User Groups</a></li>
							<li><a href="http://www.adobe.com/products/coldfusion">ColdFusion</a></li>
							<li><a href="http://www.adobe.com/products/flex">Flex</a></li>
							<li><a href="http://www.adobe.com/go/air/">AIR</a></li>
							<li><a href="http://www.mozilla.com/firefox">Get Firefox</a></li>
						</ul>
					</div>
				</div>
				<cfif event.getArg("authType") is "admin">
					<div class="sidebaritem">
						<div class="sbihead">
							<h1>#getProperty("resourceBundleService").getResourceBundle().getResource("adminlinks")#</h1>
						</div>
						<div class="sbilinks">
							<ul>
								<li>
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
									<a href="index.cfm?#getProperty('eventParameter')#=admin.showPhotoMenu">
										#getProperty("resourceBundleService").getResourceBundle().getResource("managephotos")#
									</a>
								</li>
							</ul>
						</div>
					</div>
				</cfif>
				<cfif event.getArg("authType") is "admin" or event.getArg("authType") is "member">
					<div class="sidebaritem">
						<div class="sbihead">
							<h1>#getProperty("resourceBundleService").getResourceBundle().getResource("memberlinks")#</h1>
						</div>
						<div class="sbilinks">
							<ul>
								<li>
									<a href="index.cfm?#getProperty('eventParameter')#=member.showMainMenu">
										#getProperty("resourceBundleService").getResourceBundle().getResource("membermenu")#
									</a>
								</li>
								<li>
									<a href="index.cfm?#getProperty('eventParameter')#=member.showProfile">
										#getProperty("resourceBundleService").getResourceBundle().getResource("manageyourprofile")#
									</a>
								</li>
							</ul>
						</div>
					</div>
				</cfif>
				<div class="sidebaritem">
					<div class="sbihead">
						<h1>#getProperty("resourceBundleService").getResourceBundle().getResource("contact")#</h1>
					</div>
					<div class="sbicontent">
						<p>
							#getProperty("siteName")#<br />
							<a href="mailto:#getProperty('contactEmail')#">#getProperty("contactEmail")#</a><br />
							#getProperty("siteLocation")#<br />
							<br />
							<img src="#getProperty('applicationRoot')#skins/#getProperty('skin')#/images/adobe_user_group_badge.jpg" />
						</p>
					</div>
				</div>
			</div>
			<div id="column2">
				#event.getArg("content")#
			</div>
		</div>
		<div id="footer">
			#getProperty("copyrightNotice")# | <a href="mailto:#getProperty('contactEmail')#">#getProperty("contactEmail")#</a> | 
			<a href="http://www.dcarter.co.uk">#getProperty("resourceBundleService").getResourceBundle().getResource("designby")# dcarter</a> | 
			<cfif event.getArg("authType") is not "none">
				<a href="index.cfm?#getProperty('eventParameter')#=logout">#getProperty("resourceBundleService").getResourceBundle().getResource("logout")#</a>
			<cfelse>
				<a href="index.cfm?#getProperty('eventParameter')#=showLogin">#getProperty("resourceBundleService").getResourceBundle().getResource("login")#</a>
			</cfif>
		</div>
	</div>
</body>
</cfoutput>
</html>
