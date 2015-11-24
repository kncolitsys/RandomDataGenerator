<cfset utils = createObject("component", "utils")>
<cfset thisURL = utils.getCurrentDir()>
<cflog file="application" text="ran gen">
<!--- First, let's see what our columns are... --->
<cfset cols = []>

<!--- sort fieldlist --->
<cfset keyList = listSort(structKeyList(form), "textnocase")>
<cfloop index="field" list="#keyList#">
	<cfif reFindNoCase("col_[0-9]+_name", field)>
		<cfset column = {}>
		<cfset addColumn = true>
		<cfset column.name = replace(form[field], " ", "_", "all")>
		<cfset index = listGetAt(field, 2, "_")>
		<cfset type = form["col_#index#_type"]>
		<cfset column.type = type>

		<cfif type is "random_list">
			<cfset listValue = form["col_#index#_list"]>
			<cfif not len(trim(listValue))>
				<cfset addColumn = false>
				<cfcontinue>
			</cfif>
			<cfset column.listValues = listValue>
		</cfif>
		
		<cfif type is "random_range">
			<cfset rangeValue = form["col_#index#_range"]>
			<cfif not len(trim(rangeValue)) or not listLen(rangeValue, "-") is 2>
				<cfset addColumn = false>
				<cfcontinue>
			</cfif>
			<cfset minVal = listFirst(rangeValue, "-")>
			<cfset maxVal = listLast(rangeValue, "-")>
			<cfif not isNumeric(minVal) or not isNumeric(maxVal) or minVal gte maxVal>
				<cfset addColumn = false>
				<cfcontinue>
			</cfif>
			<cfset column.minVal = minVal>
			<cfset column.maxVal = maxVal>
		</cfif>

		<cfset arrayAppend(cols, column)>		
	</cfif>
</cfloop>
<cfset numRows = form.rows>
<cfif not isNumeric(numRows) or numRows lte 0>
	<cfset numRows = 10>
</cfif>

<cfloop index="col" array="#cols#">
	<cfif not isDefined("variables.q")>
		<cfset q = queryNew(col.name)>
	<cfelse>
		<cfset queryAddColumn(q, col.name, arrayNew(1))>
	</cfif>
</cfloop>

<cfloop index="x" from="1" to="#numRows#">
	<cfset queryAddRow(q)>
	<cfloop index="col" array="#cols#">
		<cfswitch expression="#col.type#">

			<cfcase value="random_name">
				<cfset name = utils.randomLastName() & ", " & utils.randomFirstName()>
				<cfset querySetCell(q, col.name, name)>
			</cfcase>

			<cfcase value="random_usphone">
				<cfset value = "(" & randRange(1,9) & randRange(1,9) & randRange(1,9) & ") " & randRange(1,9) & randRange(1,9) & randRange(1,9) & "-" & randRange(1,9) & randRange(1,9) & randRange(1,9) & randRange(1,9)> 
				<cfset querySetCell(q, col.name, value)>
			</cfcase>

			<cfcase value="random_email">
				<cfset domains = "gmail.com,yahoo.com,msn.com,hotmail.com,aol.com">
				<cfset value = lcase(utils.randomFirstName()) & randRange(100,999) & "@" & listGetAt(domains, randRange(1, listLen(domains)))>
				<cfset querySetCell(q, col.name, value)>
			</cfcase>

			<cfcase value="random_autoinc">
				<cfset querySetCell(q, col.name, javacast("string",x))>
			</cfcase>

			<cfcase value="random_boolean">
				<cfset value = randRange(0,1)>
				<cfset querySetCell(q, col.name, value)>
			</cfcase>

			<cfcase value="random_list">
				<cfset value = listGetAt(col.listValues, randRange(1,listLen(col.listValues)))>
				<cfset querySetCell(q, col.name, value)>
			</cfcase>

			<cfcase value="random_range">
				<cfset value = randRange(col.minVal,col.maxVal)>
				<cfset querySetCell(q, col.name, value)>
			</cfcase>

		</cfswitch>
	</cfloop>
</cfloop>

<!---<cfdump var="#q#">--->
<cfset queryData = serializeJSON(q, true)>
<cfset result = "<" & "cfsavecontent variable=""q"">">
<cfset result &= queryData & "</cfsavecontent>">
<cfset result &= "#chr(10)#<cfset q = deserializeJSON(q,false)>">

<!--- copy to app scope --->
<cfset application.result = result>
<cfoutput>
#numRows# rows of random data have been created. Close the dialog to insert the data into your file.
</cfoutput>

