package com.beyondsoft.astp.actions;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.beyondsoft.astp.common.model.TestDataModel;
import com.beyondsoft.astp.common.service.TestDataService;
import com.beyondsoft.astp.core.util.AVContext;
import com.opensymphony.xwork2.ActionSupport;

public class TestDataAction extends  ActionSupport {

	private static final long serialVersionUID = 5930500793449428971L;
	private static TestDataService TestDataService = AVContext.getBean(TestDataService.class);
	
	public String getTestDataType()
	{
		HttpServletResponse response = ServletActionContext.getResponse();		
		List<String> datatypes = new ArrayList<String>();
		
		try 
		{			
			List<TestDataModel> testdatas = TestDataService.getAllTestDataModels();			
			for(TestDataModel testdata : testdatas)
			{
				if(!datatypes.contains(testdata.getTestType()))
				{
					datatypes.add(testdata.getTestType());					
				}
			}
			
			String result = "";
			for(String datatype : datatypes)
			{
				result += datatype + ",";
			}
			
			if(result.length() > 1)
			{
				result = result.substring(0, result.length() - 1);
			}
			
			response.getWriter().write(result);
			
		} catch (Exception e) {			
			e.printStackTrace();
		}
		
		return NONE;
	}
	
	public String getTestDataCodes()
	{
		List<String> testcodes = new ArrayList<String>();
		
		try {
			
			HttpServletRequest request = ServletActionContext.getRequest();
			HttpServletResponse response = ServletActionContext.getResponse();
			
			// This is one required parameters.
			String testtype = request.getParameter("testtype");
			TestDataModel testDataModel = new TestDataModel();
			testDataModel.setTestType(testtype);
			List<TestDataModel> testdatas = TestDataService.getTestDataModels(testDataModel);
			
			for(TestDataModel testdata : testdatas)
			{
				if(!testcodes.contains(testdata.getTestCode()))
				{
					testcodes.add(testdata.getTestCode());
				}
			}
			
			String result = "";
			for(String testcode : testcodes)
			{
				result += testcode + ",";
			}
			
			if(result.length() > 1)
			{
				result = result.substring(0, result.length() - 1);
			}
			
			response.getWriter().write(result);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return NONE;
	}
}
