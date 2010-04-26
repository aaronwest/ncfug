<cfquery name="qryAllActiveMeetings" datasource="ncfug">
Select meeting_ID, title
from meeting
where is_active = 1
</cfquery>

<html>
<head>
<title>Choose a Winner 2.0</title>

<script src="../js/jquery-1.2.6.pack.js"></script>
<script src="../js/jquery.form.js"></script>

<script>
$(document).ready(function(){ //document.onload
	
	$('#btnSubmit').click(function(){
		$('#winner').hide();
		$('#myForm').ajaxSubmit({success:showResponse});
		return false; 
	});
});


function showResponse(responseText)  { 
			$('#winner').fadeIn('slow').html(responseText);
} 
</script>

<style>
	body,p,div {
		font-family:Arial, Helvetica, sans-serif;

	}
	
	#winner{
		text-align:center;
		display:none;		
	}
	
	h1 {
		font-size:72px;
	}

</style>

</head>





<body>
<form action="winnerresponse.cfm" method="post" id="myForm">
<fieldset>
<legend>Choose a meeting</legend>


<label for="meeting">Meeting:</label>


<select name="meeting_id" id="meeting">
<cfoutput query="qryAllActiveMeetings">
	<option value="#qryAllActiveMeetings.meeting_ID#">#qryAllActiveMeetings.title#</option>
</cfoutput>
</select>

<input name="btnSubmit" id="btnSubmit" value="Choose Winner!" type="button">
</fieldset>
</form>


<br />
<br />

<div id="winner" align="center">Something her inere</div>


</body>
</html>