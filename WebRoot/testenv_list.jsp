<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pager" uri="/pagerTag"%>
<%@ taglib prefix="breadcrumb" uri="/breadcrumbTag"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="css/displaytag.css">
<link rel="stylesheet" type="text/css" href="css/additem.css">
<link rel="stylesheet" type="text/css" href="css/navigation-bars.css" media="screen"/>	
<link rel="stylesheet" type="text/css" href="css/navigation-bar-font-awesome.css"/>
<link rel="stylesheet" href="css/nyroModal.css" type="text/css" media="screen">
<link rel="stylesheet" type="text/css" href="css/common_style.css">
<script type="text/javascript" src="javascript/jquery-1.9.1.min.js"></script>
	<style>
		.page
		{			
			color: #000;
		}
		
		.page a
		{
			padding: 2px;
			border-radius: 5px;
			border: 1px solid #000;
			text-decoration: none;
		}
	</style>
</head>
<script type="text/javascript">
	$(document).ready(function () {
		$("#testenv_list tbody tr:odd").addClass("odd");
		$("#testenv_list tbody tr:even").addClass("even");
		

    	$("#testenv_list tr:gt(0)").hover(
    		function () { $(this).addClass("hover"); },
    		function () { $(this).removeClass("hover"); });    
		});
		
	function perform(flag, envid)
	{		
		$.ajax({
				type : 'post', 
				url : 'testenv!' + flag + '.action',
				data : "envid=" + envid,
				success : function(result) {
				
							if("success" != result)
							{
								alert("Failed to " + flag + ", the detailed root case:" + result);
							} else {
							
								if("delete" == flag)
								{
									$("#" + envid).hide();
								}
							}
						}, 
				error : function(result) {
							alert("Failed to "+ flag + ", the detailed root case:" + result);
						} 
				});
	}
	
	function searchTestEnv()
	{
	}	

</script>
<body>	
	<breadcrumb:breadcrumbBar></breadcrumb:breadcrumbBar>
	<div id="Main">
 		<div class="appC">
 		<form action="testenv!list.action" namespace="/" method="POST">
			<div>
				<label>Product Name:</label>
				<input type="text" name="productName" id="productName" /> 
				<input type="submit" value="search"/>
				<a href="testenv.action?method=toAdd" class="buttonClass" name="add">
					<img src="images/add.gif" style="border: none;"><label>Add Environment </label>
				</a>
			</div>
		</form>
		<table class="table table-striped table-bordered table-hover">
		<thead>
 			<tr class="odd gradeX"> 
				<th color="#99FFFF">ProductName</th>
				<th>Firmware</th>
				<th>Hardware</th>
				<th>OS</th>
				<th>NetworkType</th>
				<th>IP</th>
				<th>Modify</th>
				<th>Clear</th>
				<th>Delete</th>
				<th>Select Environment </th>
			</tr>
		</thead>
		<tbody>
			<s:iterator value="TestEnvList" id="testenv" status="status">
			<s:property value='status.index'/>
				<tr id="<s:property value='ID'/>" >
					<td style="text-align:center;"><s:property value="#testenv.ProductName"/></td>
					<td style="text-align:center;"><s:property value="#testenv.Firmware"/></td>
					<td style="text-align:center;"><s:property value="#testenv.Hardware"/></td>
					<td style="text-align:center;"><s:property value="#testenv.OS"/></td>
					<td style="text-align:center;"><s:property value="#testenv.NetworkType"/></td>
					<td style="text-align:center;"><s:property value="#testenv.IPv4Address"/></td>
					<td style="text-align:center;">
						<a href="testenv.action?method=toEdit&envid=<s:property value='#testenv.ID'/>" class="nyroModal">
							<img src="images/edit.png" style="border: none;">
						</a>
					</td>
					<td style="text-align:center;">
						<a href="#" class="nyroModal" onclick="javascript:perform('clearResult', <s:property value="#testenv.ID"/>)">
							<img src="images/edit.png" style="border: none;">
						</a>
					</td>
					<td style="text-align:center;">
						<a href="#" class="delete" onclick="javascript:perform('delete', <s:property value="#testenv.ID"/>)">
							<img src="images/delete.gif" style="border: none;"> 
						</a>
					</td>
					 <td style="text-align:center;">
					 	<a href="testresult.action?envid=<s:property value="#testenv.ID"/>" class="select">
					 		<img src="images/blue-loading.gif" style="border: none;"> 
					 	</a>
					 </td>
				</tr>
			</s:iterator>
		</tbody>

	</table>
	</div>
	
	<pager:pages pageNo="pageNo" total="total" styleClass="page" theme="number"></pager:pages> 
</body>
</html>