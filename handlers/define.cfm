<cfset utils = createObject("component", "utils")>
<cfset thisURL = utils.getCurrentDir()>

<cfheader name="Content-Type" value="text/xml">  
<response status="success" showresponse="true" >  
<ide>  
<dialog width="900" height="600" dialogclosehandler="dialogclose.cfm" />  
<body>  
<![CDATA[  
<cfoutput>
<script src="#thisURL#/jquery-1.4.2.min.js"></script>
<script src="#thisURL#/jquery.validate.js"></script>
</cfoutput>
<script>
$(document).ready(function() {
	var counter = 1
	$("#addColumn").click(function(e) {
		e.preventDefault()
		var clone = $("#col_1_fieldset").clone()
		counter++
		$(".label", clone).text("Column "+counter)
		$("input[name='col_1_name']", clone).val("Column"+counter).attr("name", "col_"+counter+"_name")
		$("select[name='col_1_type']", clone).attr("name", "col_"+counter+"_type")
		$("input[name='col_1_list']", clone).attr("name", "col_"+counter+"_list")
		$("input[name='col_1_range']", clone).attr("name", "col_"+counter+"_range")

		clone.appendTo("#mainForm")
	})
	
	$(".type_selector").live("change", function() {
		//If they selected random name/boolean, then hide the list and range ones
		var selected = $("option:selected", this).val()
		if(selected == "random_name" || selected == "random_boolean") {
			
		} else if(selected == "random_list") {
			//hide range
			$(this).parent().children(".optionalSpan").hide()
			$(this).parent().children(".list").show()
		} else if(selected == "random_range") {
			//hide range
			$(this).parent().children(".optionalSpan").hide()
			$(this).parent().children(".range").show()
		}
	})

	$("#genData").click(function(e) {
		e.preventDefault()
		$("#mainForm").submit()
	})

	$("#mainForm").validate()
})
</script>

<style>
fieldset {
	margin-bottom: 5px;
}
p#endP {
}
</style>

<cfoutput><form id="mainForm" method="post" action="#thisURL#/generate.cfm"></cfoutput>

<fieldset>
How many rows of data should be created?
<input type="text" name="rows" maxlength="3" size="3" class="required" min="1" number value="10">
</fieldset>

<fieldset id="col_1_fieldset">
	<span class="label">Column 1:</span>
	<input type="text" name="col_1_name" value="Column1">
	<select name="col_1_type" class="type_selector">
	<option value="random_name">Random Name</option>
	<option value="random_boolean">Random Boolean (True/False)</option>
	<option value="random_usphone">Random US Phone</option>
	<option value="random_email">Random Email Address</option>
	<option value="random_autoinc">Auto incrementing number</option>
	<option value="random_list">Random Value from List</option>
	<option value="random_range">Random Number (in range)</option>
	</select>
	
	<span id="col_1_list_span" style="display:none" class="optionalSpan list">Enter values separated by a comma: <input type="text" name="col_1_list"></span>
	<span id="col_1_range_span" style="display:none" class="optionalSpan range">Enter numeric range in the form 1-100: <input type="text" name="col_1_range"></span>

</fieldset>
</form>

<p id="endP">
<a href="" id="addColumn">Add Column</a> ~ <a href="" id="genData">Generate Data</a>
</p>
]]>
</body>
</ide>
</response>
