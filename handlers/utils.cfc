<cfcomponent output="false">

<!---
Returns the current URL for the page.

@return Returns a string.
@version 1, September 5, 2008
--->
<cffunction name="getCurrentURL" output="No" access="public" returnType="string">
    <cfset var theURL = getPageContext().getRequest().GetRequestUrl().toString()>
    <cfif len( CGI.query_string )><cfset theURL = theURL & "?" & CGI.query_string></cfif>
    <cfreturn theURL>
</cffunction>

<cffunction name="getCurrentDir" output="No" access="public" returnType="string">
    <cfset var theURL = getCurrentURL()>
	<cfset theURL = listDeleteAt(theURL, listLen(theURL, "/"), "/")>
	<cfreturn theURL>
</cffunction>
	
<!---
Returns a random last name.

@return Returns a string. 
@version 1, June 18, 2010 
--->
<cffunction name="randomLastName" output="false" access="public" returntype="any" hint="">
    <cfset names = "Adams,Ahmed,Ali,Allen,Anderson,Bailey,Baker,Barker,Barnes,Begum,Bell,Bennett,Brown,Butler,Campbell,Carter,Chapman,Clark,Clarke,Collins,Cook,Cooper,Cox,Davies,Davis,Dixon,Edwards,Ellis,Evans,Fisher,Foster,Gray,Green,Griffiths,Hall,Harris,Harrison,Harvey,Hill,Holmes,Hughes,Hunt,Hussain,Jackson,James,Jenkins,Johnson,Jones,Kelly,Khan,King,Knight,Lee,Lewis,Lloyd,Marshall,Martin,Mason,Matthews,Miller,Mills,Mitchell,Moore,Morgan,Morris,Murphy,Owen,Palmer,Parker,Patel,Phillips,Powell,Price,Richards,Richardson,Roberts,Robinson,Rogers,Russell,Scott,Shaw,Simpson,Singh,Smith,Stevens,Taylor,Thomas,Thompson,Turner,Walker,Ward,Watson,Webb,White,Wilkinson,Williams,Wilson,Wood,Wright,Young" />    
    <cfreturn listGetAt(names, randRange(1,100)) />
</cffunction>

<!---
Returns a random first name.

@return Returns a string. 
@version 1, June 22, 2010 
--->
<cffunction name="randomFirstName" output="false" access="public" returntype="any" hint="">
    <cfset var names = "Adam,Ahmed,Alex,Ali,Amanda,Amy,Andrea,Andrew,Andy,Angela,Anna,Anne,Anthony,Antonio,Ashley,Barbara,Ben,Bill,Bob,Brian,Carlos,Carol,Chris,Christian,Christine,Cindy,Claudia,Dan,Daniel,Dave,David,Debbie,Elizabeth,Eric,Gary,George,Heather,Jack,James,Jason,Jean,Jeff,Jennifer,Jessica,Jim,Joe,John,Jonathan,Jose,Juan,Julie,Karen,Kelly,Kevin,Kim,Laura,Linda,Lisa,Luis,Marco,Maria,Marie,Mark,Martin,Mary,Matt,Matthew,Melissa,Michael,Michelle,Mike,Mohamed,Monica,Nancy,Nick,Nicole,Patricia,Patrick,Paul,Peter,Rachel,Richard,Robert,Ryan,Sam,Sandra,Sara,Sarah,Scott,Sharon,Stephanie,Stephen,Steve,Steven,Susan,Thomas,Tim,Tom,Tony,William" />
    <cfreturn listGetAt(names, randRange(1,100)) />
</cffunction>

</cfcomponent>