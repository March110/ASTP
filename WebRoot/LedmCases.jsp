<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="com.beyondsoft.astp.common.model.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<title>LEDM Cases</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="css/common_style.css">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="css/displaytag.css">
	<link rel="stylesheet" type="text/css" href="css/additem.css">
	<script type="text/javascript" src="javascript/jquery-1.9.1.min.js"></script>
	<style type="text/css">
		.row thead tr th {
			vertical-align: middle;
		}
	</style>
	<script type="text/javascript">
	
	</script>
</head>
<script type="text/javascript">

	function perform(flag, resultid, envid, ctrChkbox)
	{
		var checked = "";
		if("select" == flag && ctrChkbox != null) {
			checked = $(ctrChkbox).is(':checked');
		}
		
		$.ajax({
				type : 'post', 
				url : 'testresult!' + flag + '.action',
				data : "envid=" + envid + "&resultid=" + resultid + "&checked="  + checked, 
				success : function(result) {
							if("success" != result)
							{
								alert("Failed to " + flag + ", the detailed root case:" + result);
							}
						}, 
				error : function(result) {
							alert("Failed to "+ flag + ", the detailed root case:" + result);
						} 
				});
	}
	

</script>
<body>
	<div id="Main">
		<div class="appC">
			<form id="frmSearch" onSubmit="" method="post" action="" name="frmSearch">
				<table id="tblSchool" class="searchT">
 					<tbody>
						<tr>
							<td>
							Attack Type:
								<select id="attackType" class="attackType" name="attackType">
									<option class="li-attackType" value="0"></option>
									<option class="li-attackType" value="1">xss</option>
									<option class="li-attackType" value="2">sql</option>
									<option class="li-attackType" value="3">xpath</option>
									<option class="li-attackType" value="4">special-char</option>
									<option class="li-attackType" value="5">xml</option>
								</select> &nbsp;&nbsp; 
							Execute Time:
							<input id="executeTime" name="executeTime" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">&nbsp;&nbsp;
								Status: <select id="status" class="status" name="status">
									<option class="li-status" value="0"></option>
									<option class="li-status" value="1">Passed</option>
									<option class="li-status" value="2">Failed</option>
									<option class="li-status" value="3">Reviewing</option>
									<option class="li-status" value="4">None</option>
									<option class="li-status" value="5">In Progress</option>
								</select>
							 &nbsp;&nbsp; Result:
							 <select class="result" name="result">
									<option class="li-result" value="0"></option>
									<option class="li-result" value="1">404</option>
									<option class="li-result" value="2">200</option>
									<option class="li-result" value="3">503</option>
									<option class="li-result" value="4">500</option>
									<option class="li-result" value="5">400</option>
									<option class="li-result" value="6">0</option>
							</select>&nbsp;&nbsp;&nbsp;&nbsp; 
							Feature:<select class="feature" name="feature">
									<option class="li-feature" value="0"></option>
									<option class="li-result" value="1">Scan</option>
									<option class="li-feature" value="2">Fax</option>
									<option class="li-feature" value="3">Web Services</option>
									<option class="li-feature" value="4">Network</option>
									<option class="li-feature" value="5">Tool</option>
									<option class="li-feature" value="6">Settings</option>
									</select>
							</td>
						</tr>
						<tr>
							<td align="center"
								style="vertical-align: baseline; padding-top: 3px;"><a
								href="" align="center" class="nyroModal" name="add"><img
									src="images/search.jpg" style="border: none;width="
									25" align="center" height="25"">Search</a>
								&nbsp;&nbsp;&nbsp;&nbsp; <a href="AddLedmCases.html"
								align="center" class="nyroModal" name="add"><img
									src="images/add.gif" style="border: none;" /> Add Case</a></td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>

		<div class="titEnv">
			<span>Product Name: Lemans</span> &nbsp;&nbsp; <span><s:property value="TestEnv.ProductName"/></span> &nbsp;&nbsp; <span>IPv4: <s:property value="TestEnv.IPv4Address"/></span>
		</div>
		<table class="row" cellpadding="0" cellspacing="0">		
			<thead>
				<tr>
					<th>Test Set</th>
					<th>DS_STEP_NAME</th>
					<th>DS_Descrption</th>
					<th>DS_Expection</th>					
					<th>Status</th>
					<th>Result</th>
					<th>Execute Time</th>
					<th>See More</th>
					<th>Remove</th>
					<th>Is Selected <br /> <input type="checkbox" name="chackAll"
						class="checkAll" id="checkAll" /></th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="TestResults" id="testcase" status="status">
					<s:property value='status.index'/>
					<tr class="even">
						<td style="text-align: center;"><s:property value="#testcase.TestCase.TestType"/></td>
						<td style="text-align: center;"><s:property value="#testcase.TestCase.TestCaseStep"/></td>
						<td id="desShowmore" style="text-align: center;"><s:property value="#testcase.TestCase.TestCaseDesc"/></td>
						<td id="expShowmore" style="text-align: center;"><s:property value="#testcase.TestCase.ExpectResult"/></td>		
						<td style="text-align: center;"><s:property value="#testcase.ExecuteStatus"/></td>
						<td style="text-align: center;"><s:property value="#testcase.Result"/></td>
						<td style="text-align: center;"><s:property value="#testcase.ExecuteTime"/></td>
						<td style="text-align: center;">
							<a href="#"	class="nyroModal" name="seemore" onclick="javascript:perform('view', <s:property value='#testcase.ID'/>, <s:property value='#testcase.TestEnvID'/>, null)">
								<img src="images/seemore.gif" style="border: none;"> 
							</a>
						</td>
						<td style="text-align: center;">
							<a href="#"	class="nyroModal" name="seemore" onclick="javascript:perform('delete', <s:property value='#testcase.ID'/>, <s:property value='#testcase.TestEnvID'/>, null)">
								<img src="images/delete.gif" style="border: none;"> 
							</a>
						</td>
						<td style="text-align: center;">
							<input name="check"	value="<s:property value="#testcase.ID"/>" type="checkbox" 
							onclick="javascript:perform('select', <s:property value='#testcase.ID'/>, <s:property value='#testcase.TestEnvID'/>, this)"></td>
					</tr>				
				</s:iterator>	
			</tbody>

		</table>

		<table align="center" width=80% cellspacing="0" cellpadding="0">

			<tr width="500" align="center">
				<input class="" type="button" value="First Page" /> &nbsp;
				<input class="" type="button" value="Page Up" />&nbsp;
				<a href=#>1</a>&nbsp;
				<a href=#>2</a>&nbsp;
				<a href=#>3</a>&nbsp;
				<a href=#>4</a>&nbsp;
				<a href=#>....</a>&nbsp;
				<a href=#>8</a>&nbsp;
				<a href=#>9</a>&nbsp;
				<a href=#>10</a>&nbsp;
				<input class="" type="button" value="Page Down" />&nbsp;
				<input class="" type="button" value="Last Page" />
				&nbsp;&nbsp;&nbsp;&nbsp;
			<tr align="right">
				Page Number:
				<input name="page" size="8" style="width: 30px; height: 25px;type=" input"/>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input style="width: 30px; height: 22px;" name="GgPage" value="GO"
					onClick="" type="button" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="ExecuteSeleted" style="width: 85px; height: 25px;"
					value="ExecuteSeleted"
					onClick="window.location.href='ExecuteLedmTestCase.html'"
					type="Button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
		</table>
</body>
</html>
