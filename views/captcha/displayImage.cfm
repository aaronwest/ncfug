<cfsilent>
<!---
Copyright: Maestro Publishing
Author: Peter J. Farrell (pjf@maestropublishing.com)
$Id: displayImage.cfm 347 2006-04-24 15:55:39Z pfarrell $

Notes:
--->
	<cfset variables.captcha = event.getArg("captcha") />
</cfsilent>

<cfif getProperty("captchaType") IS "stream">
	<cfcontent type="image/jpg" variable="#variables.captcha.stream#" reset="false" />
<cfelse>
	<cfcontent type="image/jpg" file="#variables.captcha.fileLocation#" deletefile="true" reset="false" />
</cfif>