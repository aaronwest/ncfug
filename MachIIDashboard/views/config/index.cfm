<cfsilent>
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
$Id: index.cfm 1077 2008-09-22 18:52:43Z peterfarrell $

Created version: 1.0.0
Updated version: 1.0.0

Notes:
--->
<cfset variables.modules = event.getArg("moduleData") />
<cfset variables.moduleOrder = StructKeyArray(variables.modules) />
<cfset ArraySort(variables.moduleOrder, "textnocase", "asc") />
<cfset variables.base = event.getArg("baseData") />

<cfset variables.memoryData = event.getArg("memoryData") />
</cfsilent>
<cfoutput>
<h1>Configuration Files Status</h1>

<cfif event.isArgDefined("message")>
<div class="error">
	<p>#event.getArg("message")#</p>
</div>
</cfif>

<ul class="pageNavTabs">
	<li>
		<a href="#buildUrl("config.reloadBaseApp")#">
			<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@arrow_rotate_clockwise.png")#" width="16" height="16" alt="Disabled" />
			&nbsp;Reload All Mach-II
		</a>
	</li>
<cfif StructKeyExists(variables.base, "lastColdSpringReloadDateTime")>
	<li>
		<a href="#buildUrl("config.reloadBaseAppColdSpring")#">
			<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@arrow_rotate_clockwise.png")#" width="16" height="16" alt="Disabled" />
			&nbsp;Reload All ColdSpring
		</a>
	</li>
</cfif>
	<li>
		<a href="#BuildUrl("config.index")#">
			<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@arrow_rotate_clockwise.png")#" width="16" height="16" alt="Flush All" />
			&nbsp;Refresh Stats
		</a>
	</li>
</ul>

<table>
	<tr>
		<th style="width:30%;"><h3>Module</h3></th>
		<th style="width:35%;"><h3>Mach-II</h3></th>
		<th style="width:35%;"><h3>ColdSpring</h3></th>
	</tr>
	<tr>
		<td>
			<h4>Base</h4>
			<p class="small">
				<a href="#BuildUrlToModule("", variables.base.appManager.getPropertyManager().getProperty("defaultEvent"))#">
					<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@link_go.png")#" width="16" height="16" alt="Link" />
					go to default event
				</a>
			</p>
		</td>
		<td>
			<p>
				<a href="#buildUrl("config.reloadBaseApp")#">
				<cfif variables.base.shouldReloadConfig>
					<span class="red">
						<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@exclamation.png")#" width="16" height="16" alt="Reload" />
						&nbsp;reloaded #getProperty("udfs").datetimeDifferenceString(variables.base.lastReloadDateTime)# ago
					</span>
				<cfelse>
					<span class="green">
					<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@tick.png")#" width="16" height="16" alt="OK" />
					&nbsp;OK
					</span>
				</cfif>
				</a>
			</p>
		</td>
	<cfif StructKeyExists(variables.base, "lastColdSpringReloadDateTime")>
		<td>
			<p>
				<a href="#buildUrl("config.reloadBaseAppColdSpring")#">
					<cfif variables.base.shouldReloadColdSpringConfig>
						<span class="red">
							<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@exclamation.png")#" width="16" height="16" alt="Reload" />
							&nbsp;reloaded #getProperty("udfs").datetimeDifferenceString(variables.base.lastColdSpringReloadDateTime)# ago
						</span>
					<cfelse>
						<span class="green">
							<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@tick.png")#" width="16" height="16" alt="OK" />
							&nbsp;OK
						</span>
					</cfif>
				</a>
			</p>
		</td>
	<cfelse>
		<td>
			<p>n/a</p>
		</td>
	</cfif>
	</tr>
<cfloop from="1" to="#ArrayLen(variables.moduleOrder)#" index="i">
	<tr <cfif i MOD 2>class="shade"</cfif>>
		<td>
			<h4>#UCase(Left(variables.moduleOrder[i], 1))##Right(variables.moduleOrder[i], Len(variables.moduleOrder[i]) -1)#</h4>
		<cfif getAppManager().getModuleName() NEQ variables.moduleOrder[i]>
			<p class="small">
				<a href="#BuildUrlToModule(variables.moduleOrder[i], variables.modules[variables.moduleOrder[i]].appManager.getPropertyManager().getProperty("defaultEvent"))#">
					<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@link_go.png")#" width="16" height="16" alt="Link" />
					go to default event
				</a>
			</p>
		<cfelse>
			<p>&nbsp;</p>
		</cfif>
		</td>
		<td>
			<p>
				<a href="#buildUrl("config.reloadModule", "moduleName=#variables.moduleOrder[i]#")#">
				<cfif variables.modules[variables.moduleOrder[i]].shouldReloadConfig>
					<span class="red">
						<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@exclamation.png")#" width="16" height="16" alt="Reload" />
						&nbsp;reloaded #getProperty("udfs").datetimeDifferenceString(variables.modules[variables.moduleOrder[i]].lastReloadDateTime)# ago
					</span>
				<cfelse>
					<span class="green">
						<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@tick.png")#" width="16" height="16" alt="OK" />
						&nbsp;OK
					</span>
				</cfif>
				</a>
			</p>
		</td>
	<cfif StructKeyExists(variables.modules[variables.moduleOrder[i]], "lastColdSpringReloadDateTime")>
		<td>
			<p>
				<a href="#buildUrl("config.reloadModuleColdSpring", "moduleName=#variables.moduleOrder[i]#")#">
					<cfif variables.modules[variables.moduleOrder[i]].shouldReloadColdSpringConfig>
						<span class="red">
							<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@exclamation.png")#" width="16" height="16" alt="Reload" />
							&nbsp;reloaded #getProperty("udfs").datetimeDifferenceString(variables.modules[variables.moduleOrder[i]].lastColdSpringReloadDateTime)# ago
						</span>
					<cfelse>
						<span class="green">
						<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@tick.png")#" width="16" height="16" alt="OK" />
						&nbsp;OK
						</span>
					</cfif>
				</a>
			</p>

		</td>
	<cfelse>
		<td>
			<p>n/a</p>
		</td>
	</cfif>
	</tr>
</cfloop>
</table>

<div class="twoColumn" style="margin-top:24px;">
	<div class="left" style="width:454px;">
		<table>
			<tr>
				<th colspan="2"><h3>CFML Server Information</h3></th>
			</tr>
			<tr>
				<td style="width:30%;"><h4>Vendor</h4></td>
				<td style="width:70%;"><p>#server.ColdFusion.ProductName#</p></td>
			</tr>
			<tr class="shade">
				<td><h4>Version</h4></td>
				<td><p>#server.ColdFusion.ProductVersion#</p></td>
			</tr>
			<tr>
				<td><h4>Version Level</h4></td>
				<td><p>#server.ColdFusion.ProductLevel#</p></td>
			</tr>
			<tr class="shade">
				<td><h4>Application Server</h4></td>
				<td><p>#server.ColdFusion.Appserver#</p></td>
			</tr>
			<tr>
				<td>
					<h4>
						<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@instance.png")#" width="16" height="16" alt="Instance Name" title="Instance Name" />
						 Instance Name
					</h4>
				</td>
				<td>
					<cfset sys = createObject("java", "java.lang.System") />
					<p>#sys.getProperty("jrun.server.name")#</p>
				</td>
			</tr>
		</table>
		
		<table style="margin-top:24px;">
			<tr>
				<th colspan="2"><h3>Server Information</h3></th>
			</tr>
			<tr>
				<td style="width:30%;">
					<h4>
						<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@world_link.png")#" width="16" height="16" alt="Domain Name" title="Domain Name" />
						 Domain Name
					</h4>
				</td>
				<td style="width:70%;"><p>#cgi.server_name#</p></td>
			</tr>
			<tr class="shade">
				<td>
					<h4>
						<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@server.png")#" width="16" height="16" alt="Machine Name" title="Machine Name" />
						Machine Name
					</h4>
				</td>
				<td><p>#CreateObject("java", "java.net.InetAddress").getLocalHost().getHostName()#</p></td>
			</tr>
		</table>

		<table style="margin-top:24px;">
			<tr>
				<th colspan="2"><h3>Application Information</h3></th>
			</tr>
			<tr>
				<td style="width:30%;">
					<h4>
						<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@application.png")#" width="16" height="16" alt="Application Name" title="Application Name" />
						 Application Name
					</h4>
				</td>
				<td style="width:70%;"><p>#application.applicationname#</p></td>
			</tr>
			<tr class="shade">
				<td>
					<h4>
						<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@application_key.png")#" width="16" height="16" alt="Application Key" title="Application Key" />
						Mach-II App Key
					</h4>
				</td>
				<td><p>#getAppManager().getAppKey()#</p></td>
			</tr>
		</table>
		
		<table style="margin-top:24px;">
			<tr>
				<th colspan="2"><h3>Mach-II Information</h3></th>
			</tr>
			<tr>
				<td style="width:30%;"><h4>Version</h4></td>
				<td style="width:70%;"><p>#getProperty("udfs").getMachIIVersionString()#</p></td>
			</tr>
			<tr class="shade">
				<td><h4>Threading</h4></td>
				<td><p>#YesNoFormat(getAppManager().getUtils().createThreadingAdapter().allowThreading())#</p></td>
			</tr>
			<tr>
				<td><h4>Persist Scope</h4></td>
				<td><p>#getProperty("redirectPersistScope")#</p></td>
			</tr>
			<tr class="shade">
				<td><h4>Persist Parameter</h4></td>
				<td><p>#getProperty("redirectPersistParameter")#</p></td>
			</tr>
		</table>
	</div>
	<div class="right" style="width:454px;">
		<table>
			<tr>
				<th colspan="3"><h3>JVM Memory Information^</h3></th>
			</tr>
			<tr>
				<td colspan="3">
					<cfchart format="png" 
						show3d="true" 
						chartwidth="435" 
						chartheight="435" 
						pieslicestyle="sliced"
						tipstyle="none"  
						title="Memory Usage (in MB)">
						<cfchartseries type="pie" 
							colorList="green,red,blue,yellow,aqua" 
							paintstyle="light" >
							<cfchartdata item="Free Memory" 
								value="#getProperty("udfs").byteConvert(memoryData["JVM - Free Memory"], "MB", false)#" />
							<cfchartdata item="Used Memory" 
								value="#getProperty("udfs").byteConvert(memoryData["JVM - Used Memory"], "MB", false)#" />
							<cfchartdata item="Unallocated Memory" 
								value="#getProperty("udfs").byteConvert(memoryData["JVM - Unallocated Memory"], "MB", false)#" />
						</cfchartseries>
					</cfchart>
				</td>
			</tr>
			<tr>
				<td style="width:33%;">
					<h4>Allocated</h4>
				</td>
				<td style="width:33%;">
					<p>#getProperty("udfs").formatMB(memoryData["JVM - Total Memory"])#</p>
				</td>
				<td style="width:33%;">
					<p>#getProperty("udfs").getPercentage(memoryData["JVM - Total Memory"], memoryData["JVM - Max Memory"], "1")#%</p>
				</td>
			</tr>
			<tr class="shade">
				<td>
					<p class="small"><strong>Used Allocated</strong></p>
					<p class="small"><strong>Free Allocated</strong></p>
				</td>
				<td>
					<p class="small">#getProperty("udfs").formatMB(memoryData["JVM - Used Memory"])#</p>	
					<p class="small">#getProperty("udfs").formatMB(memoryData["JVM - Free Memory"])#</p>
				</td>
				<td>
					<p class="small">#getProperty("udfs").getPercentage(memoryData["JVM - Used Memory"], memoryData["JVM - Total Memory"], "1")#% of Allocated</p>
					<p class="small">#getProperty("udfs").getPercentage(memoryData["JVM - Free Memory"], memoryData["JVM - Total Memory"], "1")#% of Allocated</p>
				</td>
			</tr>
			<tr>
				<td><h4>Unallocated</h4></td>
				<td><p>#getProperty("udfs").formatMB(memoryData["JVM - Unallocated Memory"])#</p></td>
				<td><p>#getProperty("udfs").getPercentage(memoryData["JVM - Unallocated Memory"], memoryData["JVM - Max Memory"], "1")#%</p></td>
			</tr>
			<tr class="shade">
				<td><h4>Max</h4></td>
				<td><p>#getProperty("udfs").formatMB(memoryData["JVM - Max Memory"])#</p></td>
				<td><p>100%</p></td>
			</tr>
		</table>
		<p class="small">^ Totals and percents may not add up exactly due to rounding</p>
	</div>
</div>

<!--- <cfdump var="#sys.getProperties()#" label="sys.getProperties()" /> --->

</cfoutput>