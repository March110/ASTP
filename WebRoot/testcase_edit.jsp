<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html class=" ">
<head>
    <title>Test Case</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="css/common_style.css" media="all" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="javascript/jquery-1.9.1.min.js"></script>
</head>
<script type="text/javascript">	

	var requestMethod = "<s:property value='TestCase.RequestMethod'/>";
	var module = "<s:property value='TestCase.Module'/>";
	var feature = "<s:property value='TestCase.Feature'/>";
	var func = "<s:property value='TestCase.Function'/>";
	var requestUrl = "<s:property value='TestCase.RequestUrl'/>";
	var RAPIModelArray = new Array();
		
	/*function isExistsOptionItem(objSelect, objItemValue)
	{
		var isExists = false;
		for(var i = 0; i < objSelect.options.length; i++)
		{
			if(objSelect.options[i].value == objItemValue)
			{
				isExists = true;
				break;
			}
		}
		
		return isExists;	
	}
	
	function addOptionItemToSelect(objSelect, objItemText, objItemValue)
	{
		if(isExistsOptionItem(objSelect, objItemValue))	{
			
		} else {
			var item = new Option(objItemText, objItemValue);
			objSelect.options.add(item);
		}
	}*/
	
	function initRequestMethod(method) {
		 var objSelect = document.getElementById("testCase.RequestMethod");
		 
		 for(var i=0; i<objSelect.options.length; i++) {
		  
		 	if(objSelect.options[i].value == method) { 
 				objSelect.options[i].selected=true; 
				break; 
			} 
		}
	}
	
	function initModules(module)
	{
		$.ajax({
				type : 'post', 
				url : 'apiaction_getModules',
				data : "module=" + module, 
				//dataType:"json",
				success : function(result) {
							if(result != null && result != "")
							{
								//alert("Result:" + result);
								var objSelect = document.getElementById("testCase.Module");
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
									// Set the selected item
									if(module == items[i])
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
	
	function initFeatures(module, feature)
	{
		if(module == "")
		{
			var objSelect = document.getElementById("testCase.Feature");
			objSelect.options.length = 0;
								
			// Default empty option
			var item = new Option("----", "");
			item.selected = true;
			objSelect.options.add(item);
			
			return;
		}
		
		$.ajax({
				type : 'post', 
				url : 'apiaction_getFeatures',
				data : "module=" + module + "&feature=" + feature,
				//dataType:"json",
				success : function(result) {
							if(result != null && result != "")
							{
								//alert("Result:" + result);
								var objSelect = document.getElementById("testCase.Feature");
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
									// Set the selected item
									if(feature == items[i])
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
	
	function initFunctions(module, feature, func)
	{
		if(feature == "")
		{
			var objSelect = document.getElementById("testCase.Function");
			objSelect.options.length = 0;
								
			// Default empty option
			var item = new Option("----", "");
			item.selected = true;
			objSelect.options.add(item);
			
			return;
		}
		
		$.ajax({
				type : 'post', 
				url : 'apiaction_getFunctions',
				data : "module=" + module + "&feature=" + feature + "&function=" + func,
				//dataType:"json",
				success : function(result) {
							if(result != null)
							{
								//alert("Result:" + result);
								var objSelect = document.getElementById("testCase.Function");
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
									// Set the selected item
									if(func == items[i])
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
	
	function initRequestUrls(module, feature, func, requestMethod, requestUrl)
	{
		RAPIModelArray = []; // Remove all api model.
		
		if(func == "")
		{
			var objSelect = document.getElementById("testCase.RequestUrl");
			objSelect.options.length = 0;
								
			// Default empty option
			var item = new Option("----", "");
			item.selected = true;
			objSelect.options.add(item);
								
			return;
		}
		
		$.ajax({
				type : 'post', 
				url : 'apiaction_getRequestUrls',
				data : {
							Module: module,
							Feature: feature,
							Function: func,
							RequestMethod: requestMethod
					   },
				dataType:"json",
				success : function(result) {
							if(result != null && result.success)
							{
								//alert("Result:" + result);
								var objSelect = document.getElementById("testCase.RequestUrl");
								objSelect.options.length = 0;
								
								// Default empty option
								var item = new Option("----", "");
								item.selected = true;
								objSelect.options.add(item);
								
								var apis = result.apis;
								var len = apis.length;
								for(var i=0; i<len; i++)
								{	
									var apiModel = apis[i];						
									var option = new Option(apiModel.requestUrl, apiModel.requestUrl);
									// Set the selected item
									if(requestUrl == apiModel.requestUrl)
									{
										option.selected = true;
										$("#testCase\\.RAPIID").val(apiModel.ID);
										$("#testCase\\.RequestData").val(apiModel.requestData);	
									}
									
									objSelect.options.add(option);
									RAPIModelArray.push(apiModel);
								}
							}
						}, 
				error : function(result) {							
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
		
		initRequestMethod(requestMethod);
		initModules(module);
		initFeatures(module, feature);
		initFunctions(module, feature, func);
		initRequestUrls(module, feature, func, requestMethod, requestUrl);
		//initModules("getFunctions", "testCase.Function", func, module, feature, "", requestMethod);
	});	
	
	
	function updateRequestMethod(ctrSelect)
	{
	}
	
	function updateModule(ctrSelect)
	{
		var ctrModule = document.getElementById("testCase.Module");
		var ctrFeature = document.getElementById("testCase.Feature");
		var ctrFunction = document.getElementById("testCase.Function");
		var ctrRequestUrl = document.getElementById("testCase.RequestUrl");
		
		var selectedModule = ctrModule.options[ctrModule.selectedIndex].value;		
		ctrFeature.options.length = 0;
		ctrFunction.options.length = 0;
		ctrRequestUrl.options.length = 0;
		RAPIModelArray = [];
		
		initFeatures(selectedModule, feature);
		
		if(selectedModule == module) {
			initFunctions(selectedModule, feature, func);
			initRequestUrls(selectedModule, feature, func, requestMethod, requestUrl);
		} else {
				
			var option1 = new Option("----", "");
			option1.selected = true;	
			ctrFunction.options.add(option1);
			
			var option2 = new Option("----", "");
			option2.selected = true;	
			ctrRequestUrl.options.add(option2);
			
			//var ctrRAPIID = document.getElementById("testCase.RAPIID");
			//ctrRAPIID.value;
			$("#testCase\\.RAPIID").val("");
			$("#testCase\\.RequestData").val("");			
		}		
	}
	
	function updateFeature(ctrSelect)
	{
		var ctrModule = document.getElementById("testCase.Module");
		var ctrFeature = document.getElementById("testCase.Feature");
		var ctrFunction = document.getElementById("testCase.Function");
		var ctrRequestUrl = document.getElementById("testCase.RequestUrl");
		
		var selectedModule = ctrModule.options[ctrModule.selectedIndex].value;	
		var selectedFeature = ctrFeature.options[ctrFeature.selectedIndex].value;		
		ctrFunction.options.length = 0;
		ctrRequestUrl.options.length = 0;		
		RAPIModelArray = [];
		
		initFunctions(selectedModule, selectedFeature, func);
		
		if(selectedFeature == feature) {			
			initRequestUrls(selectedModule, selectedFeature, func, requestMethod, requestUrl);
		} else {
			var option = new Option("----", "");
			option.selected = true;	
			ctrRequestUrl.options.add(option);
			$("#testCase\\.RAPIID").val("");
			$("#testCase\\.RequestData").val("");
		}
	}
	
	function updateFunction(ctrSelect)
	{
		var ctrModule = document.getElementById("testCase.Module");
		var ctrFeature = document.getElementById("testCase.Feature");
		var ctrFunction = document.getElementById("testCase.Function");
		var ctrRequestUrl = document.getElementById("testCase.RequestUrl");
				
		var selectedModule = ctrModule.options[ctrModule.selectedIndex].value;	
		var selectedFeature = ctrFeature.options[ctrFeature.selectedIndex].value;
		var selectedFunction = ctrFunction.options[ctrFunction.selectedIndex].value;
		
		ctrRequestUrl.options.length = 0;
		RAPIModelArray = [];
		
		if(selectedFunction != "") {
			initRequestUrls(selectedModule, selectedFeature, selectedFunction, requestMethod, requestUrl);
		} else {
			var option = new Option("----", "");
			option.selected = true;	
			ctrRequestUrl.options.add(option);	
			$("#testCase\\.RAPIID").val("");
			$("#testCase\\.RequestData").val("");
		}		
	}
	
	function updateRequestUrl(ctrSelect)
	{
		/*
		var ctrModule = document.getElementById("testCase.Module");
		var ctrFeature = document.getElementById("testCase.Feature");
		var ctrFunction = document.getElementById("testCase.Function");
		var ctrRequestUrl = document.getElementById("testCase.RequestUrl");
		
		var selectedModule = ctrModule.options[ctrModule.selectedIndex].value;	
		var selectedFeature = ctrFeature.options[ctrFeature.selectedIndex].value;
		var selectedFunction = ctrFunction.options[ctrFunction.selectedIndex].value;		
		var selectedRequestUrl = ctrRequestUrl.options[ctrRequestUrl.selectedIndex].value;
		
		if(selectedRequestUrl != ""){
			initRequestUrls(selectedModule, selectedFeature, selectedFunction, requestMethod, selectedRequestUrl);
		}
		*/	
		
		/*
		var ctrRequestUrl = document.getElementById("testCase.RequestUrl");
		var selectedRequestUrl = ctrRequestUrl.options[ctrRequestUrl.selectedIndex].value;
		if(selectedRequestUrl == "")
		{
			$("#testCase\\.RAPIID").val("");
		} else {		
			var len = RAPIModelArray.length;
			for(var i=0; i<len; i++)
			{
				var apiModel = RAPIModelArray[i];
				if(selectedRequestUrl == apiModel.requestUrl)
				{
					$("#testCase\\.RAPIID").val(apiModel.ID);
					break;
				}
			}
		}
		*/
		
		var ctrRequestUrl = document.getElementById("testCase.RequestUrl");
		if(ctrRequestUrl.selectedIndex > 0)
		{
			var apiModel = RAPIModelArray[ctrRequestUrl.selectedIndex - 1];	
			$("#testCase\\.RAPIID").val(apiModel.ID);
			$("#testCase\\.RequestData").val(apiModel.requestData);		
		}
	}
	
</script>
<body class="contrast-red ">
<div id="content"  class="row-fluid" style="margin-left: auto;margin-top: auto;margin-right: auto;">
        
              <div class="box-header blue-background">
                  <div  style="text-align:center;background:#3498DB;height: 20px;padding: 10px;"><span>Test Case</span></div>
              </div>
              <div class="box-content">
                  <form action="testcase!save.action" method="post">
                  	<div style="color:red;">
						<s:fielderror/>
					</div>
					
                  	<div class="control-group">
                           <div class="spanClass"><label class="control-label" for="validation_name">Request Method</label></div>
                           <div class="controls">
                           		<select id="testCase.RequestMethod" name="testCase.RequestMethod" onchange="javascript:updateRequestMethod(this)">
                               		<option value="" selected>----</option>
                               		<option value="PUT">PUT</option>
                               		<option value="POST">POST</option>
                               	</select>
                          </div>
                    </div>
                	
                  	<div class="control-group">
                         <div class="spanClass"><label class="control-label" for="validation_name">Module</label></div>
                          <div class="controls">
                              <select id="testCase.Module" name="testCase.Module" onchange="javascript:updateModule(this)"></select>
                           </div>
                	</div>

					<div class="control-group">
                           <div class="spanClass"> <label class="control-label" for="validation_name">Feature</label></div>
                           <div class="controls">
                               <select id="testCase.Feature" name="testCase.Feature" onchange="javascript:updateFeature(this)"></select>
                           </div>
                    </div>
                    
					<div class="control-group">
                           <div class="spanClass"> <label class="control-label" for="validation_name">Function</label></div>
                           <div class="controls">
                               <select id="testCase.Function" name="testCase.Function" onchange="javascript:updateFunction(this)"></select>
                           </div>
                    </div>
                    
                    <div class="control-group">
                          <div class="spanClass"> <label class="control-label" for="validation_name">Request URL</label></div>
                          <div class="controls">
                              <select id="testCase.RequestUrl" name="testCase.RequestUrl" onchange="javascript:updateRequestUrl(this)"></select>
                          </div>
                     </div>
                     
                     <input type="hidden" id="testCase.RAPIID" name="testCase.RAPIID" value="<s:property value='TestCase.RAPIID'/>"></input>             
                      
                      <div class="control-group">
                          <div class="spanClass"> <label class="control-label" for="validation_name">Test Step</label></div>
                          <div class="controls">
                              <input id="testCase.TestCaseStep" name="testCase.TestCaseStep" type="text" value="<s:property value='TestCase.TestCaseStep'/>"></input>
                          </div>
                      </div>
                      
                      <div class="control-group">
                          <div class="spanClass"><label class="control-label" for="validation_name">Test Description</label></div>
                          <div class="controls">
                              <textarea id="testCase.TestCaseDesc" name="testCase.TestCaseDesc" rows="10" cols="80"><s:property value='TestCase.TestCaseDesc'/></textarea>
                          </div>
                      </div>
                      
                      <div class="control-group">
                          <div class="spanClass"><label class="control-label" for="validation_name">Request Data</label></div>
                          <div class="controls">
                              <textarea id="testCase.RequestData" name="testCase.RequestData" rows="10" cols="80"><s:property value='TestCase.RequestData'/></textarea>
                          </div>
                      </div>
                      
                      <div class="control-group">
                          <div class="spanClass"><label class="control-label" for="validation_name">Expected Result</label></div>
                          <div class="controls">
                              <textarea id="testCase.ExpectResult" name="testCase.ExpectResult" rows="10" cols="80"><s:property value='TestCase.ExpectResult'/></textarea>
                          </div>
                      </div>
                      
                      <div class="control-group">
                          <div class="spanClass"><label class="control-label" for="validation_name">Test Type</label></div>
                          <div class="controls">
                              <input id="testCase.TestType" name="testCase.TestType" type="text" value="<s:property value='TestCase.TestType'/>"></input>
                          </div>
                      </div>
                      
                      <div class="control-group">
                          <div class="spanClass"><label class="control-label" for="validation_name">Test Code</label></div>
                          <div class="controls">
                              <input id="testCase.TestCode" name="testCase.TestCode" type="text" value="<s:property value='TestCase.TestCode'/>"></input>
                          </div>
                      </div>
                      
                      <input type="hidden" id="testCase.ID" name="testCase.ID" value="<s:property value='TestCase.ID'/>"></input>
                      
                      <div style="text-align:center;">
						<input type="submit" value="OK"/>&nbsp;&nbsp;
						 <a	href="testcase!manage.action" class="buttonClass" name="cancel">Cancel</a>
					  </div>
					  
                    </form>
                    <br/>                  
                </div>
                   
</div>
</body></html>