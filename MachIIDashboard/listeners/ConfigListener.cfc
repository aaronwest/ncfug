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
$Id: ConfigListener.cfc 1068 2008-09-16 04:02:20Z kurtwiersma $

Created version: 1.0.0
Updated version: 1.0.0

Notes:
--->
<cfcomponent
	displayname="FrameworkListener"
	extends="MachII.framework.Listener"	
	output="false"
	hint="Basic interface for base framework structures.">

	<!---
	PROPERTIES
	--->
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Initializes the listener.">
		<!--- Does nothing --->
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getModuleData" access="public" returntype="struct" output="false"
		hint="Gets the data for all the modules.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var modules = getAppManager().getModuleManager().getModules() />
		<cfset var moduleData = StructNew() />
		<cfset var coldspringProperty = "" />
		<cfset var i = "" />
		
		<cfloop collection="#modules#" item="i">
			<cfset moduleData[modules[i].getModuleName()]["lastReloadDateTime"] = modules[i].getModuleAppManager().getAppLoader().getLastReloadDatetime() />
			<cfset moduleData[modules[i].getModuleName()]["shouldReloadConfig"] = modules[i].getModuleAppManager().getAppLoader().shouldReloadConfig() />
			<cfset moduleData[modules[i].getModuleName()]["appManager"] = modules[i].getModuleAppManager() />
			<cfset coldspringProperty = getProperty("udfs").findPropertyByType("MachII.properties.ColdspringProperty", modules[i].getModuleAppManager().getPropertyManager()) />
			<!--- Only grab this data if this module has a ColdSpring property --->
			<cfif IsObject(coldspringProperty)>
				<cfset moduleData[modules[i].getModuleName()]["lastColdSpringReloadDateTime"] = coldspringProperty.getLastReloadDatetime() />
				<cfset moduleData[modules[i].getModuleName()]["shouldReloadColdSpringConfig"] = coldspringProperty.shouldReloadConfig() />
			</cfif>
		</cfloop>
		
		<cfreturn moduleData />
	</cffunction>
	
	<cffunction name="getBaseData" access="public" returntype="struct" output="false"
		hint="Gets the data for the base app.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var baseData = StructNew() />
		<cfset var coldspringProperty = "" />
		
		<cfset baseData["lastReloadDateTime"] = getAppManager().getParent().getAppLoader().getLastReloadDatetime() />
		<cfset baseData["shouldReloadConfig"] = getAppManager().getParent().getAppLoader().shouldReloadBaseConfig() />
		<cfset baseData["appManager"] = getAppManager().getParent() />
		<cfset coldspringProperty = getProperty("udfs").findPropertyByType("MachII.properties.ColdspringProperty", getAppManager().getParent().getPropertyManager()) />
		<cfif IsObject(coldspringProperty)>
			<cfset baseData["lastColdSpringReloadDateTime"] = coldspringProperty.getLastReloadDatetime() />
			<cfset baseData["shouldReloadColdSpringConfig"] = coldspringProperty.shouldReloadConfig() />
		</cfif>
		
		<cfreturn baseData />
	</cffunction>
	
	<cffunction name="reloadModule" access="public" returntype="void" output="false"
		hint="Reloads a module.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var moduleName = arguments.event.getArg("moduleName", "") />
		<cfset var log = getLog() />
		<cfset var tickStart = 0 />
		<cfset var tickEnd = 0 />
		<cfset var message = "" />
		
		<cfif getAppManager().getModuleManager().isModuleDefined(moduleName)>
			<cfset tickStart = getTickcount() />
			<cfset getAppManager().getModuleManager().getModule(moduleName).reloadModuleConfig() />
			<cfset tickEnd = getTickcount() />
			<cfset message = "Reloaded module '#moduleName#' in #NumberFormat(tickEnd - tickStart)#ms." />
			<cfset arguments.event.setArg("message", message) />
			<cfset log.info(message) />
		</cfif>
	</cffunction>
	
	<cffunction name="reloadBaseApp" access="public" returntype="void" output="false"
		hint="Reload the base app.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var log = getLog() />
		<cfset var tickStart = 0 />
		<cfset var tickEnd = 0 />
		<cfset var message = "" />
		
		<cfset tickStart = getTickcount() />
		<cfset getAppManager().getParent().getAppLoader().reloadConfig() />
		<cfset tickEnd = getTickcount() />
		<cfset message = "Reloaded base application in #NumberFormat(tickEnd - tickStart)#ms." />
		<cfset arguments.event.setArg("message", message) />
		<cfset log.info(message) />
	</cffunction>
	
	<cffunction name="reloadModuleColdSpring" access="public" returntype="void" output="false"
		hint="Reloads ColdSpring in a module by module name.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var moduleName = arguments.event.getArg("moduleName", "") />
		<cfset var log = getLog() />
		<cfset var tickStart = 0 />
		<cfset var tickEnd = 0 />
		<cfset var message = "" />
		
		<cfif getAppManager().getModuleManager().isModuleDefined(moduleName)>
			<cfset tickStart = getTickcount() />
			<cfset getProperty("udfs").findPropertyByType("MachII.properties.ColdspringProperty", getAppManager().getModuleManager().getModule(moduleName).getModuleAppManager().getPropertyManager()).configure() />
			<cfset tickEnd = getTickcount() />
			<cfset message = "Reloaded ColdSpring for module '#moduleName#' in #NumberFormat(tickEnd - tickStart)#ms." />
			<cfset arguments.event.setArg("message", message) />
			<cfset log.info(message) />
		</cfif>
	</cffunction>
	
	<cffunction name="reloadBaseAppColdSpring" access="public" returntype="void" output="false"
		hint="Reloads ColdSpring across the entire application.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var modules = getAppManager().getModuleManager().getModules() />
		<cfset var log = getLog() />
		<cfset var tickStart = 0 />
		<cfset var tickEnd = 0 />
		<cfset var key = "" />
		<cfset var message = "" />
		
		<cfset tickStart = getTickcount() />
		<cfset getProperty("udfs").findPropertyByType("MachII.properties.ColdspringProperty", getAppManager().getParent().getPropertyManager()).configure() />

		
		<cfloop collection="#modules#" item="key">
			<!--- Don't reload the CS for the dashboard since it will just reload the base --->
			<cfif getAppManager().getModuleName() NEQ key>
				<cfset getProperty("udfs").findPropertyByType("MachII.properties.ColdspringProperty", modules[key].getModuleAppManager().getPropertyManager()).configure() />
			</cfif>
		</cfloop>
		<cfset tickEnd = getTickcount() />
		
		<cfset message = "Reloaded ColdSpring in #tickEnd - tickStart#ms." />
		<cfset arguments.event.setArg("message", message) />
		<cfset log.info(message) />
	</cffunction>

	<cffunction name="getMemoryData" access="public" returntype="struct" output="false"
		hint="Get memory information from the JVM.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var jvm = structNew()>
		<cfset var runtime = createobject("java", "java.lang.Runtime")>
		
		<!--- //mgmtFactory = createobject("java", "java.lang.management.ManagementFactory");
		//pools = mgmtFactory.getMemoryPoolMXBeans();
		//heap = mgmtFactory.getMemoryMXBean(); --->

		<cfset jvm["JVM - Used Memory"] = runtime.getRuntime().totalMemory() - runtime.getRuntime().freeMemory() />
		<cfset jvm["JVM - Max Memory"] = runtime.getRuntime().maxMemory() />
		<cfset jvm["JVM - Free Memory"] = runtime.getRuntime().freeMemory() />
		<cfset jvm["JVM - Total Memory"] = runtime.getRuntime().totalMemory() />
		<cfset jvm["JVM - Unallocated Memory"] = runtime.getRuntime().maxMemory() - runtime.getRuntime().totalMemory() />
		<!--- /* jvm["Heap Memory Usage - Max"] = formatMB(heap.getHeapMemoryUsage().getMax());
		jvm["Heap Memory Usage - Used"] = formatMB(heap.getHeapMemoryUsage().getUsed());
		jvm["Heap Memory Usage - Committed"] = formatMB(heap.getHeapMemoryUsage().getCommitted());
		jvm["Heap Memory Usage - Initial"] = formatMB(heap.getHeapMemoryUsage().getInit());
		jvm["Non-Heap Memory Usage - Max"] = formatMB(heap.getNonHeapMemoryUsage().getMax());
		jvm["Non-Heap Memory Usage - Used"] = formatMB(heap.getNonHeapMemoryUsage().getUsed());
		jvm["Non-Heap Memory Usage - Committed"] = formatMB(heap.getNonHeapMemoryUsage().getCommitted());
		jvm["Non-Heap Memory Usage - Initial"] = formatMB(heap.getNonHeapMemoryUsage().getInit());
		for( i=1; i lte arrayLen(pools); i=i+1 ) jvm["Memory Pool - #pools[i].getName()# - Used"] = formatMB(pools[i].getUsage().getUsed());
		*/ --->
		
		<cfreturn jvm />
	</cffunction>

</cfcomponent>