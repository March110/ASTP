package com.beyondsoft.astp.actions;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import com.beyondsoft.astp.common.model.TestEnvModel;
import com.beyondsoft.astp.common.model.TestResultModel;
import com.beyondsoft.astp.common.service.TestEnvService;
import com.beyondsoft.astp.common.service.TestResultService;
import com.beyondsoft.astp.core.util.AVContext;
import com.beyondsoft.common.ValidationUtil;


public class TestResultAction extends PageAction {

	private static final long serialVersionUID = -7524833467420974844L;
	private static TestResultService TestResultService = AVContext.getBean(TestResultService.class);
	private static TestEnvService TestEnvService = AVContext.getBean(TestEnvService.class);
	
	private List<TestResultModel> testresults = null;
	private TestResultModel testResult = null; // For search request
	private TestEnvModel testEnv;
	private int testEnvID = 0;
	private int totalRecords;
	
	@Override
	public void validate()
	{		
	}
	
	@Override
	public String execute()
	{		
		String result = SUCCESS;
		HttpServletRequest request = ServletActionContext.getRequest();
		
		String method = request.getParameter("method");;
		if(method == null || "list".equals(method)) {
				result = list();
		} else if("select".equals(method)) {
				result = select();
		} else if("delete".equals(method)) {				
				result = delete();
		} else if("view".equals(method)) {
				result = view();
		}
		
		return result;
	}
	
	/**
	 * Show the associated test case list
	 * 
	 * @return
	 */
	public String list() {

		try {		
			
			HttpServletRequest request = ServletActionContext.getRequest();
			
			// This is one required parameters.
			String pTestEnvID = request.getParameter("envid");
			this.testEnvID = Integer.valueOf(pTestEnvID);			
			testEnv = TestEnvService.getTestEnvModel(this.testEnvID);
			
			TestResultModel testresult = new TestResultModel();
			testresult.setTestEnvID(this.testEnvID);
			
			if(testResult != null)
			{
				if(testResult.getExecuteStatus() != null)
				{
					testresult.setExecuteStatus(testResult.getExecuteStatus());
				}
				
				if(testResult.getResponseCode() != null)
				{
					testresult.setResponseCode(testResult.getResponseCode());
				}
				
				if(testResult.getTestCase() != null)
				{
					testresult.setTestCase(testResult.getTestCase());
				}
			}
			
			String opFlag = request.getParameter("opFlag");
			if(opFlag != null && opFlag.trim().length() != 0)
			{
				if("0".equals(opFlag))
				{
					TestResultService.batchSelect(testEnvID, testResult.getTestCase(), 0);
				} 
				else if("1".equals(opFlag))
				{
					TestResultService.batchSelect(testEnvID, testResult.getTestCase(), 1);
				} 
				else if("2".equals(opFlag))
				{
					TestResultService.batchDelete(testEnvID, testResult.getTestCase());
				}
			}
			
			String pageNo = request.getParameter("pageNo");			
			if(pageNo != null) {
				this.setPageNo(Integer.valueOf(pageNo));
			} else {
				this.setPageNo(1);
			}
			
			totalRecords = TestResultService.getTotalRecordCount(testresult);
			if(totalRecords < this.getPageSize())
			{
				this.setTotal(1);
			} else {
				//this.setTotal((totalRecords + this.getPageSize()) / this.getPageSize() - 1);
				this.setTotal((totalRecords + this.getPageSize()) / this.getPageSize());
			}			
			
			testresults = TestResultService.searchTestResultModels(testresult, (this.getPageNo() - 1) * this.getPageSize(), this.getPageSize());
			for(TestResultModel result : testresults)
			{
				result.getTestCase().setTestCaseDesc(result.getTestCase().getTestCaseDesc().replace("\n", "<br/>"));
				result.getTestCase().setExpectResult(result.getTestCase().getExpectResult().replace("\n", "<br/>"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}
	
	public String select()
	{	
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		try {
			
			TestResultModel testresult = new TestResultModel();
			String checked = request.getParameter("checked");
			if("true".equals(checked))
			{
				testresult.setExecuteStatus("1");
			}
			else
			{
				testresult.setExecuteStatus("0");
			}			
			
			testresult.setRequestData("");
			testresult.setResponseData("");			
			testresult.setResponseCode("");
			testresult.setResult(0);
			
			String pResultiD = request.getParameter("resultid");
			Integer resultid = Integer.valueOf(pResultiD);
			testresult.setID(resultid);
			
			int result = TestResultService.updateTestResult(testresult);
			if(result == 1)
			{
				response.getWriter().write("success");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return NONE;
	}
	
	public String selectAll(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();

		try {

			String checked = request.getParameter("checked");
			String pResultiDs = request.getParameter("resultid");
			int resultLength = 0;
			String[] ids = null;
			
			if (!ValidationUtil.isEmpty(pResultiDs)) {
				
				ids = pResultiDs.split(",");
				//
				for (int i = 0; i < ids.length; i++) {

					TestResultModel testresult = new TestResultModel();
					Integer resultid = Integer.valueOf(ids[i]);
					testresult.setID(resultid);
					testresult.setRequestData("");
					testresult.setResponseData("");
					testresult.setResponseCode("");
					testresult.setResult(0);

					if ("true".equals(checked)) {//
						testresult.setExecuteStatus("1");
					} else {//
						testresult.setExecuteStatus("0");
					}
					
					resultLength += TestResultService.updateTestResult(testresult);
				}
			}

			if ((null != ids) && (resultLength == ids.length)) {
				response.getWriter().write("success");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return NONE;
	}
	
	public String selectAllPageCases(){
		
		
		
		return null;
		
	}
	
	public String delete()
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		try {
			
			TestResultModel testresult = new TestResultModel();
			
			String pResultiD = request.getParameter("resultid");
			Integer resultid = Integer.valueOf(pResultiD);
			testresult.setID(resultid);
			
			int result = TestResultService.deleteTestResult(testresult);
			if(result == 1)
			{
				response.getWriter().write("success");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return NONE;
	}
	
	public void updateExecuteResult()
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		try {
			
			TestResultModel testresult = new TestResultModel();	
			String pId = request.getParameter("id");
			Integer id = Integer.valueOf(pId);
			testresult.setID(id);
			
			String pResult = request.getParameter("result");
			
			if(pResult != null)
			{
				Integer result = Integer.valueOf(pResult);
				testresult.setResult(result);
				
				int row = TestResultService.updateTestResult(testresult);
				if(row == 1)
				{
					response.getWriter().write("success");
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
	}
	
	public void resendTestCase()
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		try {
			
			String pId = request.getParameter("id");
			Integer id = Integer.valueOf(pId);
				
			int result = TestResultService.executeOneTestCase(id);
			if(result == 1)
			{
				response.getWriter().write("success");
			}
			
		} catch (Exception e) {
			e.printStackTrace();			
		}
	}
	
	public String view()
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		String result = "viewTestResult";
		
		try {
			
			TestResultModel testresult = new TestResultModel();
			//testresult.setTestEnvID(this.testEnvID);
			
			String flag = request.getParameter("flag");			
			if("testcase".equalsIgnoreCase(flag))
			{
				result = "viewTestCase";
			} 
			
			String pId = request.getParameter("id");
			Integer id = Integer.valueOf(pId);
			testresult.setID(id);
			
			String pEnvId = request.getParameter("envid");
			if(pEnvId != null)
			{
				Integer envid = Integer.valueOf(pEnvId);
				testresult.setTestEnvID(envid);
			}			

			testresult = TestResultService.getTestResult(testresult);
			request.setAttribute("testresult", testresult);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public String perform() throws Exception
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		String pEnvid = request.getParameter("envid");
		testEnvID = Integer.valueOf(pEnvid);
		
		TestResultService.executeTestCase(testEnvID);
		
		list();
		
		return "toReview";
	}
	
	public void suspend() throws Exception
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		try {
			
			String pEnvId = request.getParameter("envid");
			Integer envid = Integer.valueOf(pEnvId);
				
			int result = TestResultService.suspend(envid);
			if(result == 1)
			{
				response.getWriter().write("success");
			}
			
		} catch (Exception e) {
			e.printStackTrace();			
		}
	}
	
	public String review()
	{		
		list();
		
		return "toReview";
	}
	

	public List<TestResultModel> getTestResults() {
		return testresults;
	}

	public void setTestResults(List<TestResultModel> testresults) {
		this.testresults = testresults;
	}

	public int getTestEnvID() {
		return testEnvID;
	}

	public void setTestEnvID(int testEnvID) {
		this.testEnvID = testEnvID;
	}

	public TestEnvModel getTestEnv() {
		return testEnv;
	}

	public void setTestEnv(TestEnvModel testEnv) {
		this.testEnv = testEnv;
	}

	public TestResultModel getTestResult() {
		return testResult;
	}

	public void setTestResult(TestResultModel testResult) {
		this.testResult = testResult;
	}

	public int getTotalRecords() {
		return totalRecords;
	}

	public void setTotalRecords(int totalRecords) {
		this.totalRecords = totalRecords;
	}


	
	
}
