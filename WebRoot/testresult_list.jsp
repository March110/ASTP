<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="com.beyondsoft.astp.common.model.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pager" uri="/pagerTag"%>
<%@ taglib prefix="breadcrumb" uri="/breadcrumbTag"%>
<html>
<head>
	<title>LEDM Cases</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="css/common_style.css">
	<link rel="stylesheet" type="text/css" href="css/displaytag.css">
	<link rel="stylesheet" type="text/css" href="css/additem.css">
	<link rel="stylesheet" type="text/css" href="css/navigation-bars.css" media="screen"/>	
	<link rel="stylesheet" type="text/css" href="css/navigation-bar-font-awesome.css"/>
	<script type="text/javascript" src="javascript/jquery-1.9.1.min.js"></script>
	<style type="text/css">
		.row thead tr th {
			vertical-align: middle;
		}
		
		.hover
		{
  			background-color: #cccc00;
		}
	</style>
	<script type="text/javascript">
	
	</script>
</head>

<script type="text/javascript">

	var testTypeValue = "<s:property value='testResult.testCase.testType'/>";
	var testCodeValue = "<s:property value='testResult.testCase.testCode'/>";
	var moduleValue = "<s:property value='testResult.testCase.module'/>";
	var featureValue = "<s:property value='testResult.testCase.feature'/>";
	var functionValue = "<s:property value='testResult.testCase.function'/>";
	
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
									if(testTypeValue == items[i])
									{
										option.selected = true;
									}
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
		var selectedTestType = testTypeValue;
		
		if(selectedTestType == "") {
		
			if(ctrTestType.selectedIndex < 1) {
				var objSelect = document.getElementById("testResult.testCase.testCode");
				objSelect.options.length = 0;
									
				// Default empty option
				var item = new Option("----", "");
				item.selected = true;
				objSelect.options.add(item);
				
				return;
			} else {
				selectedTestType = ctrTestType.options[ctrTestType.selectedIndex].value;
			}	
		}
		
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
									if(testCodeValue == items[i]) {
										option.selected = true;
									}
									
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
									if(moduleValue == items[i])	
									{
										option.selected = true;
									}					
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
		var selectedModule = moduleValue;
		
		if(selectedModule == "") {
		
			if(ctrModule.selectedIndex < 1)
			{
				var ctrFeature = document.getElementById("testResult.testCase.feature");
				ctrFeature.options.length = 0;
									
				// Default empty option
				var item = new Option("----", "");
				item.selected = true;
				ctrFeature.options.add(item);		
				
				return;
			} else {		
				selectedModule = ctrModule.options[ctrModule.selectedIndex].value;
			}
		}
		
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
									if(featureValue == items[i])
									{
										option.selected = true;
									}													
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
		var selectedModule = moduleValue;
		var selectedFeature = featureValue;
		
		if(selectedModule == "" || selectedFeature == "")
		{
			if(ctrModule.selectedIndex < 1 || ctrFeature.selectedIndex < 1)
			{
				var objSelect = document.getElementById("testResult.testCase.function");
				objSelect.options.length = 0;
									
				// Default empty option
				var item = new Option("----", "");
				item.selected = true;
				objSelect.options.add(item);
				
				return;
				
			} else {		
				selectedModule = ctrModule.options[ctrModule.selectedIndex].value;
				selectedFeature = ctrFeature.options[ctrFeature.selectedIndex].value;
			}
		}
		
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
									if(functionValue == items[i]) {
										option.selected = true;
									}							
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

	function suspend(envid)
	{		
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
	
	
	//控制全选按钮触发时，页面上列表中的所有按钮也均勾选上
	function selectAll(checkbox){
		var selectAllOrNot = false;//全勾选标识
		
		var testresultIds = "";
		if(($(checkbox).prop('checked'))){//全选按钮未勾选时单击全选按钮
			selectAllOrNot = true;
			$("#table input[name=check]").each(function(){ //遍历table里的全部checkbox 
				if(!($(this).prop('checked'))){
					testresultIds += $(this).val() + ","; 
				}
	        }); 
			testresultIds = testresultIds.substring(0, testresultIds.length - 1); //把最后一个逗号去掉 
		}else{//去勾选全选按钮状态
			selectAllOrNot = false;
			$("#table input[name=check]").each(function(){ //遍历table里的全部checkbox 
				testresultIds += $(this).val() + ","; 
	        }); 
		}
		$.ajax({
				type : 'post', 
				url : 'testresult!selectAll.action',
				data : "&resultid=" + testresultIds+"&checked="  + selectAllOrNot , 
				success : function(result) {
							
						}, 
				error : function(result) {
							
						} 
				});
		
		
		$('input[type=checkbox]').prop('checked', $(checkbox).prop('checked'));
	}
	
	//testresult.jsp页面单独选中某一条case触发事件
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
							} else {
							
								if("delete" == flag)
								{
									$("#" + resultid).hide();
								}
							}
						}, 
				error : function(result) {
							alert("Failed to "+ flag + ", the detailed root case:" + result);
						} 
				});
	}
	
	function viewTestCase(id, envid)
	{
		window.open("/ASTP/testresult!view.action?flag=testcase&id=" + id + "&envid=" + envid, "TestCaseDetail","width=700,height=500,toolbar=0,menubar=0,location=0,status=0,scrollbars=1,resizable=1,left=300,top=300");
		return false;
	}
	
	$(document).ready(function () {
		$("#table input[name=checkAll]").prop('checked', true); //先将全选按钮状态置成true
		$("#table input[name=check]").each(function(){ //遍历table里的全部checkbox 
			if(!($(this).prop('checked'))){
				$("#table input[name=checkAll]").prop('checked', false); //一旦子列表中出现一个未勾选，则将全选置成false
			}
        }); 
	});	
	
</script>
<body>
	<breadcrumb:breadcrumbBar></breadcrumb:breadcrumbBar>
	<div id="Main">
		<div class="appC">
			<form id="frmSearch" name="frmSearch" action="testresult!list.action" method="post" namespace="/">
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
					<select id="status" name="status">
						<option value="">----</option>
						<option value="0">0</option>
						<option value="1">1</option>
					</select>									
					<div class="labelClass"><label> Result:</label>	</div>
					<select id="result" name="result">
						<option value="">----</option>
						<option value="0">0</option>
						<option value="1">1</option>
						<option value="2">2</option>
					</select>										
				</div>
				
				<div id="formTable" class="rowClass">				
					<table border=0 cellpadding=0 cellspacing=0>
						<tr>
							<td><input type='radio' name='opFlag' value='0' style="width: 28px; ">Unselect All</td>
						</tr>
						<tr>
							<td><input type='radio' name='opFlag' value='1' style="width: 28px; ">Select All</td>
						</tr>
						<tr>
							<td><input type='radio' name='opFlag' value='2' style="width: 28px; ">Delete All</td>
						</tr>
					</table>
					<input type="hidden" id="envid" name="envid" value="<s:property value='testEnvID'/>">
					<input type="submit" value="Search"/>
				</div>	
				
				<div  class="rowClass">
					<!--  		
					<a href="#" align="center" class="buttonClass" name="search">
						<img src="images/search.jpg" style="border: none;width="25" align="center" height="25"">Search						
					</a>
					-->
											
					<a href="testcase!list.action?envid=<s:property value='TestEnvID'/>" align="center" class="buttonClass" name="add">
						<img src="images/add.gif" style="border: none;" /> Add Case
					</a>
					<a href="testresult!perform.action?envid=<s:property value='testEnvID'/>" align="center" class="buttonClass">Execute Selected Case</a>
				</div>
				<input type="hidden" id="envid" name="envid" value="<s:property value='testEnvID'/>">			
			</form>
			
		</div>

		<div class="titEnv">
			<span>Product Name: </span><span><s:property value="TestEnv.ProductName"/></span> &nbsp;&nbsp; <span>IPv4: <s:property value="TestEnv.IPv4Address"/></span>
		</div>
		<table id="table" cellpadding="0" cellspacing="0"   class="table table-striped table-bordered table-hover">		
			<thead>
				<tr>
					<th>Test Set</th>
					<th>Attach Type</th>
					<th>Step</th>
					<th>Feature</th>
					<!--th>Descrption</th-->
					<!--th>Expection</th-->
					<th>URL</th>				
					<th>Status</th>
					<th>Result</th>
					<!--th>Execute Time</th-->
					<th>See More</th>
					<th>Remove</th>
					<th>
						<input type="checkbox" name="checkAll" class="checkAll" id="checkAll" onclick="selectAll(this);"/>All
					</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="TestResults" id="testcase" status="status">					
					<tr id="<s:property value='#testcase.ID'/>">
						<td style="text-align: center;"><s:property value="#testcase.TestCase.TestType"/></td>
						<td style="text-align: center;"><s:property value="#testcase.TestCase.TestCode"/></td>
						<td style="text-align: center;"><s:property value="#testcase.TestCase.TestCaseStep"/></td>
						<td style="text-align: left;"><s:property value="#testcase.TestCase.Module"/>-><s:property value="#testcase.TestCase.Feature"/>-><s:property value="#testcase.TestCase.Function"/></td>
						<!--td style="padding: 10px;"><p><s:property value="#testcase.TestCase.TestCaseDesc" escapeHtml="false"/></p></td-->
						<!--td style="padding: 10px;"><p><s:property value="#testcase.TestCase.ExpectResult" escapeHtml="false"/></p></td-->
						<td style="text-align: left;"><s:property value="#testcase.TestCase.RequestUrl"/></td>
						<td style="text-align: center;"><s:property value="#testcase.ExecuteStatus"/></td>
						<td style="text-align: center;"><s:property value="#testcase.Result"/></td>
						<!--td style="text-align: center;"><s:property value="#testcase.ExecuteTime"/></td-->
						<td style="text-align: center;">
							<a href="#"	class="nyroModal" name="seemore" onclick="javascript:viewTestCase(<s:property value='#testcase.ID'/>, <s:property value='#testcase.TestEnvID'/>)">
								<img src="images/seemore.gif" style="border: none;"> 
							</a>
						</td>
						<td style="text-align: center;">
							<a href="#"	class="nyroModal" name="seemore" onclick="javascript:perform('delete', <s:property value='#testcase.ID'/>, <s:property value='#testcase.TestEnvID'/>, null)">
								<img src="images/delete.gif" style="border: none;"> 
							</a>
						</td>
						<td style="text-align: center;">
							<s:if test="#testcase.ExecuteStatus==1">
									<input name="check"	value="<s:property value="#testcase.ID"/>" type="checkbox" checked
											onclick="javascript:perform('select', 
																		<s:property value='#testcase.ID'/>, 
																		<s:property value='#testcase.TestEnvID'/>,
																		this)">
							</s:if>
							<s:else>
									<input name="check"	value="<s:property value="#testcase.ID"/>" type="checkbox" 
											onclick="javascript:perform('select', 
																		<s:property value='#testcase.ID'/>, 
																		<s:property value='#testcase.TestEnvID'/>, 
																		this)">
							</s:else>
							
						</td>
					</tr>				
				</s:iterator>	
			</tbody>

		</table>

		<pager:pages pageNo="pageNo" total="total" styleClass="page" theme="number"></pager:pages>&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="testresult!perform.action?envid=<s:property value='testEnvID'/>" align="center" class="buttonClass">Execute Selected Case</a>
		<br/><br/>			
</body>
</html>
