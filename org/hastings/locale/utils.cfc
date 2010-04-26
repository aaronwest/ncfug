<cfcomponent displayname="I18NUtil" hint="util I18N functions: version 1.0.1 machIIblog core java 16-jun-2006 Paul Hastings (paul@sustainbleGIS.com)" output="false">
	<!---
	$Id: $
	
	author:         paul hastings <paul@sustainableGIS.com>
	date:           1-April-2004
	revisions:      25-jun-2004 added locale number formating
	                       7-jul-2004      added localized digit parsing
	                       11-jul-2004     added to/from Arabic-Indic digit functions
	                       12-jul-2004 added metadata function, getDecimalSymbols
	                       13-jul-2004 added localized country and language display functions, showLocaleCountry & showLocaleLanguage
	                       16-jul-2004 added method to return namepart for filtering/sorting on per locale basis
	                       16-aug-2004     added method to delete unicode named files/dirs
	                       3-feb-2005 swapped to ulocales
	                       20-feb-2005 added getCurrencySymbol method
	                       9-jul-2005 added i18nBigDecimalFormat
	                       30-may-2006 swapped to using java epoch offsets from datetimes
	                       16-jun-2006 added date math methods
	notes:
	this CFC contains a several util I18N functions. all valid java locales are supported. it requires the use
	of cfobject.
	
	methods in this CFC:
	       - getLocales returns LIST of java style locales (en_US,etc.) available on this server. PUBLIC
	       - getLocaleNames returns LIST of java style locale names available on this server. PUBLIC
	       - isBIDI returns boolean indicating whether given locale uses lrt to rtl writing sysem direction.
	       required argument is thisLocale. PUBLIC
	       - isValidLocale returns BOOLEAN indicating whether a given locale is valid on this server. should
	       be used for locale validation prior to passing to this CFC. takes one required argument, thisLocale,
	       string such as "en_US", "th_TH", etc. PUBLIC
	       - showCountry: returns country display name in english from given locale, takes
	       one required argument, thisLocale. returns string. PUBLIC
	       - showLanguage: returns language display name in english from given locale, takes
	       one required argument, thisLocale. returns string. PUBLIC
	       - showLocaleCountry: returns localized country display name from given locale, takes
	       one required argument, thisLocale. returns string. PUBLIC
	       - showLocaleLanguage: returns localized language display name from given locale, takes
	       one required argument, thisLocale. returns string. PUBLIC
	       - getDecimalSymbols METADATA function, returns structure holding various decimal format symbols for
	       given locale. required argument is thisLocale, valid java style locale. PUBLIC
	       - getCurrencySymbol METADATA function, returns international (USD, THB,
	       etc.) or localized  currency symbol for given locale. required argument is thisLocale,
	       valid java style locale. optional boolean argument is localized to return localized or
	       international currency symbol. defaults to true (localized). PUBLIC
	 --->
	
	<cffunction access="public" name="init" output="No" hint="initializes needed classes">
		<cfargument name="rbLocale" type="string" required="false" default="en_US" />
		
		<cfset setRBLocale(arguments.rbLocale) />
		
		<cfscript>
			variables.aDFSymbol = createObject("java", "java.text.DecimalFormatSymbols");
			variables.aDateFormat = createObject("java", "java.text.DateFormat");
			variables.aSimpleDateFormat = createObject("java", "java.text.SimpleDateFormat");
			variables.aLocale = createObject("java", "java.util.Locale");
			variables.timeZone = createObject("java", "java.util.TimeZone");
			variables.aLong = createObject("java", "java.lang.Long");
			variables.aDouble = createObject("java", "java.lang.Double");
			variables.dateSymbols = createObject("java", "java.text.DateFormatSymbols");
			variables.I18NUtilVersion = "1.0.1 machIIblog";
			variables.I18NUtilDate = "22-feb-2007"; //should be date of latest change

			loadLocale();
			
			return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="setRBLocale" access="public" output="false" returntype="void">
		<cfargument name="rbLocale" type="string" required="true" />
		<cfset variables.rbLocale = arguments.rbLocale />
	</cffunction>
	<cffunction name="getRBLocale" access="public" output="false" returntype="string">
		<cfreturn variables.rbLocale />
	</cffunction>
	
	<cffunction access="private" name="buildLocale" output="false" hint="creates valid core java locale from java style locale ID">
		<cfargument name="thisLocale" required="yes" type="any">
		<cfscript>
			var l = listFirst(arguments.thisLocale,"_");
			var c = "";
			var v = "";
			var tLocale = variables.aLocale.getDefault(); // if we fail fallback on server default
			
			switch (listLen(arguments.thisLocale, "_")) {
				case 1:
					tLocale = variables.aLocale.init(l);
					break;
				case 2:
					c = listLast(arguments.thisLocale, "_");
					tLocale = variables.aLocale.init(l, c);
					break;
				case 3:
					c = listGetAt(arguments.thisLocale, 2, "_");
					v = listLast(arguments.thisLocale, "_");
					tLocale = variables.aLocale.init(l, c, v);
					break;
			}
				
			return tLocale;
		</cfscript>
	</cffunction>
	
	<cffunction access="public" name="getISOlanguages" output="false" returntype="array" hint="returns array of 2 letter ISO languages">
		<cfreturn variables.aLocale.getISOLanguages() />
	</cffunction>
	
	<cffunction access="public" name="getISOcountries" output="false" returntype="array" hint="returns array of 2 letter ISO countries">
		<cfreturn variables.aLocale.getISOCountries() />
	</cffunction>
	
	<cffunction access="public" name="getLocales" output="false" returntype="array" hint="returns array of locales">
		<cfreturn variables.aLocale.getAvailableLocales() />
	</cffunction>
	
	<cffunction access="public" name="getLocaleNames" output="false" returntype="string" 
			hint="returns list of locale names, UNICODE direction char (LRE/RLE) added as required">
		<cfscript>
			var orgLocales = getLocales();
			var theseLocales = "";
			var thisName = "";
			var i = 0;
			
			for (i = 1; i LTE arrayLen(orgLocales); i = i + 1) {
				if (listLen(orgLocales[i], "_") EQ 2) {
					if (left(orgLocales[i], 2) EQ "ar" or left(orgLocales[i], 2) EQ "iw") {
						thisName = chr(8235) & orgLocales[i].getDisplayName(orgLocales[i]) & chr(8234);
					} else {
						thisName = orgLocales[i].getDisplayName(orgLocales[i]);
					}
					
					theseLocales = listAppend(theseLocales, thisName);
				} // if locale more than language
			} //for
			
			return theseLocales;
		</cfscript>
	</cffunction>
	
	<cffunction name="getLocaleString" access="public" output="false" returntype="string" 
			hint="Returns a string representing the current locale">
		<cfreturn variables.aLocale.getDefault() />
	</cffunction>
	
	<cffunction access="public" name="showCountry" output="false" returntype="string" hint="returns display country name for given locale">
		<cfreturn variables.thisLocale.getDisplayCountry() />
	</cffunction>
	
	<cffunction access="public" name="showISOCountry" output="false" returntype="string" hint="returns 2-letter ISO country name for given locale">
		<cfreturn variables.thisLocale.getCountry() />
	</cffunction>
	
	<cffunction access="public" name="showLanguage" output="false" returntype="string" hint="returns display country name for given locale">
		<cfreturn variables.thisLocale.getDisplayLanguage() />
	</cffunction>
	
	<cffunction access="public" name="showLocaleCountry" output="false" returntype="string" hint="returns display country name for given locale">
		<cfreturn variables.thisLocale.getDisplayCountry(variables.thisLocale) />
	</cffunction>
	
	<cffunction access="public" name="showLocaleLanguage" output="false" returntype="string" hint="returns display country name for given locale">
		<cfreturn variables.thisLocale.getDisplayLanguage(variables.thisLocale) />
	</cffunction>
	
	<cffunction access="public" name="isValidLocale" output="false" returntype="boolean">
		<cfargument name="thisLocale" required="yes" type="string" />
		
		<cfset var isOK = false />
		
		<cfif listFind(arrayToList(getLocales()), arguments.thisLocale)>
			<cfset isOK = true />
		</cfif>
		
		<cfreturn isOK />
	</cffunction>
	
	<!--- core java uses 'iw' for hebrew, leaving 'he' just in case this is a version thing --->
	<cffunction access="public" name="isBidi" output="No" returntype="boolean" hint="determines if given locale is BIDI">
		<cfif listFind("ar,iw,fa,ps,he", left(variables.thisLocale.toString(), 2))>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>
	
	<cffunction access="public" name="getVersion" output="false" returntype="struct" hint=" returns version of this CFC and icu4j library it uses.">
		<cfset var version = StructNew() />
		<cfset var sys = createObject("java", "java.lang.System") />
		
		<cfset version.I18NUtilVersion = variables.I18NUtilVersion />
		<cfset version.I18NUtilDate = variables.I18NUtilDate />
		<cfset version.javaRuntimeVersion = sys.getProperty("java.runtime.version") />
		<cfset version.javaVersion = sys.getProperty("java.version") />
		
		<cfreturn version />
	</cffunction>
	
	<cffunction access="public" name="getCurrencySymbol" returntype="string" output="false" hint="returns currency symbol for this locale">
		<cfargument name="localized" required="no" type="boolean" default="true" hint="return international (USD, THB, etc.) or localized ($,etc.) symbol" />
		
		<cfset var aCurrency = createObject("java","com.ibm.icu.util.Currency") />
		<cfset var tmp = arrayNew(1) />
		
		<cfif arguments.localized>
			<cfset arrayAppend(tmp, true) />
			<cfreturn aCurrency.getInstance(variables.thisLocale).getName(variables.thisLocale, aCurrency.SYMBOL_NAME, tmp) />
		<cfelse>
			<cfreturn aCurrency.getInstance(variables.thisLocale).getCurrencyCode() />
		</cfif>
	</cffunction>
	
	<cffunction access="public" name="getDecimalSymbols" output="false" returntype="struct" hint="returns strucure holding decimal format symbols for this locale">
		<cfscript>
			var dfSymbols = variables.aDFSymbol.init(variables.thisLocale);
			var symbols = structNew();
			
			symbols.plusSign = dfSymbols.getPlusSign().toString();
			symbols.Percent = dfSymbols.getPercent().toString();
			symbols.minusSign = dfSymbols.getMinusSign().toString();
			symbols.currencySymbol = dfSymbols.getCurrencySymbol().toString();
			symbols.internationCurrencySymbol = dfSymbols.getInternationalCurrencySymbol().toString();
			symbols.monetaryDecimalSeparator = dfSymbols.getMonetaryDecimalSeparator().toString();
			symbols.exponentSeparator = dfSymbols.getExponentSeparator().toString();
			symbols.perMille = dfSymbols.getPerMill().toString();
			symbols.decimalSeparator = dfSymbols.getDecimalSeparator().toString();
			symbols.groupingSeparator = dfSymbols.getGroupingSeparator().toString();
			symbols.zeroDigit = dfSymbols.getZeroDigit().toString();
			
			return symbols;
		</cfscript>
	</cffunction>
	
	<cffunction access="public" name="i18nDateTimeFormat" output="No" returntype="string"> 
		<cfargument name="thisOffset" required="yes" type="numeric" hint="java epoch offset" />
		<cfargument name="thisDateFormat" default="1" required="No" type="numeric" />
		<cfargument name="thisTimeFormat" default="1" required="No" type="numeric" />
		<cfargument name="tz" required="no" default="#variables.timeZone.getDefault().getID()#" />
		
		<cfset var d = variables.aDouble.init(javaCast("string", arguments.thisOffset)) />
		<cfset var tDateFormat = javaCast("int", arguments.thisDateFormat) />
		<cfset var tTimeFormat = javaCast("int", arguments.thisTimeFormat) />
		<cfset var tDateFormatter = variables.aDateFormat.getDateTimeInstance(tDateFormat, tTimeFormat, variables.thisLocale) />
		<cfset var tTZ = variables.timeZone.getTimezone(arguments.tz) />
		<cfset var aCalendar = createObject("java", "java.util.GregorianCalendar").init(variables.thisLocale) />
		<cfset var result = "">
		<cfset var ampm = "PM">
		
		<cfset tDateFormatter.setTimezone(tTZ) />
		<cfset aCalendar.setTimeInMillis(d.longValue()) />
		
		<cfset result = tDateFormatter.format(aCalendar.getTime())>
		
		<!--- More fixes for what appears to be display issues with NZ and AU locales. --->
		<cfif (variables.thisLocale IS "en_AU" OR variables.thisLocale IS "en_NZ") AND REFindNoCase("\s??[0-9]{1,2}:[0-9]{1,2}",result) GT 0>
			<cfif aCalendar.get(aCalendar.HOUR_OF_DAY) LT 12>
				<cfset ampm = "AM">
			</cfif>
			<cfset result = REReplaceNoCase(result,"\s??[0-9]{1,2}:[0-9]{1,2}"," #REReplaceNoCase(aCalendar.get(aCalendar.HOUR),'^([0-9]{1})$','0\1')#:#REReplaceNoCase(aCalendar.get(aCalendar.MINUTE),'^([0-9]{1})$','0\1')##ampm#")>
		</cfif>
		
		<cfreturn result />
	</cffunction>
	
	<cffunction access="public" name="i18nDateFormat" output="No" returntype="string">
		<cfargument name="thisOffset" required="yes" type="numeric" hint="java epoch offset">
		<cfargument name="thisDateFormat" default="1" required="No" type="numeric">
		<cfargument name="tz" required="no" default="#variables.timeZone.getDefault().getID()#">
		
		<cfset var d = variables.aDouble.init(javaCast("string", arguments.thisOffset)) />
		<cfset var tDateFormat = javaCast("int", arguments.thisDateFormat) />
		<cfset var tDateFormatter = variables.aDateFormat.getDateInstance(tDateFormat, variables.thisLocale) />
		<cfset var tTZ = variables.timeZone.getTimezone(arguments.tz) />
		<cfset var aCalendar = createObject("java", "java.util.GregorianCalendar").init(variables.thisLocale) />
	
		<cfset tDateFormatter.setTimezone(tTZ) />
		<cfset aCalendar.setTimeInMillis(d.longValue()) />
		
		<cfreturn tDateFormatter.format(aCalendar.getTime()) />
	</cffunction>
	
	<cffunction access="public" name="i18nTimeFormat" output="No" returntype="string">
		<cfargument name="thisOffset" required="yes" type="numeric" hint="java epoch offset" />
		<cfargument name="thisTimeFormat" default="1" required="No" type="numeric" />
		<cfargument name="tz" required="no" default="#variables.timeZone.getDefault().getID()#" />
		
		<cfset var d = variables.aDouble.init(javaCast("string", arguments.thisOffset)) />
		<cfset var tTimeFormat = javaCast("int", arguments.thisTimeFormat) />
		<cfset var tTimeFormatter = variables.aDateFormat.getTimeInstance(tTimeFormat, variables.thisLocale) />
		<cfset var tTZ = timeZone.getTimezone(arguments.tz) />
		<cfset var aCalendar = createObject("java", "java.util.GregorianCalendar").init(variables.thisLocale) />
		<cfset var result = "">

		<cfset tTimeFormatter.setTimezone(tTZ) />
		<cfset aCalendar.setTimeInMillis(d.longValue()) />
		
		<cfset result = tTimeFormatter.format(aCalendar.getTime())>
		
		<!--- More fixes for what appears to be display issues with NZ and AU locales. --->
		<cfif (variables.thisLocale IS "en_AU" OR variables.thisLocale IS "en_NZ") AND REFindNoCase("[0-9]{1,2}:[0-9]{1,2}",result) GT 0>
			<cfif aCalendar.get(aCalendar.HOUR_OF_DAY) LT 12>
				<cfset ampm = "AM">
			</cfif>
			<cfset result = REReplaceNoCase(result,"[0-9]{1,2}:[0-9]{1,2}","#REReplaceNoCase(aCalendar.get(aCalendar.HOUR),'^([0-9]{1})$','0\1')#:#REReplaceNoCase(aCalendar.get(aCalendar.MINUTE),'^([0-9]{1})$','0\1')##ampm#")>
		</cfif>
		
		<cfreturn result />
	</cffunction>
	
	<cffunction access="public" name="i18nDateParse" output="No" returntype="numeric" 
			hint="parses localized date string to datetime object or returns blank if it can't parse">
		<cfargument name="thisDate" required="yes" type="string" />
		
		<cfset var isOk = true />
		<cfset var i = 0 />
		<cfset var parsedDate = "" />
		<cfset var tDateFormatter = "" />
		
		<!--- holy cow batman, can't parse dates in an elegant way. bash! pow! socko! --->
		<cfloop index="i" from="0" to="3">
			<cfset tDateFormatter = variables.aDateFormat.getDateInstance(javaCast("int", i), variables.thisLocale) />
			<cftry>
				<cfset isOk = true />
				<cfset parsedDate = tDateFormatter.parse(arguments.thisDate) />
				<cfcatch type="Any">
					<cfset isOK = false />
				</cfcatch>
			</cftry>
			
			<cfif isOK>
				<cfbreak />
			</cfif>
		</cfloop>
		
		<cfreturn parsedDate.getTime() />
	</cffunction>
	
	<cffunction access="public" name="i18nDateTimeParse" output="No" returntype="numeric" 
			hint="parses localized datetime string to datetime object or returns blank if it can't parse">
		<cfargument name="thisDate" required="yes" type="string" />
		
		<cfset var isOk = true />
		<cfset var i = 0 />
		<cfset var j = 0 />
		<cfset var dStyle = 0 />
		<cfset var tStyle = 0 />
		<cfset var parsedDate = "" />
		<cfset var tDateFormatter = "" />
		<cfset var tempHours = 0 />
		<cfset var aCalendar = "" />
		
		<!--- holy cow batman, can't parse dates in an elegant way. bash! pow! socko! --->
		<cfloop index="i" from="0" to="3">
			<cfset dStyle = javacast("int", i) />
			
			<cfloop index="j" from="0" to="3">
				<cfset tStyle = javaCast("int", j) />
				<cfset tDateFormatter = variables.aDateFormat.getDateTimeInstance(dStyle, tStyle, variables.thisLocale) />
				
				<cftry>
					<cfset isOk=true />
					<cfset parsedDate = tDateFormatter.parse(arguments.thisDate) />
					<cfcatch type="any">
						<cfset isOK = false />
					</cfcatch>
				</cftry>
				
				<cfif isOK>
					<cfif (variables.thisLocale IS "en_AU" OR variables.thisLocale IS "en_NZ") AND FindNoCase("PM",arguments.thisDate) GT 0>
						<cfset aCalendar = createObject("java", "java.util.GregorianCalendar").init(variables.thisLocale) />
						<cfset aCalendar.setTime(parsedDate)>
						<cfset tempHours = aCalendar.get(aCalendar.HOUR_OF_DAY)>
						<cfif tempHours LT 12>
							<cfset aCalendar.set(aCalendar.HOUR_OF_DAY,JavaCast("int",(tempHours+12)))>
							<cfset parsedDate = aCalendar.getTime()>
						</cfif>
					</cfif>
					<cfbreak />
				</cfif>
			</cfloop>
		</cfloop>
		
		<cfreturn parsedDate.getTime() />
	</cffunction>
	
	<cffunction access="public" name="getDateTimePattern" output="No" returntype="string" hint="returns locale date/time pattern">
		<cfargument name="thisDateFormat" required="no" type="numeric" default="1" />
		<cfargument name="thisTimeFormat" required="no" type="numeric" default="3" />
		
		<cfset var tDateFormat = javaCast("int", arguments.thisDateFormat) />
		<cfset var tTimeFormat = javaCast("int", arguments.thisTimeFormat) />
		<cfset var tDateFormatter = variables.aDateFormat.getDateTimeInstance(tDateFormat, tTimeFormat, variables.thisLocale) />

		<cfreturn tDateFormatter.toPattern() />
	</cffunction>
	
	<cffunction access="public" name="getJSDateInputPattern" output="No" returntype="string" hint="returns date picker specific date/time formatting">
		<cfargument name="thisDateFormat" required="no" type="numeric" default="1" />
		<cfargument name="thisTimeFormat" required="no" type="numeric" default="3" />
		
		<cfset var result = "%m/%d/%Y %I:%M %P">
		
		<cfif getRBLocale() IS "en_AU">
			<cfset result = "%d/%m/%Y %I:%M %P">
		</cfif>
		
		<!--- 
		%a abbreviated weekday name
		%A full weekday name
		%b abbreviated month name
		%B full month name
		%C century number
		%d the day of the month ( 00 .. 31 )		
		%e the day of the month ( 0 .. 31 )			
		%H hour ( 00 .. 23 )						
		%I hour ( 01 .. 12 )						
		%j day of the year ( 000 .. 366 )			
		%k hour ( 0 .. 23 )							
		%l hour ( 1 .. 12 )							
		%m month ( 01 .. 12 )
		%M minute ( 00 .. 59 )
		%n a newline character
		%p �PM� or �AM�
		%P �pm� or �am�
		%S second ( 00 .. 59 )
		%s number of seconds since Epoch (since Jan 01 1970 00:00:00 UTC)
		%t a tab character
		%U, %W, %V the week number
		%u the day of the week ( 1 .. 7, 1 = MON )
		%w the day of the week ( 0 .. 6, 0 = SUN )
		%y year without the century ( 00 .. 99 )
		%Y year including the century ( ex. 1979 )
		%% a literal % character
		
		G  	Era designator 	Text  	AD					
		y 	Year 	Year 	1996; 96					
		M 	Month in year 	Month 	July; Jul; 07
		w 	Week in year 	Number 	27
		W 	Week in month 	Number 	2
		D 	Day in year 	Number 	189
		d 	Day in month 	Number 	10
		F 	Day of week in month 	Number 	2
		
		E 	Day in week 	Text 	Tuesday; Tue
		a 	Am/pm marker 	Text 	PM
		H 	Hour in day (0-23) 	Number 	0
		k 	Hour in day (1-24) 	Number 	24
		K 	Hour in am/pm (0-11) 	Number 	0
		h 	Hour in am/pm (1-12) 	Number 	12
		m 	Minute in hour 	Number 	30
		s 	Second in minute 	Number 	55
		S 	Millisecond 	Number 	978
		z 	Time zone 	General time zone 	Pacific Standard Time; PST; GMT-08:00
		Z 	Time zone 	RFC 822 time zone 	-0800
		--->

		<cfreturn result>
	</cffunction>
	
	<cffunction access="public" name="formatDateTime" output="No" returntype="string" hint="formats a date/time to given pattern">
		<cfargument name="thisOffset" required="yes" type="numeric" />
		<cfargument name="thisPattern" required="yes" type="string" />
		<cfargument name="tz" required="no" default="#variables.timeZone.getDefault().getID()#" />
		
		<cfset var tDateFormatter = variables.aDateFormat.getDateTimeInstance(variables.aDateFormat.LONG, variables.aDateFormat.LONG, variables.thisLocale) />
		
		<cfset tDateFormatter.applyPattern(arguments.thisPattern) />
		
		<cfreturn tDateFormatter.format(arguments.thisOffset) />
	</cffunction>
	
	<cffunction name="weekStarts" access="public" returnType="string" output="false" hint="Determines the first DOW.">
		<cfset var aCalendar = createObject("java", "java.util.GregorianCalendar").init(variables.thisLocale) />
		
		<cfreturn aCalendar.getFirstDayOfWeek() />
	</cffunction>
	
	<cffunction name="getLocalizedYear" access="public" returnType="string" output="false" hint="Returns localized year, probably only useful for BE calendars like in thailand, etc.">
		<cfargument name="thisYear" type="numeric" required="true" />
		<cfargument name="thisLocale" required="false" type="string" default="#variables.aLocale.getDefault()#" />
		
		<cfset var thisDF = variables.aSimpleDateFormat.init("yyyy", buildLocale(arguments.thisLocale)) />
		
		<cfreturn thisDF.format(createDate(arguments.thisYear, 1, 1)) />
	</cffunction>
	
	<cffunction name="getLocalizedMonth" access="public" returnType="string" output="false" hint="Returns localized month.">
		<cfargument name="month" type="numeric" required="true" />
		<cfargument name="thisLocale" required="false" type="any" default="#variables.aLocale.getDefault()#" />
		
		<cfset var thisDF = variables.aSimpleDateFormat.init("MMMM", buildLocale(arguments.thisLocale)) />
		
		<cfreturn thisDF.format(createDate(1999, arguments.month, 1)) />
	</cffunction>

	<cffunction name="getLocalizedMonths" access="public" returnType="array" output="false" hint="Returns array of localized months.">
		<cfset var thisDFS = variables.dateSymbols.init(variables.thisLocale) />
		<cfreturn thisDFS.getMonths() />
	</cffunction>
	
	<cffunction name="getLocalizedShortMonths" access="public" returnType="array" output="false" hint="Returns array of localized short months.">
		<cfset var thisDFS = variables.dateSymbols.init(variables.thisLocale) />
		<cfreturn thisDFS.getShortMonths() />
	</cffunction>

	<cffunction access="public" name="getShortWeekDays" output="No" returntype="array" hint="returns short day names for this calendar">
		<cfargument name="calendarOrder" required="no" type="boolean" default="true" />
	
		<cfset var aCalendar = createObject("java", "java.util.GregorianCalendar").init(variables.thisLocale) />
		<cfset var theseDateSymbols = dateSymbols.init(aCalendar, variables.thisLocale) />
		<cfset var localeDays = "" />
		<cfset var i = 0 />
		<cfset var tmp = listToArray(arrayToList(theseDateSymbols.getShortWeekDays())) />
		
		<cfif NOT arguments.calendarOrder>
			<cfreturn tmp />
		<cfelse>
			<cfswitch expression="#weekStarts(variables.thisLocale)#">
				<cfcase value="1"> <!--- "standard" dates --->
					<cfreturn tmp />
				</cfcase>
				
				<cfcase value="2"> <!--- euro dates, starts on monday needs kludge --->
					<cfset localeDays = arrayNew(1) />
					<cfset localeDays[7] = tmp[1] /> <!--- move sunday to last --->
					
					<cfloop index="i" from="1" to="6">
						<cfset localeDays[i] = tmp[i+1] />
					</cfloop>
					
					<cfreturn localeDays />
				</cfcase>
				
				<cfcase value="7"> <!--- starts saturday, usually arabic, needs kludge --->
					<cfset localeDays = arrayNew(1) />
					<cfset localeDays[1] = tmp[7] /> <!--- move saturday to first --->
					
					<cfloop index="i" from="1" to="6">
						<cfset localeDays[i+1] = tmp[i] />
					</cfloop>
					
					<cfreturn localeDays />
				</cfcase>
			</cfswitch>
		</cfif>
	</cffunction>
	
	<cffunction name="getYear" output="No" access="public" returntype="numeric" hint="returns year from epoch offset">
		<cfargument name="thisOffset" required="Yes" hint="java epoch offset" type="numeric" />
		<cfargument name="tz" required="no" default="#variables.timeZone.getDefault().getID()#" />
		
		<cfset var thisTZ = variables.timeZone.getTimeZone(arguments.tZ) />
		<cfset var aCalendar = createObject("java", "java.util.GregorianCalendar").init(variables.thisLocale) />
		<cfset var d = variables.aDouble.init(javaCast("string", arguments.thisOffset)) />
		
		<cfset aCalendar.setTimeInMillis(d.longValue()) />
		<cfset aCalendar.setTimeZone(thisTZ) />
		
		<cfreturn aCalendar.get(aCalendar.YEAR) />
	</cffunction>
	
	<cffunction name="getMonth" output="No" access="public" returntype="numeric" hint="returns month from epoch offset">
		<cfargument name="thisOffset" required="Yes" hint="java epoch offset" type="numeric" />
		<cfargument name="tz" required="no" default="#variables.timeZone.getDefault().getID()#" />
		
		<cfset var thisTZ = variables.timeZone.getTimeZone(arguments.tZ) />
		<cfset var aCalendar = createObject("java", "java.util.GregorianCalendar").init(variables.thisLocale) />
		<cfset var d = variables.aDouble.init(javaCast("string", arguments.thisOffset)) />
		
		<cfset aCalendar.setTimeInMillis(d.longValue()) />
		<cfset aCalendar.setTimeZone(thisTZ) />
		
		<cfreturn aCalendar.get(aCalendar.MONTH) + 1 /> <!--- java months start at 0 --->
	</cffunction>
	
	<cffunction name="getDay" output="No" access="public" returntype="numeric" hint="returns day from epoch offset">
		<cfargument name="thisOffset" required="Yes" hint="java epoch offset" type="numeric" />
		<cfargument name="tz" required="no" default="#variables.timeZone.getDefault().getID()#" />
		
		<cfset var thisTZ = variables.timeZone.getTimeZone(arguments.tZ) />
		<cfset var aCalendar = createObject("java", "java.util.GregorianCalendar").init(variables.thisLocale) />
		<cfset var d = variables.aDouble.init(javaCast("string", arguments.thisOffset)) />
		
		<cfset aCalendar.setTimeInMillis(d.longValue()) />
		<cfset aCalendar.setTimeZone(thisTZ) />
		
		<cfreturn aCalendar.get(aCalendar.DATE) />
	</cffunction>
	
	<cffunction name="getHour" output="No" access="public" returntype="numeric" hint="returns hour of day, 24 hr format, from epoch offset">
		<cfargument name="thisOffset" required="Yes" hint="java epoch offset" type="numeric" />
		<cfargument name="tz" required="no" default="#variables.timeZone.getDefault().getID()#" />
		
		<cfset var thisTZ = variables.timeZone.getTimeZone(arguments.tZ) />
		<cfset var aCalendar = createObject("java", "java.util.GregorianCalendar").init(variables.thisLocale) />
		<cfset var d = variables.aDouble.init(javaCast("string", arguments.thisOffset)) />
		
		<cfset aCalendar.setTimeInMillis(d.longValue()) />
		<cfset aCalendar.setTimeZone(thisTZ) />
		
		<cfreturn aCalendar.get(aCalendar.HOUR_OF_DAY) />
	</cffunction>
	
	<cffunction name="getMinute" output="No" access="public" returntype="numeric" hint="returns minute from epoch offset">
		<cfargument name="thisOffset" required="Yes" hint="java epoch offset" type="numeric" />
		<cfargument name="tz" required="no" default="#variables.timeZone.getDefault().getID()#" />
		
		<cfset var thisTZ = variables.timeZone.getTimeZone(arguments.tZ) />
		<cfset var aCalendar = createObject("java", "java.util.GregorianCalendar").init(variables.thisLocale) />
		<cfset var d = variables.aDouble.init(javaCast("string", arguments.thisOffset)) />
		
		<cfset aCalendar.setTimeInMillis(d.longValue()) />
		<cfset aCalendar.setTimeZone(thisTZ) />
		
		<cfreturn aCalendar.get(aCalendar.MINUTE) />
	</cffunction>
	
	<cffunction name="getSecond" output="No" access="public" returntype="numeric" hint="returns second from epoch offset">
		<cfargument name="thisOffset" required="Yes" hint="java epoch offset" type="numeric" />
		<cfargument name="tz" required="no" default="#variables.timeZone.getDefault().getID()#" />
		
		<cfset var thisTZ = variables.timeZone.getTimeZone(arguments.tZ) />
		<cfset var aCalendar = createObject("java", "java.util.GregorianCalendar").init(variables.thisLocale) />
		<cfset var d = variables.aDouble.init(javaCast("string", arguments.thisOffset)) />
		
		<cfset aCalendar.setTimeInMillis(d.longValue()) />
		<cfset aCalendar.setTimeZone(thisTZ) />
		
		<cfreturn aCalendar.get(aCalendar.SECOND) />
	</cffunction>
	
	<cffunction name="toEpoch" access="public" output="no" returnType="numeric" hint="converts datetime to java epoch offset">
		<cfargument name="thisDate" required="Yes" hint="datetime to convert to java epoch" type="date" />
		
		<cfreturn arguments.thisDate.getTime() />
	</cffunction>
	
	<cffunction name="fromEpoch" access="public" output="no" returnType="date" hint="converts java epoch offset to datetime">
		<cfargument name="thisOffset" required="Yes" hint="java epoch offset to convert to datetime" type="numeric" />
		
		<cfset var d = variables.aDouble.init(javaCast("string", arguments.thisOffset)) />
		<cfset var aCalendar = createObject("java", "java.util.GregorianCalendar").init(variables.thisLocale) />
		
		<cfset aCalendar.setTimeInMillis(d.longValue()) />
		
		<cfreturn aCalendar.getTime() />
	</cffunction>
	
	<cffunction name="getAvailableTZ" output="yes" returntype="array" access="public" hint="returns an array of timezones available on this server">
		<cfreturn variables.timeZone.getAvailableIDs() />
	</cffunction>
	
	<cffunction name="usesDST" output="No" returntype="boolean" access="public" hint="determines if a given timezone uses DST">
		<cfargument name="tz" required="no" default="#variables.timeZone.getDefault().getID()#" />
		
		<cfreturn variables.timeZone.getTimeZone(arguments.tz).useDaylightTime() />
	</cffunction>
	
	<cffunction name="getRawOffset" output="No" access="public" returntype="numeric" hint="returns rawoffset in hours">
		<cfargument name="tZ" required="no" default="#variables.timeZone.getDefault().getID()#" />
		
		<cfset var thisTZ = variables.timeZone.getTimeZone(arguments.tZ) />
		
		<cfreturn thisTZ.getRawOffset() / 3600000 />
	</cffunction>
	
	<cffunction name="getDST" output="No" access="public" returntype="numeric" hint="returns DST savings in hours">
		<cfargument name="thisTZ" required="no" default="#variables.timeZone.getDefault().getID()#" />
		
		<cfset var tZ = variables.timeZone.getTimeZone(arguments.thisTZ) />
		
		<cfreturn tZ.getDSTSavings() / 3600000 />
	</cffunction>
	
	<cffunction name="getTZByOffset" output="No" returntype="array" access="public" hint="returns a list of timezones available on this server for a given raw offset">
		<cfargument name="thisOffset" required="Yes" type="numeric" />
		
		<cfset var rawOffset = javaCast("long", arguments.thisOffset * 3600000) />
		
		<cfreturn variables.timeZone.getAvailableIDs(rawOffset) />
	</cffunction>
	
	<cffunction name="getServerTZ" output="No" access="public" returntype="any" hint="returns server TZ">
		<cfset var serverTZ = variables.timeZone.getDefault() />
		
		<cfreturn serverTZ.getDisplayName(true, variables.timeZone.LONG) />
	</cffunction>
	
	<cffunction name="inDST" output="No" returntype="boolean" access="public" hint="determines if a given date in a given timezone is in DST">
		<cfargument name="thisOffset" required="yes" type="numeric" />
		<cfargument name="tzToTest" required="no" default="#variables.timeZone.getDefault().getID()#" />
		
		<cfset var thisTZ = variables.timeZone.getTimeZone(arguments.tzToTest) />
		<cfset var aCalendar = createObject("java", "java.util.GregorianCalendar").init(variables.thisLocale) />
		
		<cfset aCalendar.setTimeInMillis(arguments.thisOffset) />
		<cfset aCalendar.setTimezone(thisTZ) />
		
		<cfreturn thisTZ.inDaylightTime(aCalendar.getTime()) />
	</cffunction>
	
	<cffunction name="getTZOffset" output="No" access="public" hint="returns offset in hours">
		<cfargument name="thisOffset" required="yes" type="numeric" />
		<cfargument name="thisTZ" required="no" default="#variables.timeZone.getDefault().getID()#" />
		
		<cfset var tZ = variables.timeZone.getTimeZone(arguments.thisTZ) />
		
		<cfreturn tZ.getOffset(arguments.thisOffset) / 3600000 /> <!--- return hours --->
	</cffunction>
	
	<cffunction name="loadLocale" access="public" returnType="void" output="false"  hint="Loads a locale.">
		<cfif not isValidLocale(getRBLocale())>
			<cfthrow message="Specified locale must be of the form language_COUNTRY_VARIANT where language, country and variant are 2 characters each, ISO 3166 standard." />
		</cfif>
		
		<cfset variables.thisLocale = buildLocale(getRBLocale()) />
	</cffunction>
	
	<cffunction access="public" name="i18nDateAdd" output="No" returntype="numeric">
		<cfargument name="thisOffset" required="yes" type="numeric">
		<cfargument name="thisDatePart" required="yes" type="string">
		<cfargument name="dateUnits" required="yes" type="numeric">
		<cfargument name="thisTZ" required="no" default="#variables.timeZone.getDefault().getID()#">
		
		<cfscript>
			var dPart = "";
			var tZ = variables.timeZone.getTimeZone(arguments.thisTZ);
			var aCalendar = createObject("java", "java.util.GregorianCalendar").init(variables.thisLocale);
			
			switch (arguments.thisDatepart) {
				case "y" :
				case "yr" :
				case "yyyy" :
				case "year" :
					dPart = aCalendar.YEAR;
					break;
				
				case "m" :
				case "month" :
					dPart = aCalendar.MONTH;
					break;
					
				case "w" :
				case "week" :
					dPart = aCalendar.WEEK_OF_MONTH;
					break;
				
				case "d" :
				case "day" :
					dPart = aCalendar.DATE;
					break;
				
				case "h" :
				case "hr":
				case "hour" :
					dPart = aCalendar.HOUR;
					break;
				
				case "n" :
				case "minute" :
					dPart = aCalendar.MINUTE;
					break;
					
				case "s" :
				case "second" :
					dPart = aCalendar.SECOND;
					break;
			}
			
			aCalendar.setTimeInMillis(arguments.thisOffset);
			aCalendar.setTimezone(tZ);
			aCalendar.add(dPart,javaCast("int", arguments.dateUnits));
			
			return aCalendar.getTimeInMillis();
		</cfscript>
	</cffunction>
	
	<!--- oh my is this nasty in core java --->
	<cffunction access="public" name="i18nDateDiff" output="No" returntype="numeric">
		<cfargument name="thisOffset" required="yes" type="numeric" />
		<cfargument name="thatOffset" required="yes" type="numeric" />
		<cfargument name="thisDatePart" required="yes" type="string" />
		<cfargument name="thisTZ" required="no" default="#variables.timeZone.getDefault().getID()#" />
		
		<cfscript>
			var dPart = "";
			var elapsed = 0;
			var before = createObject("java","java.util.GregorianCalendar");
			var after = createObject("java","java.util.GregorianCalendar");
			var tZ = variables.timeZone.getTimeZone(arguments.thisTZ);
			var aCalendar = createObject("java", "java.util.GregorianCalendar").init(variables.thisLocale);
			var e = 0;
			var s = 0;
			var direction = 1;
			
			// lets shortcut first
			if (arguments.thisOffset EQ arguments.thatOffset) {
				return 0;
			} else {  // setup calendars to test
				if (arguments.thisOffset LT arguments.thatOffset) {
					before.setTimeInMillis(arguments.thisOffset);
					after.setTimeInMillis(arguments.thatOffset);
					before.setTimezone(tZ);
					after.setTimezone(tZ);
				} else {
					before.setTimeInMillis(arguments.thatOffset);
					after.setTimeInMillis(arguments.thisOffset);
					before.setTimezone(tZ);
					after.setTimezone(tZ);
					direction = -1;
				} // which offset came first
				
				switch (arguments.thisDatepart) {
					case "y" :
					case "yr" :
					case "yyyy" :
					case "year" :
				        dPart = aCalendar.YEAR;
				        before.clear(aCalendar.DATE);
				        after.clear(aCalendar.DATE);
				        before.clear(aCalendar.MONTH);
				        after.clear(aCalendar.MONTH);
						break;
						
					case "m" :
					case "month" :
						dPart = aCalendar.MONTH;
						before.clear(aCalendar.DATE);
						after.clear(aCalendar.DATE);
						break;
						
					case "w" :
					case "week" :
						dPart = aCalendar.WEEK_OF_YEAR;
						before.clear(aCalendar.DATE);
						after.clear(aCalendar.DATE);
						break;
						
					case "d" :
					case "day" :
						// very much a special case
						e = after.getTimeInMillis() + after.getTimeZone().getOffset(after.getTimeInMillis());
						s = before.getTimeInMillis() + before.getTimeZone().getOffset(before.getTimeInMillis());
						return int((e-s) / 86400000) * direction;
						break;
						
					case "h" :
					case "hr" :
					case "hour" :
						e = after.getTimeInMillis() + after.getTimeZone().getOffset(after.getTimeInMillis());
						s = before.getTimeInMillis() + before.getTimeZone().getOffset(before.getTimeInMillis());
						return int((e-s) / 3600000) * direction;
						break;
						
					case "n" :
					case "minute" :
						e = after.getTimeInMillis() + after.getTimeZone().getOffset(after.getTimeInMillis());
						s = before.getTimeInMillis() + before.getTimeZone().getOffset(before.getTimeInMillis());
						return int((e-s) / 60000) * direction;
						break;
						
					case "s" :
					case "second" :
						e = after.getTimeInMillis() + after.getTimeZone().getOffset(after.getTimeInMillis());
						s = before.getTimeInMillis() + before.getTimeZone().getOffset(before.getTimeInMillis());
						return int((e-s) / 1000) * direction;						break;
				}// datepart switch
					
				while (before.before(after)){
					before.add(dPart, 1);
					elapsed = elapsed + 1;
				} //count dateparts
				
				return elapsed * direction;
			} // if start & end times are the same
		</cfscript>
	</cffunction>
	
	<!--- remove for production? --->
	<cffunction name="dumpMe" access="public" returntype="any" output="No">
		<cfset var tmpStr = "" />
		
		<cfsavecontent variable="tmpStr">
			<cfdump var="#variables#" />
		</cfsavecontent>
		
		<cfreturn tmpStr />
	</cffunction>
</cfcomponent>