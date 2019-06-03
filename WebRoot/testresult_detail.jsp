<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="org.springframework.web.util.*"%>;
<%@ page import="com.beyondsoft.astp.common.model.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html class=" ">
<head>
	<title>Test Result</title>
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="css/common_style.css" media="all" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="javascript/jquery-1.9.1.min.js"></script>
</head>
 <%
	TestResultModel testresult = (TestResultModel)request.getAttribute("testresult");
	
	int id = 0;
	String requestMothod = "";
	String module = "";
	String feature = "";
	String function = "";
	String requestURL = "";
	String testStep = "";
	String testDescription = "";
	String requestData = "";
	String expectedResult = "";
	String testType = "";
	String testCode = "";
	String responseCode = "";
	String responseData = "";
	String result = "";
	
	if(testresult != null)
	{
		id = testresult.getID();
		if(testresult.getTestCase() != null)
		{
			requestMothod = testresult.getTestCase().getRequestMethod();
			module = testresult.getTestCase().getModule();
			feature = testresult.getTestCase().getFeature();
			function = testresult.getTestCase().getFunction();
			requestURL = testresult.getTestCase().getRequestUrl();
			testStep = testresult.getTestCase().getTestCaseStep().toString();
			testDescription = HtmlUtils.htmlEscape(testresult.getTestCase().getTestCaseDesc());
			testDescription = testDescription.replaceAll("\\n", "<br/>");
			
			requestData = HtmlUtils.htmlEscape(testresult.getRequestData());
			requestData = requestData.replaceAll("\\n", "<br/>");
			
			requestData = HtmlUtils.htmlEscape(testresult.getTestCase().getRequestData());
			requestData = requestData.replaceAll("\\n", "<br/>");
						
			expectedResult = HtmlUtils.htmlEscape(testresult.getTestCase().getExpectResult());
			expectedResult = expectedResult.replaceAll("\\n", "<br/>");
			
			testType = testresult.getTestCase().getTestType();
			testCode = testresult.getTestCase().getTestCode();
		}
		
		responseCode = testresult.getResponseCode();
		responseData = HtmlUtils.htmlEscape(testresult.getResponseData());
		responseData = responseData.replaceAll("\\n", "<br/>");
		result = testresult.getResult().toString();
		
	}
 %>
<body>
	<script type="text/javascript">
			
	function perform(flag)
	{		
		var id = <%=id%>
		var result = $("#txtExecuteResult").val();
		
		$.ajax({
				type : 'post', 
				url : 'testresult!' + flag + '.action',
				data : "id=" + id + "&result=" + result,
				success : function(result) {
				
							if("success" != result)
							{
								alert("Failed to " + flag + ", the detailed root case:" + result);
							} else {
							}
						}, 
				error : function(result) {
							alert("Failed to "+ flag + ", the detailed root case:" + result);
						} 
				});
	}
	</script>

	<div id="content" class="row-fluid" style="margin-left: auto;margin-top: auto;margin-right: auto;">
		<div class="box-header blue-background">
			<div style="text-align:center;background:#3498DB;height: 20px;padding: 10px;">
				<span>Test Result Info</span>
			</div>
		</div>
		<div class="box-content">
		<table border="1">
			<tr>
				<td>Test Type</td>
				<td><%=testType%></td>
			</tr>
			<tr>
				<td>Test Code</td>
				<td><%=testCode%></td>
			</tr>
			<tr>
				<td>Test Step</td>
				<td><%=testStep%></td>
			</tr>
			<tr>
				<td width="100px">Request Method</td>
				<td><%=requestMothod%></td>
			</tr>
			<tr>
				<td>Module</td>
				<td><%=module%></td>
			</tr>
			<tr>
				<td>Feature</td>
				<td><%=feature%></td>
			</tr>
			<tr>
				<td>Feature</td>
				<td><%=feature%></td>
			</tr>
			<tr>
				<td>Function</td>
				<td><%=function%></td>
			</tr>
			<tr>
				<td>Request URL</td>
				<td><%=requestURL%></td>
			</tr>			
			<tr>
				<td>Test Description</td>
				<td><%=testDescription%></td>
			</tr>		
			<tr>
				<td>Expected Result</td>
				<td><%=expectedResult%></td>
			</tr>
				<tr>
				<td>Request	Data</td>
				<td><%=requestData%></td>
			</tr>
			<tr>
				<td>Reponse Code</td>
				<td><%=responseCode%></td>
			</tr>
			<tr>
				<td>Reponse Data</td>
				<td><%=responseData%></td>
			</tr>
			<tr>
				<td>Execute Result</td>
				<td><input id="txtExecuteResult" name="txtExecuteResult" type="text" value="<%=result%>"> 
				&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" class="buttonClass" name="update" onclick="javascript:perform('updateExecuteResult')">Update</a>
				&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" class="buttonClass" name="cancel" onclick="javascript:perform('resendTestCase')">Resend</a></td>
			</tr>		
		</table>
	</div>
</body>
</html>