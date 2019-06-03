<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pager" uri="/pagerTag"%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>Add LEDM Test Case</title>
	<link rel="stylesheet" type="text/css" href="css/displaytag.css">
	<link rel="stylesheet" type="text/css" href="css/additem.css">
	<link rel="stylesheet" type="text/css" href="css/common_style.css">
	<script type="text/javascript" src="javascript/jquery-1.9.1.min.js"></script>
</head>
<script type="text/javascript">	

	//获取url中的参数
	function getUrlParam(name) {

		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.search.substr(1).match(reg);  	//匹配目标参数
		
		if (r != null) return unescape(r[2]); 

		return null; //返回参数值
	}
	
	var testTypeValue = "<s:property value='testType'/>";
	var testCodeValue = "<s:property value='testCode'/>";
	var moduleValue = "<s:property value='module'/>";
	var featureValue = "<s:property value='feature'/>";
	var functionValue = "<s:property value='function'/>";
	
	function initTestCaseTypes()
	{
		$.ajax({
				type : 'post', 
				url : 'testdata!getTestDataType.action',
				data : "", 
				success : function(result) {
				
							if(result != null && result != "")
							{
								var objSelect = document.getElementById("testType");
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
		var ctrTestType = document.getElementById("testType");	
		var selectedTestType = testTypeValue;
		
		if(selectedTestType == "")
		{
			if(ctrTestType.selectedIndex < 1) {
				var objSelect = document.getElementById("testCode");
				objSelect.options.length = 0;
									
				// Default empty option
				var item = new Option("----", "");
				item.selected = true;
				objSelect.options.add(item);
				
				return;
			}
			else {
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
								var objSelect = document.getElementById("testCode");
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
									if(testCodeValue == items[i])
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
	
	function initModule()
	{
		$.ajax({
				type : 'post', 
				url : 'apiaction_getModules',
				data : "", 
				success : function(result) {
							if(result != null && result != "")
							{
								var objSelect = document.getElementById("module");
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
		var ctrFunction = document.getElementById("function");
		ctrFunction.options.length = 0;
								
		// Default empty option
		var item = new Option("----", "");
		item.selected = true;
		ctrFunction.options.add(item);
			
		var ctrModule = document.getElementById("module");
		var selectedModule = moduleValue;
		
		if(selectedModule == "") {
			if(ctrModule.selectedIndex < 1) {
				var ctrFeature = document.getElementById("feature");
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
								var objSelect = document.getElementById("feature");
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
		var ctrModule = document.getElementById("module");	
		var ctrFeature = document.getElementById("feature");
		var selectedModule = moduleValue;
		var selectedFeature = featureValue;
		
		if(selectedModule == "" || selectedFeature == "") {
		
			if(ctrModule.selectedIndex < 1 || ctrFeature.selectedIndex < 1)
			{
				var objSelect = document.getElementById("function");
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
								var objSelect = document.getElementById("function");
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
									if(functionValue == items[i])
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
	
	//选择单个testcase触发事件
	function selectOneTestCase(chkbox, id){
		var checked = $(chkbox).is(':checked');
		$.ajax({
				type : 'post', 
				url : 'testcase!select.action',
				data : "testcaseid=" + id + "&envid=<s:property value='TestEnvID'/>&checked="  + checked, 
				success : function(result) {
							if("success" != result)
							{
								alert("Failed to save, the detailed root case:" + result);
							} else {
								 //$("#" + id).hide();
							}
						}, 
				error : function(result) {
							alert("Failed to save, the detailed root case:" + result);
						} 
				});
	}

	
    
	//选择全部testcase时触发事件,包括勾选全部和去勾选全部
	function selectAllTestCases(checkbox){
		var selectAllOrNot = false;//全勾选标识
		
		var testcaseIds = "";
		if(($(checkbox).prop('checked'))){//全选按钮未勾选时单击全选按钮
			selectAllOrNot = true;
			$("#table input[name=check]").each(function(){ //遍历table里的全部checkbox 
				if(!($(this).prop('checked'))){
					testcaseIds += $(this).val() + ","; 
				}
	        }); 
			testcaseIds = testcaseIds.substring(0, testcaseIds.length - 1); //把最后一个逗号去掉 
			//$('input[type=checkbox]').prop('checked', $(checkbox).prop('checked'));
		}else{//去勾选全选按钮状态
			selectAllOrNot = false;
			$("#table input[name=check]").each(function(){ //遍历table里的全部checkbox 
				testcaseIds += $(this).val() + ","; 
	        }); 
		}
		
		$.ajax({
				type : 'post', 
				url : 'testcase!selectAll.action',
				data : "testcaseid=" + testcaseIds + "&envid=<s:property value='TestEnvID'/>&selectAllOrNot="+selectAllOrNot,
				success : function(result) {
							if("success" != result)
							{
								alert("Failed to save, the detailed root case:" + result);
							} else {
								 //$("#" + id).hide();
							}
						}, 
				error : function(result) {
							alert("Failed to save, the detailed root case:" + result);
						} 
				});
		
		$('input[type=checkbox]').prop('checked', $(checkbox).prop('checked'));
		
	}	
	
	$(document).ready(function () {
		//奇偶行不同颜色
		$("#testcase_list tbody tr:odd").addClass("odd");
		$("#testcase_list tbody tr:even").addClass("even");
		
		//鼠标移动到行变色,单独建立css类hover
    	//tr:gt(0):表示获取大于 tr index 为0 的所有tr，即不包括表头
    	$("#testcase_list tr:gt(0)").hover(
    		function () { $(this).addClass("hover"); },
    		function () { $(this).removeClass("hover"); });    
		
		initTestCaseTypes();
    	initTestCodes();
    	initModule();
    	initFeature();
    	initFunction(); 
		});
	
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
	<div id="Main">
		<div class="appC">
			<form id="frmSearch" name="frmSearch" action="testcase!list.action" method="post" namespace="/" >
			
				<div id="formTable" class="rowClass">
				
					<div class="labelClass"><span>Test Set:</span></div>
					<select id="testType" name="testType" onchange="javascript:initTestCodes();"></select>
				
					<div class="labelClass"><span>Attack Type:</span></div>
					<select id="testCode" name="testCode"></select>
				</div>
				
				<div id="formTable" class="rowClass">				
				
					<div class="labelClass"><label>Module:</label></div>
					<select id="module" name="module" onchange="javascript:initFeature();"></select>
					
					<div class="labelClass"><label>Feature:</label></div>
					<select id="feature" name="feature" onchange="javascript:initFunction();"></select>
					
					<div class="labelClass"><label>Function:</label></div>
					<select id="function" name="function"></select>
					
				</div>
				
				<div id="formTable" class="rowClass">				
					<table border=0 cellpadding=0 cellspacing=0>
						<tr>
							<td><input type='radio' name='opFlag' value='0' style="width: 28px; ">Unselect</td>
						</tr>
						<tr>
							<td><input type='radio' name='opFlag' value='1' style="width: 28px; ">Select</td>
						</tr>
					</table>
					<input type="hidden" id="envid" name="envid" value="<s:property value='testEnvID'/>">
					<input type="submit" value="Search"/>
				</div>	
			</form>			
		</div>
	
		<div id="testcase_list">
			<table id="table" class="table table-striped table-bordered table-hover"  >
				<thead>
					<tr>
						<th width="25%" class="sortable">Test Set</th>
						<th width="15%">Attack Type</th>
						<th width="5%">Step</th>
						<th width="45%">Feature</th>
						<th width="10%">
							<s:set name="selected" id="selected" value="<s:property value='selected'/>" />
							<s:if test="selected==true">
								<input type="checkbox" name="checkAll" class="checkAll" checked="checked"
								       id="checkAll" onclick="selectAllTestCases(this);"/>Selected
							</s:if>
							<s:else>
								<input type="checkbox" name="checkAll" class="checkAll"
								       id="checkAll" onclick="selectAllTestCases(this);"/>Selected
							</s:else>
						</th>
						
					</tr>
				</thead>
				<tbody>
					<s:iterator value="testCases" status="st">						
					 	<tr id='<s:property value="ID"/>'>
					 		<td style='text-align:left; padding: 10px;'><s:property value="testType" escapeHtml="false"/></td>
							<td style='text-align:left; padding: 10px;'><s:property value="testCode" escapeHtml="false"/></td>
							<td style='text-align:center; padding: 10px;'><s:property value="testCaseStep" escapeHtml="false" /></td>
							<td style='text-align:left; padding: 10px;'><s:property value="module" escapeHtml="false" /> -> <s:property value="feature" escapeHtml="false" /> -> <s:property value="function" escapeHtml="false" /></td>	
							<td style='text-align:center; padding: 10px;'>
								<s:set name="selected" id="selected" value="<s:property value='selected'/>" />
								<!--为了显示出勾选与否的效果 -->
								<s:if test="selected==true">
									<input name="check" value="<s:property value='ID'/>" checked="checked"  type="checkbox"
										   onclick="javascript:selectOneTestCase(this, <s:property value="ID"/>)">
								</s:if>
								<s:else>				
									<input name="check" value="<s:property value='ID'/>" type="checkbox"
										   onclick="javascript:selectOneTestCase(this, <s:property value="ID"/>)">
								</s:else>
							</td>													
						</tr>						
					</s:iterator>							
				</tbody>
			</table>
			
			<pager:pages pageNo="pageNo" total="total" styleClass="page" theme="number"></pager:pages><br/><br/>
    		<a href="testresult.action?envid=<s:property value='TestEnvID'/>">返回</a>
		</div>
	</div>		
</body>
</html>
