<!---
License:
Copyright 2008 GreatBizTools, LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Copyright: GreatBizTools, LLC
Author: Peter J. Farrell (peter@mach-ii.com)
$Id: CommandLoaderBase.cfc 1078 2008-09-23 01:30:15Z peterfarrell $

Created version: 1.5.0
Updated version: 1.6.0

Notes:
--->
<cfcomponent 
	displayname="CommandLoaderBase"
	output="false"
	hint="Base component to load commands for the framework.">
	
	<!---
	PROPERTIES
	--->
	<cfset variables.beanUtil = "" />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="void" output="false"
		hint="Initialization function called by the framework.">
		<cfset variables.beanUtil = CreateObject("component", "MachII.util.BeanUtil").init() />
	</cffunction>
		
	<!---
	PROTECTED FUNCTIONS
	--->
	<cffunction name="createCommand" access="private" returntype="MachII.framework.Command" output="false"
		hint="Loads and instantiates a command from an XML fragment.">
		<cfargument name="commandNode" type="any" required="true" />
		<cfargument name="parentHandlerName" type="string" required="false" default="" />
		<cfargument name="parentHandlerType" type="string" required="false" default="" />
		
		<cfset var command = "" />

		<!--- Optimized: If/elseif blocks are faster than switch/case --->
		<!--- view-page --->
		<cfif arguments.commandNode.xmlName EQ "view-page">
			<cfset command = setupViewPage(arguments.commandNode) />
		<!--- notify --->
		<cfelseif arguments.commandNode.xmlName EQ "notify">
			<cfset command = setupNotify(arguments.commandNode) />
		<!--- announce --->
		<cfelseif arguments.commandNode.xmlName EQ "announce">
			<cfset command = setupAnnounce(arguments.commandNode) />
		<!--- publish --->
		<cfelseif arguments.commandNode.xmlName EQ "publish">
			<cfset command = setupPublish(arguments.commandNode) />
		<!--- event-mapping --->
		<cfelseif arguments.commandNode.xmlName EQ "event-mapping">
			<cfset command = setupEventMapping(arguments.commandNode) />
		<!--- execute --->
		<cfelseif arguments.commandNode.xmlName EQ "execute">
			<cfset command = setupExecute(arguments.commandNode) />
		<!--- filter --->
		<cfelseif arguments.commandNode.xmlName EQ "filter">
			<cfset command = setupFilter(arguments.commandNode) />
		<!--- event-bean --->
		<cfelseif arguments.commandNode.xmlName EQ "event-bean">
			<cfset command = setupEventBean(arguments.commandNode) />
		<!--- redirect --->
		<cfelseif arguments.commandNode.xmlName EQ "redirect">
			<cfset command = setupRedirect(arguments.commandNode) />
		<!--- event-arg --->
		<cfelseif arguments.commandNode.xmlName EQ "event-arg">
			<cfset command = setupEventArg(arguments.commandNode) />
		<!--- cache --->
		<cfelseif arguments.commandNode.xmlName EQ "cache">
			<cfset command = setupCache(arguments.commandNode, parentHandlerName, parentHandlerType) />
		<!--- cacheclear --->
		<cfelseif arguments.commandNode.xmlName EQ "cache-clear">
			<cfset command = setupCacheClear(arguments.commandNode) />
		<!--- default/unrecognized command --->
		<cfelse>
			<cfset command = setupDefault(arguments.commandNode) />
		</cfif>
		
		<cfreturn command />
	</cffunction>
	
	<cffunction name="setupCache" access="private" returntype="MachII.framework.commands.CacheCommand" output="false"
		hint="Sets up a cache command.">
		<cfargument name="commandNode" type="any" required="true" />
		<cfargument name="parentHandlerName" type="string" required="false" default="" />
		<cfargument name="parentHandlerType" type="string" required="false" default="" />
		
		<cfset var command = "" />
		<cfset var cacheAlias = "" />
		<cfset var handlerId = "" />
		<cfset var criteria = "" />
		<cfset var name = "" />
		
		<cfset handlerId = getAppManager().getCacheManager().loadCacheHandlerFromXml(commandNode, parentHandlerName, parentHandlerType) />
		
		<cfif StructKeyExists(arguments.commandNode, "xmlAttributes") >
			<!--- We cannot get the default cache strategy name because it has not been set
				by the CachingProperty yet. We deal with getting the default cache strategy
				in the configu() method of the CachingManager. --->
			<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "name")>
				<cfset name = arguments.commandNode.xmlAttributes["name"] />
			</cfif>
			<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "alias")>
				<cfset cacheAlias = arguments.commandNode.xmlAttributes["alias"] />
			</cfif>
			<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "criteria")>
				<cfset criteria = arguments.commandNode.xmlAttributes["criteria"] />
			</cfif>
		</cfif>
		
		<cfset command = CreateObject("component", "MachII.framework.commands.CacheCommand").init(handlerId, name, cacheAlias, criteria) />
		<cfset command.setLog(getAppManager().getLogFactory()) />
		
		<cfreturn command />
	</cffunction>
	
	<cffunction name="setupCacheClear" access="private" returntype="MachII.framework.commands.CacheClearCommand" output="false"
		hint="Sets up a CacheClear command.">
		<cfargument name="commandNode" type="any" required="true" />
		
		<cfset var command = "" />
		<cfset var cacheAlias = "" />
		<cfset var cacheCondition = "" />
		<cfset var name = "" />
		<cfset var criteria = "" />
		<cfset var id = "" />
		
		<cfif StructKeyExists(arguments.commandNode, "xmlAttributes")>
			<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "alias")>
				<cfset cacheAlias = arguments.commandNode.xmlAttributes["alias"] />	
			</cfif>		
			<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "condition")>
				<cfset cacheCondition = arguments.commandNode.xmlAttributes["condition"] />	
			</cfif>	
			<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "criteria")>
				<cfset criteria = arguments.commandNode.xmlAttributes["criteria"] />
			</cfif>
			<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "name")>
				<cfset name = arguments.commandNode.xmlAttributes["name"] />
			</cfif>
			<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "id")>
				<cfset id = arguments.commandNode.xmlAttributes["id"] />	
			</cfif>	
		</cfif>

		<cfset command = CreateObject("component", "MachII.framework.commands.CacheClearCommand").init(
			name, cacheAlias, cacheCondition, criteria, id) />
		<cfset command.setLog(getAppManager().getLogFactory()) />
		
		<cfreturn command />
	</cffunction>
	
	<cffunction name="setupViewPage" access="private" returntype="MachII.framework.commands.ViewPageCommand" output="false"
		hint="Sets up a view-page command.">
		<cfargument name="commandNode" type="any" required="true" />
		
		<cfset var command = "" />
		<cfset var viewName = arguments.commandNode.xmlAttributes["name"] />
		<cfset var contentKey = "" />
		<cfset var contentArg = "" />
		<cfset var appendContent = "" />
		
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "contentKey")>
			<cfset contentKey = commandNode.xmlAttributes["contentKey"] />
		</cfif>
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "contentArg")>
			<cfset contentArg = commandNode.xmlAttributes["contentArg"] />
		</cfif>
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "append")>
			<cfset appendContent = arguments.commandNode.xmlAttributes["append"] />
		</cfif>
		
		<cfset command = CreateObject("component", "MachII.framework.commands.ViewPageCommand").init(viewName, contentKey, contentArg, appendContent) />
		
		<cfreturn command />
	</cffunction>

	<cffunction name="setupNotify" access="private" returntype="MachII.framework.commands.NotifyCommand" output="false"
		hint="Sets up a notify command.">
		<cfargument name="commandNode" type="any" required="true" />
		
		<cfset var command = "" />
		<cfset var notifyListener = arguments.commandNode.xmlAttributes["listener"] />
		<cfset var notifyMethod = arguments.commandNode.xmlAttributes["method"] />
		<cfset var notifyResultKey = "" />
		<cfset var notifyResultArg = "" />
		<cfset var listener = getAppManager().getListenerManager().getListener(notifyListener) />
		
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "resultKey")>
			<cfset notifyResultKey = arguments.commandNode.xmlAttributes["resultKey"] />
		</cfif>
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "resultArg")>
			<cfset notifyResultArg = arguments.commandNode.xmlAttributes["resultArg"] />
		</cfif>
		
		<cfset command = CreateObject("component", "MachII.framework.commands.NotifyCommand").init(listener, notifyMethod, notifyResultKey, notifyResultArg) />
		
		<cfreturn command />
	</cffunction>
	
	<cffunction name="setupPublish" access="private" returntype="MachII.framework.commands.PublishCommand" output="false"
		hint="Sets up a publish command.">
		<cfargument name="commandNode" type="any" required="true" />
		
		<cfset var command = "" />
		<cfset var message = arguments.commandNode.xmlAttributes["message"] />
		<cfset var messageHandler = getAppManager().getMessageManager().getMessageHandler(message) />
		
		<cfset command = CreateObject("component", "MachII.framework.commands.PublishCommand").init(message, messageHandler) />
		
		<cfreturn command />
	</cffunction>
	
	<cffunction name="setupAnnounce" access="private" returntype="MachII.framework.commands.AnnounceCommand" output="false"
		hint="Sets up an announce command.">
		<cfargument name="commandNode" type="any" required="true" />
		
		<cfset var command = "" />
		<cfset var eventName = arguments.commandNode.xmlAttributes["event"] />
		<cfset var copyEventArgs = true />
		<cfset var moduleName = "" />
		
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "copyEventArgs")>
			<cfset copyEventArgs = arguments.commandNode.xmlAttributes["copyEventArgs"] />
		</cfif>
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "module")>
			<cfset moduleName = arguments.commandNode.xmlAttributes["module"] />
		<cfelse>
			<cfset moduleName = getAppManager().getModuleName() />
		</cfif>
		
		<cfset command = CreateObject("component", "MachII.framework.commands.AnnounceCommand").init(eventName, copyEventArgs, moduleName) />
		
		<cfreturn command />
	</cffunction>
	
	<cffunction name="setupEventMapping" access="private" returntype="MachII.framework.commands.EventMappingCommand" output="false"
		hint="Sets up an event-mapping command.">
		<cfargument name="commandNode" type="any" required="true" />
		
		<cfset var command = "" />
		<cfset var eventName = arguments.commandNode.xmlAttributes["event"] />
		<cfset var mappingName = arguments.commandNode.xmlAttributes["mapping"] />
		<cfset var mappingModule = "" />
		
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "mappingModule")>
			<cfset mappingModule = arguments.commandNode.xmlAttributes["mappingModule"] />
		<cfelse>
			<cfset mappingModule = getAppManager().getModuleName() />
		</cfif>
		
		<cfset command = CreateObject("component", "MachII.framework.commands.EventMappingCommand").init(eventName, mappingName, mappingModule) />
		
		<cfreturn command />
	</cffunction>
	
	<cffunction name="setupExecute" access="private" returntype="MachII.framework.commands.ExecuteCommand" output="false"
		hint="Sets up an execute command.">
		<cfargument name="commandNode" type="any" required="true" />
		
		<cfset var command = "" />
		<cfset var subroutine = arguments.commandNode.xmlAttributes["subroutine"] />
		
		<cfset command = CreateObject("component", "MachII.framework.commands.ExecuteCommand").init(subroutine) />
		
		<cfreturn command />
	</cffunction>
	
	<cffunction name="setupFilter" access="private" returntype="MachII.framework.commands.FilterCommand" output="false"
		hint="Sets up a filter command.">
		<cfargument name="commandNode" type="any" required="true" />
		
		<cfset var command = "" />
		<cfset var filterName = arguments.commandNode.xmlAttributes["name"] />
		<cfset var filterParams = StructNew() />
		<cfset var paramNodes = arguments.commandNode.xmlChildren />
		<cfset var paramName = "" />
		<cfset var paramValue = "" />
		<cfset var filter = getAppManager().getFilterManager().getFilter(filterName) />
		<cfset var i = "" />

		<cfloop from="1" to="#ArrayLen(paramNodes)#" index="i">
			<cfset paramName = paramNodes[i].xmlAttributes["name"] />
			<cfif NOT StructKeyExists(paramNodes[i].xmlAttributes, "value")>
				<cfset paramValue = getAppManager().getUtils().recurseComplexValues(paramNodes[i]) />
			<cfelse>
				<cfset paramValue = paramNodes[i].xmlAttributes["value"] />
			</cfif>
			<cfset filterParams[paramName] = paramValue />
		</cfloop>

		<cfset command = CreateObject("component", "MachII.framework.commands.FilterCommand").init(filter, filterParams) />
		
		<cfreturn command />
	</cffunction>
	
	<cffunction name="setupEventBean" access="private" returntype="MachII.framework.commands.EventBeanCommand" output="false"
		hint="Sets up a event-bean command.">
		<cfargument name="commandNode" type="any" required="true" />
		
		<cfset var command = "" />
		<cfset var beanName = arguments.commandNode.xmlAttributes["name"] />
		<cfset var beanType = arguments.commandNode.xmlAttributes["type"] />
		<cfset var beanFields = "" />
		<cfset var reinit = true />
		
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "fields")>
			<cfset beanFields = arguments.commandNode.xmlAttributes["fields"] />
		</cfif>
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "reinit")>
			<cfset reinit = arguments.commandNode.xmlAttributes["reinit"] />
		</cfif>
		
		<cfset command = CreateObject("component", "MachII.framework.commands.EventBeanCommand").init(beanName, beanType, beanFields, reinit, variables.beanUtil) />
		
		<cfset command.setLog(getAppManager().getLogFactory()) />

		<cfreturn command />
	</cffunction>
	
	<cffunction name="setupRedirect" access="private" returntype="MachII.framework.commands.RedirectCommand" output="false"
		hint="Sets up a redirect command.">
		<cfargument name="commandNode" type="any" required="true" />
		
		<cfset var command = "" />
		<cfset var eventName = "" />
		<cfset var redirectUrl = getAppManager().getPropertyManager().getProperty("urlBase", "index.cfm") />
		<cfset var moduleName = "" />
		<cfset var args = "" />
		<cfset var persist = false />
		<cfset var persistArgs = "" />
		<cfset var statusType = "temporary" />
		<cfset var eventParameter = getAppManager().getPropertyManager().getProperty("eventParameter", "event") />
		<cfset var redirectPersistParameter = getAppManager().getPropertyManager().getProperty("redirectPersistParameter", "persistId") /> />
		
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "event")>
			<cfset eventName = arguments.commandNode.xmlAttributes["event"] />
		</cfif>
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "url")>
			<cfset redirectUrl = arguments.commandNode.xmlAttributes["url"] />
		</cfif>
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "args")>
			<cfset args = arguments.commandNode.xmlAttributes["args"] />
		</cfif>
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "persist")>
			<cfset persist = arguments.commandNode.xmlAttributes["persist"] />
		</cfif>
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "persistArgs")>
			<cfset persistArgs = arguments.commandNode.xmlAttributes["persistArgs"] />
		</cfif>
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "module")>
			<cfset moduleName = arguments.commandNode.xmlAttributes["module"] />
		<cfelse>
			<cfset moduleName = getAppManager().getModuleName() />
		</cfif>
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "statusType")>
			<cfset statusType = arguments.commandNode.xmlAttributes["statusType"] />
		</cfif>
		
		<cfset command = CreateObject("component", "MachII.framework.commands.RedirectCommand").init(eventName, eventParameter, redirectPersistParameter, moduleName, redirectUrl, args, persist, persistArgs, statusType) />
		
		<cfset command.setLog(getAppManager().getLogFactory()) />
		
		<cfreturn command />
	</cffunction>
	
	<cffunction name="setupEventArg" access="private" returntype="MachII.framework.commands.EventArgCommand" output="false"
		hint="Sets up an event-arg command.">
		<cfargument name="commandNode" type="any" required="true" />
		
		<cfset var command = "" />
		<cfset var argValue = "" />
		<cfset var argVariable = "" />
		<cfset var overwrite = true />
		<cfset var argName = arguments.commandNode.xmlAttributes["name"] />
		
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "value")>
			<cfset argValue = arguments.commandNode.xmlAttributes["value"] />
		</cfif>
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "variable")>
			<cfset argVariable = arguments.commandNode.xmlAttributes["variable"] />
		</cfif>
		<cfif StructKeyExists(arguments.commandNode.xmlAttributes, "overwrite")>
			<cfset overwrite = arguments.commandNode.xmlAttributes["overwrite"] />
		</cfif>
		
		<cfset command = CreateObject("component", "MachII.framework.commands.EventArgCommand").init(argName, argValue, argVariable, overwrite) />
		
		<cfset command.setLog(getAppManager().getLogFactory()) />
		
		<cfreturn command />
	</cffunction>
	
	<cffunction name="setupDefault" access="private" returntype="MachII.framework.Command" output="false"
		hint="Sets up a default command.">
		<cfargument name="commandNode" type="any" required="true" />
		
		<cfset var command = CreateObject("component", "MachII.framework.Command").init() />
		
		<cfset command.setParameter("commandName", arguments.commandNode.xmlName) />
		<cfset command.setLog(getAppManager().getLogFactory()) />
		
		<cfreturn command />
	</cffunction>
	
</cfcomponent>