package com.beyondsoft.astp.actions;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.Response;

import org.apache.struts2.ServletActionContext;

import com.beyondsoft.astp.common.model.TestCaseModel;
import com.beyondsoft.astp.common.model.TestResultModel;
import com.beyondsoft.astp.common.service.TestCaseService;
import com.beyondsoft.astp.common.service.TestResultService;
import com.beyondsoft.astp.core.util.AVContext;
import com.beyondsoft.common.ValidationUtil;

public class TestCaseAction extends PageAction {

	private static final long serialVersionUID = -7524833467420974844L;
	private static TestCaseService TestCaseService = AVContext
			.getBean(TestCaseService.class);
	private static TestResultService TestResultService = AVContext
			.getBean(TestResultService.class);

	private int testEnvID = 0;
	private String testType;
	private String testCode;
	private String module;
	private String feature;
	private String function;
	private int step;
	private TestCaseModel testcase;
	private List<TestCaseModel> testcases;
	private String message;

	private int totalRecords;
	private int pageCount;

	@Override
	public void validate() {
		if (this.testcase == null) {
			this.getFieldErrors();
			this.clearFieldErrors();
			this.clearActionErrors();
			this.clearErrorsAndMessages();
		}
	}

	@Override
	public String execute() {
		String result = SUCCESS;

		HttpServletRequest request = ServletActionContext.getRequest();

		if (testcase == null) {
			testcase = new TestCaseModel();
		}

		String method = request.getParameter("method");
		;
		if (method == null || "list".equals(method)) {
			result = list();
		} else if ("select".equals(method)) {
			result = select();
		} else if ("delete".equals(method)) {
			result = delete();
		} else if ("view".equals(method)) {
			result = view();
		} else if ("toAdd".equals(method)) {
			result = "toEdit";
		}

		return result;
	}

	public String list() {
		try {

			HttpServletRequest request = ServletActionContext.getRequest();

			// This is one required parameters.
			String pTestEnvID = request.getParameter("envid");
			if (pTestEnvID != null && !"0".equalsIgnoreCase(pTestEnvID)) {
				this.testEnvID = Integer.valueOf(pTestEnvID);
			}

			String pageNo = request.getParameter("pageNo");
			if (pageNo != null) {
				this.setPageNo(Integer.valueOf(pageNo));
			} else {
				this.setPageNo(1);
			}

			TestCaseModel testcase = new TestCaseModel();
			testType = request.getParameter("testType");
			if (testType != null && testType.trim().length() != 0) {
				testcase.setTestType(testType);
			}

			testCode = request.getParameter("testCode");
			if (testCode != null && testCode.trim().length() != 0) {
				testcase.setTestCode(testCode);
			}

			module = request.getParameter("module");
			if (module != null && module.trim().length() != 0) {
				testcase.setModule(testType);
			}

			feature = request.getParameter("feature");
			if (feature != null && feature.trim().length() != 0) {
				testcase.setFeature(feature);
			}

			function = request.getParameter("function");
			if (function != null && function.trim().length() != 0) {
				testcase.setFunction(function);
			}

			String opFlag = request.getParameter("opFlag");
			if (opFlag != null && opFlag.trim().length() != 0) {
				if ("1".equals(opFlag)) {
					TestResultService.batchAdd(testEnvID, testcase);
				} else {
					TestResultService.batchDelete(testEnvID, testcase);
				}
			}

			if (step != 0) {
				testcase.setTestCaseStep(step);
			}

			totalRecords = TestCaseService.getTotalRecordCount(testcase);
			if (totalRecords < this.getPageSize()) {
				this.setTotal(1);
			} else {
				this.setTotal((totalRecords + this.getPageSize())
						/ this.getPageSize());
			}

			testcases = TestCaseService.searchTestCaseModels(testcase,
					(this.getPageNo() - 1) * this.getPageSize(),
					this.getPageSize());

			if (testcases != null) {
				TestResultModel testresult = new TestResultModel();
				testresult.setTestEnvID(this.testEnvID);
				testresult.setTestCase(new TestCaseModel());

				for (TestCaseModel temp : testcases) {
					testresult.getTestCase().setID(temp.getID());
					if (TestResultService.getTestResult(testresult) != null) {
						temp.setSelected(true);
					} else {
						temp.setSelected(false);
					}
					temp.setTestCaseDesc(temp.getTestCaseDesc().replace("\n",
							"<br/>"));
					temp.setExpectResult(temp.getExpectResult().replace("\n",
							"<br/>"));
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			this.message = e.getMessage();
		}

		return SUCCESS;
	}

	public String manage() {
		list();

		return "toManage";
	}

	public void save() throws IOException {
		HttpServletResponse response = ServletActionContext.getResponse();

		try {

			if (testcase.getID() == null) {
				TestCaseService.addTestCase(testcase);
			} else {
				TestCaseService.updateTestCase(testcase);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			response.sendRedirect("/ASTP/testcase!manage.action");
		}
	}

	public String edit() {
		HttpServletRequest request = ServletActionContext.getRequest();

		try {

			String id = request.getParameter("testcaseid");
			Integer testcaseId = Integer.valueOf(id);

			TestCaseModel tmpTestcase = new TestCaseModel();
			tmpTestcase.setID(testcaseId);

			testcase = TestCaseService.getTestCaseModel(tmpTestcase);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "toEdit";
	}

	public String select() {
		try {

			HttpServletRequest request = ServletActionContext.getRequest();
			HttpServletResponse response = ServletActionContext.getResponse();

			String pTestEnvID = request.getParameter("envid");
			this.testEnvID = Integer.valueOf(pTestEnvID);

			// This is one required parameters.
			String checked = request.getParameter("checked");
			String pTestcaseid = request.getParameter("testcaseid");
			int rtestCaseID = Integer.valueOf(pTestcaseid);

			TestResultModel testresult = new TestResultModel();
			testresult.setTestEnvID(testEnvID);
			testresult.setTestCase(new TestCaseModel());
			testresult.getTestCase().setID(rtestCaseID);
			if ("true".equals(checked)) {
				TestResultService.addTestResult(testresult);
			} else {
				TestResultService.deleteTestResult(testresult);
			}

			response.getWriter().write("success");

		} catch (Exception e) {
			e.printStackTrace();
			this.message = e.getMessage();
		}

		return NONE;
	}

	public String selectAll() {
		try {

			HttpServletRequest request = ServletActionContext.getRequest();
			HttpServletResponse response = ServletActionContext.getResponse();
			String selectAllOrNot = request.getParameter("selectAllOrNot");

			String pTestEnvID = request.getParameter("envid");
			this.testEnvID = Integer.valueOf(pTestEnvID);

			String selectedIds = request.getParameter("testcaseid");
			if (!ValidationUtil.isEmpty(selectedIds)) {
				String[] ids = selectedIds.split(",");

				for (int i = 0; i < ids.length; i++) {
					TestResultModel testresult = new TestResultModel();
					testresult.setTestEnvID(testEnvID);
					testresult.setTestCase(new TestCaseModel());
					testresult.getTestCase().setID(Integer.valueOf(ids[i]));
					if ("true".equals(selectAllOrNot)) {// ȫѡ
						TestResultService.addTestResult(testresult);
					} else {
						TestResultService.deleteTestResult(testresult);
					}
				}
				response.getWriter().write("success");
			}

		} catch (Exception e) {
			e.printStackTrace();
			this.message = e.getMessage();
		}
		return NONE;
	}

	public String selectAllPageCases() {
		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			HttpServletResponse response = ServletActionContext.getResponse();
			
			String pTestEnvID = request.getParameter("envid");
			if (pTestEnvID != null && !"0".equalsIgnoreCase(pTestEnvID)) {
				this.testEnvID = Integer.valueOf(pTestEnvID);
			}

			testcase = new TestCaseModel();
			testType = request.getParameter("testType");
			if (testType != null && testType.trim().length() != 0) {
				testcase.setTestType(testType);
			}
			testCode = request.getParameter("testCode");
			if (testCode != null && testCode.trim().length() != 0) {
				testcase.setTestCode(testCode);
			}

			module = request.getParameter("module");
			if (module != null && module.trim().length() != 0) {
				testcase.setModule(module);
			}

			feature = request.getParameter("feature");
			if (feature != null && feature.trim().length() != 0) {
				testcase.setFeature(feature);
			}
			function = request.getParameter("function");
			if (function != null && function.trim().length() != 0) {
				testcase.setFunction(function);
			}
			
			testcase.setTestCaseStep(1);
			testcase.setSelected(true);
			String opFlag = request.getParameter("opFlag");
			if (opFlag != null && opFlag.trim().length() != 0) {
				if ("1".equals(opFlag)) {
					TestResultService.batchAdd(testEnvID, testcase);
				} else {
					TestResultService.batchDelete(testEnvID, testcase);
				}
			}

//			if (step != 0) {
//				testcase.setTestCaseStep(step);
//			}
//
//			testcases = TestCaseService.searchTestCaseModels(testcase, 0, 0);

//			if (testcases != null) {
//				TestResultModel testresult = new TestResultModel();
//				testresult.setTestEnvID(this.testEnvID);
//				testresult.setTestCase(new TestCaseModel());
//
//				for (TestCaseModel temp : testcases) {
//					testresult.getTestCase().setID(temp.getID());
//					if (TestResultService.getTestResult(testresult) != null) {
//						temp.setSelected(true);
//					} else {
//						temp.setSelected(false);
//					}
//					temp.setTestCaseDesc(temp.getTestCaseDesc().replace("\n",
//							"<br/>"));
//					temp.setExpectResult(temp.getExpectResult().replace("\n",
//							"<br/>"));
//				}
//
//			}
			response.getWriter().write("success");

		} catch (Exception e) {
			e.printStackTrace();
			this.message = e.getMessage();
		}
		return SUCCESS;
	}

	public String delete() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();

		try {

			TestCaseModel testcase = new TestCaseModel();

			String pTestcaseId = request.getParameter("testcaseid");
			Integer testcaseId = Integer.valueOf(pTestcaseId);
			testcase.setID(testcaseId);

			int result = TestCaseService.deleteTestCase(testcase);
			if (result == 1) {
				response.getWriter().write("success");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return NONE;
	}

	public String view() {
		HttpServletRequest request = ServletActionContext.getRequest();

		try {

			TestCaseModel testcase = new TestCaseModel();

			String pTestcaseId = request.getParameter("testcaseid");
			Integer testcaseId = Integer.valueOf(pTestcaseId);
			testcase.setID(testcaseId);

			TestCaseService.getTestCaseModel(testcase);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return NONE;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public List<TestCaseModel> getTestCases() {
		return this.testcases;
	}

	public void setTestCases(List<TestCaseModel> testcases) {
		this.testcases = testcases;
	}

	public int getTestEnvID() {
		return testEnvID;
	}

	public void setTestEnvID(int testEnvID) {
		this.testEnvID = testEnvID;
	}

	public String getTestType() {
		return testType;
	}

	public void setTestType(String testtype) {
		this.testType = testtype;
	}

	public String getTestCode() {
		return testCode;
	}

	public void setTestCode(String testcode) {
		this.testCode = testcode;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public TestCaseModel getTestCase() {
		return testcase;
	}

	public void setTestCase(TestCaseModel testcase) {
		this.testcase = testcase;
	}

	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	public String getFeature() {
		return feature;
	}

	public void setFeature(String feature) {
		this.feature = feature;
	}

	public String getFunction() {
		return function;
	}

	public void setFunction(String function) {
		this.function = function;
	}

	public long getTotalRecords() {
		return totalRecords;
	}

	public void setTotalRecords(int totalRecords) {
		this.totalRecords = totalRecords;
	}



}
