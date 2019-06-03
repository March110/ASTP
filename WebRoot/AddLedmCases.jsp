<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>Add LEDM Test Case</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/displaytag.css">
	<link rel="stylesheet" type="text/css" href="css/additem.css">
	<link rel="stylesheet" type="text/css" href="css/common_style.css">
	<script type="text/javascript" src="javascript/jquery-1.9.1.min.js"></script>
</head>
<script type="text/javascript">
	function SelectTestCase(chkbox, id){
		var checked = $(chkbox).is(':checked');
		$.ajax({
				type : 'post', 
				url : 'testcase.action',
				data : "op=select&TestCaseId=" + id + "&checked="  + checked, 
				success : function(result) {
							if("success" != result)
							{
								alert("Failed to save, the detailed root case:" + result);
							}
						}, 
				error : function(result) {
							alert("Failed to save, the detailed root case:" + result);
						} 
				});
		}
		
		
		function onMouseOver()
		{
			
		}
		
		
</script>
<body>
	<a href="#" target="facult" onMouseOver="onMouseOver()" onMouseOut="onMouseOut()">Literature</a>
	<div id="Main">
		<div class="appC">
			<form id="searchForm" name="frmSearch" action="rtestcase.action" method="post" namespace="/" >
				<table class="searchT">
					<tbody>
						<tr>
							<td>TestCase Type:<input id="testtype" name="testtype" type="text"> 
							      Attack Type:<input id="testcode" name="testcode" type="text">
							      <input type="hidden" id="op" name="op" value="list">
								&nbsp;&nbsp; <input type="submit" value="Search"/>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		<br>
		<div id="roles">
			<table id="row"  >
				<thead>
					<tr>
						<th width="4%" class="sortable">Test Set</th>
						<th width="4%">DS_STEP_NAME</th>
						<th width="30%">DS_Descrption</th>
						<th width="20%">DS_Expection</th>
						<th width="5%">Selected</th>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="testCases" status="st">
					 	<s:if test="#st.Even"> 
							<tr class="odd"> 
							</s:if>
						<s:else>
							<tr class="even">
						</s:else>
								<td style='text-align:center; padding: 10px;'><s:property value="testCode" escapeHtml="false"/></td>
								<td style='text-align:center;padding: 10px;'><s:property value="testCaseStep" escapeHtml="true" /></td>
								<td style='padding: 10px;'><p><s:property value="testCaseDesc" escapeHtml="false"/></p></td>
								<td style='padding: 10px;'><s:property value="expectResult" escapeHtml="false"/></td>
								<td style='text-align:center;padding: 10px;'><input name="check" value="776" type="checkbox" onclick="javascript:SelectTestCase(this, 1)"></td>													
							</tr>
						
					</s:iterator>							
				</tbody>
			</table>
			
				<a href="testcase.action?envid=<s:property value='testEnvID'/>&startRow=0">First Page</a>&nbsp;
				<a href="testcase.action?envid=<s:property value='testEnvID'/>">Page Up</a>&nbsp;
				<a href="testcase.action?envid=<s:property value='testEnvID'/>">Next</a>&nbsp;
				<input class="" type="button" value="Page Up">&nbsp;
				<input name="page" size="8" style='width: 30px; height: 25px;'> &nbsp;
				<input style="width: 30px; height: 22px;" name="GgPage" value="GO"	onClick="" type="button">						
		
		</div>
	</div>		
</body>
</html>
