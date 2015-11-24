
<cfif structKeyExists(application, "result")>
<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response>
<ide>
<commands>
	<command type="inserttext">
	<params>
	<param key="text">
	<![CDATA[#application.result#]]>
	</param>
	</params>
	</command>
</commands>
</ide>
</response>
</cfoutput>

<cfset structDelete(application, "result")>

<cfelse>
	<!---Action aborted. Have a nice day.--->
	<cfheader name="Content-Type" value="text/xml">
<response>
<ide>
<commands>
</commands>
</ide>
</response>
</cfif>