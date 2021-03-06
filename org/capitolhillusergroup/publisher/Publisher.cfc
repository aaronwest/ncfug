<cfcomponent
	displayname="Publisher"
	output="false"
	hint="A bean which models the Publisher form.">

<!--- This bean was generated by the Rooibos Generator with the following template:
Bean Name: Book
Path to Bean: Book
Extends: 
Call super.init(): false
Create cfproperties: false
Bean Template:
	bookID string 
	title string 
	authors array #arrayNew(1)#
	publisher org.capitolhillusergroup.publisher.Publisher #createOject('component', 'org.capitolhillusergroup.publisher.Publisher').init()#
	publicationYear numeric 0
	isbn string 
	numPages numeric 0
	price numeric 0
	url string 
	coverImageSmall string 
	coverImageLarge string 
	audit org.capitolhillusergroup.audit.Audit #createObject('component', 'org.capitolhillusergroup.audit.Audit').init()#
Create getMemento method: false
Create setMemento method: false
Create setStepInstance method: false
Create validate method: false
Create validate interior: false
Date Format: MM/DD/YYYY
--->

	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Publisher" output="false">

		<cfreturn this />
 	</cffunction>

	<!---
	ACCESSORS
	--->
	

</cfcomponent>