<cfset meetings = event.getArg("meetings", queryNew("id")) />
<cfinclude template="#getProperty('applicationRoot')#/skins/generic/admin/meetingMenu.cfm" />