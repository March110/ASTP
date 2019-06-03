package com.beyondsoft.astp.actions;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.beyondsoft.astp.common.model.TestEnvModel;
import com.beyondsoft.astp.common.service.TestEnvService;
import com.beyondsoft.astp.common.service.TestResultService;
import com.beyondsoft.astp.core.util.AVContext;

public class TestEnvAction extends PageAction {
	
	private static final long serialVersionUID = -8538779235234004802L;
	private static TestEnvService TestEnvService = AVContext.getBean(TestEnvService.class);
	private static TestResultService TestResultService = AVContext.getBean(TestResultService.class);
	
	private String productName;
	private TestEnvModel testEnv;
	private List<TestEnvModel> testEnvList;
	private String message;
	
	@Override
	public void validate()
	{	
		if(this.testEnv == null)
		{
			this.getFieldErrors();		
			this.clearFieldErrors();
			this.clearActionErrors();
			this.clearErrorsAndMessages();
		}
		/*
		if(testEnv != null)
		{
			if(this.testEnv.getProductName() == null || this.testEnv.getProductName().trim().length() == 0)
			{
				System.out.println("Product Name: " + this.testEnv.getProductName());
				this.addFieldError("Product Name", "Product Name: reqiured");
			}
			
			if(this.testEnv.getFirmware() == null || this.testEnv.getFirmware().trim().length() == 0)
			{
				System.out.println("Firmware: " + this.testEnv.getFirmware());
				this.addFieldError("Firmware", "Firmware: reqiured");
			}			
			
			if(this.testEnv.getHardware() == null || this.testEnv.getHardware().trim().length() == 0)
			{
				System.out.println("Hardware: " + this.testEnv.getHardware());
				this.addFieldError("Hardware", "Hardware: reqiured");
			}
			
			if(this.testEnv.getOS() == null || this.testEnv.getOS().trim().length() == 0)
			{
				System.out.println("OS: " + this.testEnv.getOS());
				this.addFieldError("OS", "OS: reqiured");
			}
			
			if(this.testEnv.getNetworkType() == null || this.testEnv.getNetworkType().trim().length() == 0)
			{
				System.out.println("Network Type: " + this.testEnv.getNetworkType());
				this.addFieldError("Network Type", "OS: reqiured");
			}
			
			if(this.testEnv.getProtocolType() == null || this.testEnv.getProtocolType().trim().length() == 0)
			{
				System.out.println("Protocol Type: " + this.testEnv.getProtocolType());
				this.addFieldError("Protocol Type", "Protocol Type: reqiured");
			}
			
			if(this.testEnv.getIPv4Address() == null || this.testEnv.getIPv4Address().trim().length() == 0)
			{
				System.out.println("IPv4 Address: " + this.testEnv.getIPv4Address());
				this.addFieldError("IPv4 Address", "IPv4 Address: reqiured");
			}
			
			if(this.testEnv.getIPv4Port() == null || this.testEnv.getIPv4Port().trim().length() == 0)
			{
				System.out.println("IPv4 Port: " + this.testEnv.getIPv4Port());
				this.addFieldError("IPv4 Port", "IPv4 Port: reqiured");
			}
		}
		*/
	}
	
	@Override
	public String execute()
	{
		String result = SUCCESS;
		
		HttpServletRequest request = ServletActionContext.getRequest();
		if(testEnv == null)
		{
			testEnv = new TestEnvModel();
		}
		
		String method = request.getParameter("method");;
		if(method == null || "list".equals(method)) {
			result = list();
		} else if("toSelect".equals(method)) {
			result = select();
		}  else if("toDelete".equals(method)) {
			result = select();
		}  else if("toEdit".equals(method)) {
			result = edit();
		} else if("toAdd".equals(method)) {
			result = "toAdd";
		} 
		return result;
	}
	
	public String list()
	{
		try {
			
			HttpServletRequest request = ServletActionContext.getRequest();				
			String pageNo = request.getParameter("pageNo");			
			if(pageNo != null) {
				this.setPageNo(Integer.valueOf(pageNo));
			} else {
				this.setPageNo(1);
			}
			
			TestEnvModel testenv = new TestEnvModel();
			testenv.setProductName(productName);
			
			int totalRecords = TestEnvService.getTotalRecordCount(testenv);
			if(totalRecords < this.getPageSize()){
				this.setTotal(1);
			} else {
				this.setTotal((totalRecords + this.getPageSize()) / this.getPageSize() - 1);
			}
			
			testEnvList = TestEnvService.searchTestEnvModels(testenv, (this.getPageNo() - 1) * this.getPageSize(), this.getPageSize());
			
		} catch (Exception e) {
			e.printStackTrace();
			this.setMessage(e.getMessage());
		}

		return SUCCESS;
	}
	
	public String edit()
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		
		try {
			
			String pEnvid = request.getParameter("envid");
			Integer envid = Integer.valueOf(pEnvid);
			
			testEnv = TestEnvService.getTestEnvModel(envid);	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "toEdit";
	}
	
	public String save()
	{
		try {
			
			if(testEnv.getID() == null)
			{
				TestEnvService.addTestEnv(testEnv);
			} else {
				TestEnvService.updateTestEnv(testEnv);
			}
			
			list();
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}
	
	public String select()
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		
		try {
			
			String pEnvid = request.getParameter("envid");
			Integer envid = Integer.valueOf(pEnvid);
			
			testEnv = TestEnvService.getTestEnvModel(envid);	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "toTestCase";
	}
	
	public String delete()
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		try {
			
			String pEnvid = request.getParameter("envid");
			Integer envid = Integer.valueOf(pEnvid);
			
			TestEnvModel testenv = new TestEnvModel();
			testenv.setID(envid);			
			
			int result = TestEnvService.deleteTestEnv(testenv);	
			if(result == 1)
			{
				response.getWriter().write("success");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return NONE;
	}
	
	public String clearResult()
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		try {
			
			String pEnvid = request.getParameter("envid");
			Integer envid = Integer.valueOf(pEnvid);
			
			TestEnvModel testenv = new TestEnvModel();
			testenv.setID(envid);			
			
			int result = TestResultService.clearResult(envid);
			
			if(result > 0)
			{
				response.getWriter().write("success");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return NONE;
	}

	public List<TestEnvModel> getTestEnvList() {
		return testEnvList;
	}

	public void setTestEnvList(List<TestEnvModel> testEnvList) {
		this.testEnvList = testEnvList;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public TestEnvModel getTestEnv() {
		return testEnv;
	}

	public void setTestEnv(TestEnvModel testEnv) {
		this.testEnv = testEnv;
	}
}
