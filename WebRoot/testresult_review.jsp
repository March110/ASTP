<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="com.beyondsoft.astp.common.model.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pager" uri="/pagerTag"%>
<%@ taglib prefix="breadcrumb" uri="/breadcrumbTag"%>
<html>
<head>
	<title>Test Result Review</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="css/common_style.css">
	<link rel="stylesheet" type="text/css" href="css/displaytag.css">
	<link rel="stylesheet" type="text/css" href="css/additem.css">
	<link rel="stylesheet" type="text/css" href="css/navigation-bars.css" media="screen"/>	
	<link rel="stylesheet" type="text/css" href="css/navigation-bar-font-awesome.css"/>
	<script type="text/javascript" src="javascript/jquery-1.9.1.min.js"></script>
</head>
<script type="text/javascript">

	function initTestCaseTypes()
	{
		$.ajax({
				type : 'post', 
				url : 'testdata!getTestDataType.action',
				data : "", 
				success : function(result) {
				
							if(result != null && result != "")
							{
								var objSelect = document.getElementById("testResult.testCase.testType");
								objSelect.options.length = 0;
								
								// Default empty option
								var item = new Option("----", "");
								item.selected = true;
								objSelect.options.add(item);
								
								var items = result.split(',');
								var len = items.length;
																
								for(var i=0; i<len; i++)
								{
									var option = new Option(items[i], items[i]);
									objSelect.options.add(option);									 
								}
							}
						}, 
				error : function(result) {							
						} 
				});	
	}
	
	function initTestCodes()
	{		
		var ctrTestType = document.getElementById("testResult.testCase.testType");				
		if(ctrTestType.selectedIndex == -1)
		{
			var objSelect = document.getElementById("testResult.testCase.testCode");
			objSelect.options.length = 0;
								
			// Default empty option
			var item = new Option("----", "");
			item.selected = true;
			objSelect.options.add(item);
			
			return;
		}
		
		var selectedTestType = ctrTestType.options[ctrTestType.selectedIndex].value;
		
		$.ajax({
				type : 'post', 
				url : 'testdata!getTestDataCodes.action',
				data : "testtype=" + selectedTestType, 
				success : function(result) {
							if(result != null && result != "")
							{
								var objSelect = document.getElementById("testResult.testCase.testCode");
								objSelect.options.length = 0;
								
								// Default empty option
								var item = new Option("----", "");
								item.selected = true;
								objSelect.options.add(item);
			
								var items = result.split(',');
								var len = items.length;						
								
								for(var i=0; i<len; i++)
								{
									var option = new Option(items[i], items[i]);
									objSelect.options.add(option); 
								} 
							}
						}, 
				error : function(result) {							
						} 
				});	
		
	}
	
	function initModule()
	{
		$.ajax({
				type : 'post', 
				url : 'apiaction_getModules',
				data : "", 
				success : function(result) {
							if(result != null && result != "")
							{
								var objSelect = document.getElementById("testResult.testCase.module");
								objSelect.options.length = 0;
								
								// Default empty option
								var item = new Option("----", "");
								item.selected = true;
								objSelect.options.add(item);
									
								var items = result.split(',');
								var len = items.length;
								for(var i=0; i<len; i++)
								{									
									var option = new Option(items[i], items[i]);									
									objSelect.options.add(option);
								}
							}
						}, 
				error : function(result) {							
						} 
				});	
	}
	
	function initFeature()
	{
		var ctrFunction = document.getElementById("testResult.testCase.function");
		ctrFunction.options.length = 0;
								
		// Default empty option
		var item = new Option("----", "");
		item.selected = true;
		ctrFunction.options.add(item);
			
		var ctrModule = document.getElementById("testResult.testCase.module");				
		if(ctrModule.selectedIndex == -1)
		{
			var ctrFeature = document.getElementById("testResult.testCase.feature");
			ctrFeature.options.length = 0;
								
			// Default empty option
			var item = new Option("----", "");
			item.selected = true;
			ctrFeature.options.add(item);		
			
			return;
		}
		
		var selectedModule = ctrModule.options[ctrModule.selectedIndex].value;
		
		$.ajax({
				type : 'post', 
				url : 'apiaction_getFeatures',
				data : "module=" + selectedModule, 
				success : function(result) {
							if(result != null && result != "")
							{
								var objSelect = document.getElementById("testResult.testCase.feature");
								objSelect.options.length = 0;
								
								// Default empty option
								var item = new Option("----", "");
								item.selected = true;
								objSelect.options.add(item);
									
								var items = result.split(',');
								var len = items.length;
								for(var i=0; i<len; i++)
								{									
									var option = new Option(items[i], items[i]);									
									objSelect.options.add(option);
								}
							}
						}, 
				error : function(result) {							
						} 
				});	
	}
	
	function initFunction()
	{
		var ctrModule = document.getElementById("testResult.testCase.module");	
		var ctrFeature = document.getElementById("testResult.testCase.feature");				
		if(ctrModule.selectedIndex == -1 || ctrFeature.selectedIndex == -1)
		{
			var objSelect = document.getElementById("testResult.testCase.function");
			objSelect.options.length = 0;
								
			// Default empty option
			var item = new Option("----", "");
			item.selected = true;
			objSelect.options.add(item);
			
			return;
		}
		
		var selectedModule = ctrModule.options[ctrModule.selectedIndex].value;
		var selectedFeature = ctrFeature.options[ctrFeature.selectedIndex].value;
		
		$.ajax({
				type : 'post', 
				url : 'apiaction_getFunctions',
				data : "module=" + selectedModule + "&feature=" + selectedFeature, 
				success : function(result) {
							if(result != null && result != "")
							{
								var objSelect = document.getElementById("testResult.testCase.function");
								objSelect.options.length = 0;
								
								// Default empty option
								var item = new Option("----", "");
								item.selected = true;
								objSelect.options.add(item);
									
								var items = result.split(',');
								var len = items.length;
								for(var i=0; i<len; i++)
								{									
									var option = new Option(items[i], items[i]);									
									objSelect.options.add(option);
								}
							}
						}, 
				error : function(result) {							
						} 
				});	
	}
	
	$(document).ready(function () {
		//奇偶行不同颜色
		$("#testresult_list tbody tr:odd").addClass("odd");
		$("#testresult_list tbody tr:even").addClass("even");
		
		//鼠标移动到行变色,单独建立css类hover
    	//tr:gt(0):表示获取大于 tr index 为0 的所有tr，即不包括表头
    	$("#testresult_list tr:gt(0)").hover(
    		function () { $(this).addClass("hover"); },
    		function () { $(this).removeClass("hover"); });  
    		
    	initTestCaseTypes();
    	initTestCodes();
    	initModule();
    	initFeature();
    	initFunction();    	  
	});
	
	function viewTestResult(id, envid)
	{
		window.open("/ASTP/testresult!view.action?flag=testresult&id=" + id + "&envid=" + envid, "TestResultDetail","width=700,height=500,toolbar=0,menubar=0,location=0,status=0,scrollbars=1,resizable=1,left=300,top=300");
		return false;
	}
	
	function suspend()
	{
		var envid = "<s:property value='testEnvID'/>";
			
		$.ajax({
				type : 'post', 
				url : 'testresult!suspend.action',
				data : "envid=" + envid,
				success : function(result) {
				
							if("success" != result)
							{
								alert("Failed to suspend, the detailed root case:" + result);
							} else {
								alert("Success to suspend!");
							}
						}, 
				error : function(result) {
							alert("Failed to suspend, the detailed root case:" + result);
						} 
				});	
	}
</script>
<body>
	<breadcrumb:breadcrumbBar></breadcrumb:breadcrumbBar>
	<div id="Main">
		<div class="appC">
			<form id="frmSearch" name="frmSearch" action="testresult!review.action" method="post" namespace="/">
				<div id="formTable" class="rowClass">
				
					<div class="labelClass"><span>Test Set:</span></div>
					<select id="testResult.testCase.testType" name="testResult.testCase.testType" onchange="javascript:initTestCodes();"></select>
				
					<div class="labelClass"><span>Attack Type:</span></div>
					<select id="testResult.testCase.testCode" name="testResult.testCase.testCode"></select>
				</div>
				
				<div id="formTable" class="rowClass">				
				
					<div class="labelClass"><label>Module:</label></div>
					<select id="testResult.testCase.module" name="testResult.testCase.module" onchange="javascript:initFeature();"></select>
					
					<div class="labelClass"><label>Feature:</label></div>
					<select id="testResult.testCase.feature" name="testResult.testCase.feature" onchange="javascript:initFunction();"></select>
					
					<div class="labelClass"><label>Function:</label></div>
					<select id="testResult.testCase.function" name="testResult.testCase.function"></select>
					
				</div>
				
				<div class="rowClass">				
					<div class="labelClass"><span>Status:</span></div>
					<select id="testResult.executeStatus" name="testResult.executeStatus">
						<option value="">----</option>
						<option value="0">0</option>
						<option value="1">1</option>
					</select>									
					<div class="labelClass"><label> Response Code:</label>	</div>
					<select id="testResult.responseCode" name="testResult.responseCode">
						<option value="">----</option>
						<option value="2">2XX</option>
						<option value="3">3XX</option>
						<option value="4">4XX</option>
						<option value="5">5XX</option>
					</select>										
				</div>				
				
				<div  class="rowClass">					
					<input type="submit" value="Search"/>
					<a href="#" align="center" class="buttonClass" onclick="javascript:suspend();">Suspend</a>					
				</div>
				<input type="hidden" id="envid" name="envid" value="<s:property value='testEnvID'/>">				
			</form>
		</div>

		<div class="titEnv">
			<span>Product Name:</span> <span><s:property value="TestEnv.ProductName"/></span> &nbsp;&nbsp; <span>IPv4: <s:property value="TestEnv.IPv4Address"/></span>
		</div>
		<table  cellpadding="0" cellspacing="0"   class="table table-striped table-bordered table-hover">		
			<thead>
				<tr>
					<th>Test Set</th>
					<th>Attack Type</th>
					<th>Step</th>
					<th>Feature</th>					
					<th>Execute Result</th>
					<th>Response Code</th>
					<th>See More</th>									
				</tr>
			</thead>
			<tbody>
				<s:iterator value="TestResults" id="testresult" status="status">					
					<tr id="<s:property value='#testresult.ID'/>">
						<td style="text-align: left;"><s:property value="#testresult.TestCase.TestType"/></td>
						<td style="text-align: left;"><s:property value="#testresult.TestCase.TestCode"/></td>
						<td style="text-align: left;"><s:property value="#testresult.TestCase.TestCaseStep"/></td>						
						<td style="text-align: left;"><s:property value="#testresult.TestCase.Module"/> -> <s:property value="#testresult.TestCase.Feature"/> -> <s:property value="#testresult.TestCase.Function"/></td>
						<td style="text-align: left;"><s:property value="#testresult.Result"/></td>
						<td style="text-align: left;"><s:property value="#testresult.ResponseCode"/></td>
						<td style="text-align: center;">
							<a href="#"	class="nyroModal" name="seemore" onclick="javascript:viewTestResult(<s:property value='#testresult.ID'/>, <s:property value='#testresult.TestEnvID'/>)">
								<img src="images/seemore.gif" style="border: none;"> 
							</a>
						</td>								
					</tr>				
				</s:iterator>	
			</tbody>

		</table>

		<pager:pages pageNo="pageNo" total="total" styleClass="page" theme="number"></pager:pages>
</body>
</html>
