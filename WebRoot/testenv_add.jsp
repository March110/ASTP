<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html class=" ">
<head>
	<title>Test Environment</title>
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="css/common_style.css" media="all" rel="stylesheet" type="text/css">
</head>
<body class="contrast-red ">

	<div id="content" class="row-fluid"
		style="width: 550px;margin-left: auto;margin-top: auto;margin-right: auto;">
		
		<div style="color:red;">
			<s:fielderror/>
		</div>

		<div class="box-header blue-background">
			<div
				style="text-align:center;background:#3498DB;height: 20px;padding: 10px;">
				<span>Add Environment</span>
			</div>
		</div>
		<div class="box-content">
			<form action="testenv!save.action" method="post">
				<div class="control-group">
					<div class="spanClass">
						<label class="control-label" for="validation_name">Product
							Name</label>
					</div>
					<div class="controls">
						<input data-rule-minlength="2" data-rule-required="true"
							id="testEnv.ProductName" name="testEnv.ProductName" type="text"
							value="<s:property value='testEnv.ProductName'/>">
					</div>
				</div>

				<div class="control-group">
					<div class="spanClass">
						<label class="control-label" for="validation_name">Firmware</label>
					</div>
					<div class="controls">
						<input data-rule-minlength="2" data-rule-required="true"
							id="testEnv.Firmware" name="testEnv.Firmware" type="text"
							value="<s:property value='testEnv.Firmware'/>">
					</div>
				</div>
				<div class="control-group">
					<div class="spanClass">
						<label class="control-label" for="validation_name">Hardware</label>
					</div>
					<div class="controls">
						<input data-rule-minlength="2" data-rule-required="true"
							id="testEnv.Hardware" name="testEnv.Hardware" type="text"
							value="<s:property value='testEnv.Hardware'/>">
					</div>
				</div>
				<div class="control-group">
					<div class="spanClass">
						<label class="control-label" for="validation_name">OS</label>
					</div>
					<div class="controls">
						<input data-rule-minlength="2" data-rule-required="true"
							id="testEnv.OS" name="testEnv.OS" type="text"
							value="<s:property value='testEnv.OS'/>">
					</div>
				</div>

				<div class="control-group">
					<div class="spanClass">
						<label class="control-label" for="validation_name">NetworkType</label>
					</div>
					<div class="controls">
						<input data-rule-minlength="2" data-rule-required="true"
							id="testEnv.NetworkType" name="testEnv.NetworkType" type="text"
							value="<s:property value='testEnv.NetworkType'/>">
					</div>
				</div>

				<div class="control-group">
					<div class="spanClass">
						<label class="control-label" for="validation_name">Protocol
							Type</label>
					</div>
					<div class="controls">
						<input data-rule-minlength="2" data-rule-required="true"
							id="testEnv.ProtocolType" name="testEnv.ProtocolType" type="text"
							value="<s:property value='testEnv.ProtocolType'/>">
					</div>
				</div>

				<div class="control-group">
					<div class="spanClass">
						<label class="control-label" for="validation_name">IPv4
							Address</label>
					</div>
					<div class="controls">
						<input data-rule-minlength="2" data-rule-required="true"
							id="testEnv.IPv4Address" name="testEnv.IPv4Address" type="text"
							value="<s:property value='testEnv.IPv4Address'/>">
					</div>
				</div>

				<div class="control-group">
					<div class="spanClass">
						<label class="control-label" for="validation_name">IPv4
							Port</label>
					</div>
					<div class="controls">
						<input data-rule-minlength="2" data-rule-required="true"
							id="testEnv.IPv4Port" name="testEnv.IPv4Port" type="text"
							value="<s:property value='testEnv.IPv4Port'/>">
					</div>
				</div>

				<div class="control-group">
					<div class="spanClass">
						<label class="control-label" for="validation_name">IPv6
							Address</label>
					</div>
					<div class="controls">
						<input data-rule-minlength="2" data-rule-required="true"
							id="testEnv.IPv6Address" name="testEnv.IPv6Address" type="text"
							value="<s:property value='testEnv.IPv6Address'/>">
					</div>
				</div>

				<div class="control-group">
					<div class="spanClass">
						<label class="control-label" for="validation_name">IPv6
							Port</label>
					</div>
					<div class="controls">
						<input data-rule-minlength="2" data-rule-required="true"
							id="testEnv.IPv6Port" name="testEnv.IPv6Port" type="text"
							value="<s:property value='testEnv.IPv6Port'/>">
					</div>
				</div>

				<input type="hidden" id="testEnv.ID" name="testEnv.ID"
					value="<s:property value='testEnv.ID'/>">
				<div style="text-align:center;">
					<input type="submit" value="OK" />&nbsp;&nbsp; <a
						href="testenv.action?method=list" class="buttonClass"
						name="cancel">Cancel</a>
				</div>
			</form>
		</div>

	</div>
</body>
</html>