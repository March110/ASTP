<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pager" uri="/pagerTag"%>
<%@ taglib prefix="breadcrumb" uri="/breadcrumbTag"%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>LEDM Test Case Management</title>
	<link rel="stylesheet" type="text/css" href="css/displaytag.css">
	<link rel="stylesheet" type="text/css" href="css/additem.css">
	<link rel="stylesheet" type="text/css" href="css/common_style.css">
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
								var testtypes = result.split(',');
								var len = testtypes.length;
								var optionstring = "";  
								
								for(var i=0; i<len; i++)
								{
									optionstring += "<option value='" + testtypes[i] + "' >" + testtypes[i] + "</option>"; 
								}
								
								$("#TestType").html("<option value=''>Please select ...</option> " + optionstring);  
							}
						}, 
				error : function(result) {							
						} 
				});	
	}
	
	function initTestCodes()
	{
		var selectedTestType = $("#TestType").val();
		
		$.ajax({
				type : 'post', 
				url : 'testdata!getTestDataCodes.action',
				data : "testtype=" + selectedTestType, 
				success : function(result) {
							if(result != null && result != "")
							{
								var testcodes = result.split(',');
								var len = testcodes.length;
								var optionstring = "";  
								
								for(var i=0; i<len; i++)
								{
									optionstring += "<option value='" + testcodes[i] + "' >" + testcodes[i] + "</option>"; 
								}
								
								$("#TestCode").html("<option value=''>Please select ...</option> " + optionstring);  
							}
						}, 
				error : function(result) {							
						} 
				});	
		
	}
	
	function perform(flag, id)
	{		
		$.ajax({
				type : 'post', 
				url : 'testcase!' + flag + '.action',
				data : "testcaseid=" + id,
				success : function(result) {
				
							if("success" != result)
							{
								alert("Failed to " + flag + ", the detailed root case:" + result);
							} else {
							
								if("delete" == flag)
								{
									$("#" + id).hide();
								}
							}
						}, 
				error : function(result) {
							alert("Failed to "+ flag + ", the detailed root case:" + result);
						} 
				});
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
		});	
	
</script>
<body>
	<breadcrumb:breadcrumbBar></breadcrumb:breadcrumbBar>
	<div id="Main">
		<div class="appC">
			<form id="frmSearch" name="frmSearch" action="testcase!manage.action" method="post" namespace="/">
				<div>
					<span>Test Set:</span>
					 <select id="TestType" name="TestType" onchange="javascript:initTestCodes();">
					 	<option> ------- </option>
					 </select>
			    	<span>Test Type:</span>
			    	<select id="TestCode" name="TestCode">
					 	<option> ------- </option>
					 </select>
					 <span>Step:</span>
					 <input type="text" id="step" name="step">
			      	<input type="hidden" id="envid" name="envid" value="<s:property value='testEnvID'/>">&nbsp;&nbsp; 
			      	<input type="submit" value="Search"/>			
				</div>
			</form>
			<a href="testcase.action?method=toAdd" class="buttonClass" name="add">
					<img src="images/add.gif" style="border: none;"><label>Add Test Case </label>
			</a>
		</div>
	
		<div id="testcase_list">
			<table id="table" class="table table-striped table-bordered table-hover"  >
				<thead>
					<tr>
						<th style="text-align:center;">Test Type</th>
						<th style="text-align:center;">Test Set</th>
						<th style="text-align:center;">Step</th>
						<th style="text-align:center;">Descrption</th>
						<th style="text-align:center;">Expection</th>
						<th style="text-align:center;">Modify</th>
						<th style="text-align:center;">Delete</th>						
					</tr>
				</thead>
				<tbody>
					<s:iterator value="testCases" status="st">
					 	<tr id='<s:property value="ID"/>'>
					 		<td style='text-align:left; padding: 10px;'><s:property value="testType" escapeHtml="false"/></td>
							<td style='text-align:left; padding: 10px;'><s:property value="testCode" escapeHtml="false"/></td>
							<td style='text-align:left; padding: 10px;'><s:property value="testCaseStep" escapeHtml="true" /></td>
							<td style='text-align:left; padding: 10px;'><p><!-- s:property value="testCaseDesc" escapeHtml="false"/ --></p></td>
							<td style='text-align:left; padding: 10px;'><!-- s:property value="expectResult" escapeHtml="false"/ --></td>
							<td style="text-align:center;">
								<a href="testcase!edit.action?testcaseid=<s:property value='ID'/>" class="nyroModal">
									<img src="images/edit.png" style="border: none;">
								</a>
							</td>
							<td style="text-align:center;">
								<a href="#" class="delete" onclick="javascript:perform('delete', <s:property value='ID'/>)">
									<img src="images/delete.gif" style="border: none;"> 
								</a>
							</td>				
						</tr>						
					</s:iterator>							
				</tbody>
			</table>
			
			<pager:pages pageNo="pageNo" total="total" styleClass="page" theme="number"></pager:pages><br/><br/> 
		</div>
	</div>		
</body>
</html>
