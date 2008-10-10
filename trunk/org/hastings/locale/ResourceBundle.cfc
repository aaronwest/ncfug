<!---
Copyright: (c) 2006 The MachBlog Authors
Authors: Matt Woodward (mpwoodward@gmail.com) & Peter J. Farrell (pjf@maestropublishing.com)
	
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License. 
You may obtain a copy of the License at 
	
http://www.apache.org/licenses/LICENSE-2.0 
	
Unless required by applicable law or agreed to in writing, software 
distributed under the License is distributed on an "AS IS" BASIS, 
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
See the License for the specific language governing permissions and 
limitations under the License.

$Id: ResourceBundle.cfc 799 2006-06-14 03:55:05Z mpwoodward $

Notes:
Many thanks to i18n guru Paul Hastings for this contribution to the MachBlog project!
http://www.sustainablegis.com
--->
<cfcomponent displayname="ResourceBundle" output="false"
                hint="Reads and parses resource bundle per locale: version 1.0 machIIblog core java 10-jun-2006 Paul Hastings (paul@sustainbleGIS.com)">
        <cfproperty name="rbFile" type="string" required="true" />
        <cfproperty name="rbLocale" type="string" required="false" default="en_US" />
        <cfproperty name="markDebug" type="boolean" required="false" default="false" />
        
        <cffunction name="init" access="public" output="false" returntype="resourcebundle" hint="Constructor for this CFC.">
                <cfset variables.locale = createObject("java","java.util.Locale") />
                <cfset variables.msgFormat = createObject("java", "java.text.MessageFormat") />
                
                <cfreturn this />
        </cffunction>
        
        <cffunction name="setRbFile" access="public" output="false" returntype="void">
                <cfargument name="rbFile" type="string" required="true" />
                <cfset variables.rbFile = arguments.rbFile />
        </cffunction>
        <cffunction name="getRbFile" access="public" output="false" returntype="string">
                <cfreturn variables.rbFile />
        </cffunction>
        
        <cffunction name="setRbLocale" access="public" output="false" returntype="void">
                <cfargument name="rbLocale" type="string" required="true" />
                <cfset variables.rbLocale = arguments.rbLocale />
        </cffunction>
        <cffunction name="getRbLocale" access="public" output="false" returntype="string">
                <cfreturn variables.rbLocale />
        </cffunction>
        
        <cffunction name="setMarkDebug" access="public" output="false" returntype="void">
                <cfargument name="markDebug" type="boolean" required="true" />
                <cfset variables.markDebug = arguments.markDebug />
        </cffunction>
        <cffunction name="getMarkDebug" access="public" output="false" returntype="boolean">
                <cfreturn variables.markDebug />
        </cffunction>
        
        <cffunction name="getResource" access="public" output="false" returntype="string" 
                        hint="Returns bundle.X, if it exists, and optionally wraps it with * if debug mode.">
                <cfargument name="resource" type="string" required="true" />
                <cfargument name="markDebug" required="No" type="boolean" default="false" />
                
                <cfset var val = "">
                
                <cfif not isDefined("variables.resourceBundle")>
                        <cfthrow message="Fatal error: resource bundle not loaded." />
                </cfif>
                
                <cfif not structKeyExists(variables.resourceBundle, arguments.resource)>
                        <cfset val = "_ResourceBundleKeyNotFound_" />
                <cfelse>
                        <cfset val = variables.resourceBundle[arguments.resource] />
                </cfif>
                
                <cfif arguments.markDebug>
                        <cfset val = "***"&val&"***" />
                </cfif>
                
                <cfreturn val />
        </cffunction>
        
        <cffunction access="public" name="getResourceBundle" output="No" returntype="struct" hint="reads and parses java resource bundle per locale">
                <cfargument name="rbFile" required="Yes" type="string" />
                <cfargument name="rbLocale" required="No" type="string" default="en_US" />
                <cfargument name="markDebug" required="No" type="boolean" default="false" />
                
                <cfset var isOk = false /> <!--- success flag --->
                <cfset var rbIndx = "" /> <!--- var to hold rb keys --->
                <cfset var resourceBundle = structNew() /> <!--- structure to hold resource bundle --->
                <cfset var thisLang = listFirst(arguments.rbLocale,"_") />
                <cfset var thisDir = GetDirectoryFromPath(arguments.rbFile) />
                <cfset var thisFile = getFileFromPath(arguments.rbFile) & ".properties" />
                <cfset var thisRBfile = thisDir & listFirst(thisFile,".") & "_" & arguments.rbLocale & "." & listLast(thisFile,".") />
                
                <cfif NOT fileExists(thisRBfile)> <!--- try just the language --->
                        <cfset thisRBfile = thisDir & listFirst(thisFile,".") & "_" & thisLang & "." & listLast(thisFile,".") />
                </cfif>
                
                <cfif NOT fileExists(thisRBfile)> <!--- still nothing? strip thisRBfile back to base rb --->
                        <cfset thisRBfile = arguments.rbFile & ".properties" />
                </cfif>
                
                <cfif fileExists(thisRBFile)>
                        <cfset isOK = true>
                        <cffile action="read" file="#thisRBfile#" variable="resourceBundleFile" charset="utf-8" />
                        
                        <cfloop index="rbIndx" list="#resourceBundleFile#" delimiters="#chr(10)#">
                                <cfif len(trim(rbIndx)) and left(rbIndx,1) NEQ "##">
                                        <cfif NOT arguments.markDebug>
                                                <cfset resourceBundle[trim(listFirst(rbIndx,"="))] = trim(listRest(rbIndx,"=")) />
                                        <cfelse>
                                                <cfset resourceBundle[trim(listFirst(rbIndx,"="))] = "***" & trim(listRest(rbIndx,"=")) & "***" />
                                        </cfif>
                                </cfif>
                        </cfloop>
                </cfif>
                
                <cfif isOK>
                        <cfreturn resourceBundle>
                <cfelse>
                        <cfthrow message="Fatal error: resource bundle #thisRBfile# not found.">
                </cfif>
        </cffunction> 
        
        <cffunction name="loadResourceBundle" access="public" output="false" returnType="void" hint="Loads a bundle.">
                <cfargument name="rbFile" type="string" required="false" default="#getRbFile()#" 
                                hint="This must be the path + filename UP to but NOT including the locale. We auto-add .properties to the end." />
                <cfargument name="rbLocale" type="string" required="false" default="#getRbLocale()#" />
                <cfset variables.resourceBundle = getResourceBundle(ExpandPath(arguments.rbFile), arguments.rbLocale) />
        </cffunction>
        
        <cffunction name="messageFormat" access="public" output="no" returnType="string" hint="performs messageFormat on compound rb string">
                <cfargument name="thisPattern" required="yes" type="string" hint="pattern to use in formatting" />
                <cfargument name="args" required="yes" hint="substitution values" /> <!--- array or single value to format --->
                <cfargument name="thisLocale" required="no" default="en_US" hint="locale to use in formatting, defaults to en_US" />
                
                <cfset var pattern = createObject("java","java.util.regex.Pattern") />
                <cfset var regexStr = "(\{[0-9]{1,},number.*?\})" />
                <cfset var p = "" />
                <cfset var m = "" />
                <cfset var i = 0 />
                <cfset var thisFormat = "" />
                <cfset var inputArgs = arguments.args />
                <cfset var lang = "" />
                <cfset var country = "" />
                <cfset var variant = "" />
                <cfset var tLocale = "" />
                
                <cftry>
                        <cfset lang = listFirst(arguments.thisLocale, "_") />
                        <cfset country = listGetAt(arguments.thisLocale, 2, "_") />
                        <cfset variant = listLast(arguments.thisLocale, "_") />
                        <cfset tLocale = variables.locale.init(lang, country, variant) />
                        
                        <cfif NOT isArray(inputArgs)>
                                <cfset inputArgs = listToArray(inputArgs) />
                        </cfif>
                                
                        <cfset thisFormat = variables.msgFormat.init(arguments.thisPattern, tLocale) />
                        <!--- let's make sure any cf numerics are cast to java datatypes --->
                        <cfset p = pattern.compile(regexStr, pattern.CASE_INSENSITIVE) />
                        <cfset m = p.matcher(arguments.thisPattern) />
                        
                        <cfloop condition="#m.find()#">
                                <cfset i = listFirst(replace(m.group(), "{", "")) />
                                <cfset inputArgs[i] = javacast("float", inputArgs[i]) />
                        </cfloop>
                        
                        <cfset arrayPrepend(inputArgs, "")> <!--- dummy element to fool java --->
                        <!--- coerece to a java array of objects  --->
                        <cfreturn thisFormat.format(inputArgs.toArray()) />
                        <cfcatch type="Any">
                                <cfthrow message="#cfcatch.message#" type="any" detail="#cfcatch.detail#" />
                        </cfcatch>
                </cftry>
        </cffunction>
        
    <cffunction name="verifyPattern" access="public" output="no" returnType="boolean" hint="performs verification on MessageFormat pattern">
		<cfargument name="pattern" required="yes" type="string" hint="format pattern to test" />
            <cfscript>
                    var test = "";
                    var isOK = true;
                    try { 
                            test = msgFormat.init(arguments.pattern);                       
                    }
                    catch (Any e) {
                            isOK = false;
                    }
                    return isOk;
		</cfscript>             
	</cffunction>
</cfcomponent>