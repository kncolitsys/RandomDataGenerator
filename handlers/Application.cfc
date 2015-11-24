<cfcomponent>
	<cfset this.name = "quickrandomdata">
	
	<cffunction name="onRequestStart" returntype="boolean" output="false">
		<cfargument name="req" type="string" required="true">
		<cfsetting showdebugoutput="false">
		<cfreturn true>
	</cffunction>
	
</cfcomponent>
