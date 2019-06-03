package com.beyondsoft.astp.actions;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.ServletActionContext;
import com.beyondsoft.astp.common.model.APIModel;
import com.beyondsoft.astp.common.service.APIService;
import com.beyondsoft.astp.core.util.AVContext;
import com.opensymphony.xwork2.ActionSupport;

public class APIAction extends ActionSupport {

	private static final long serialVersionUID = -1739117704721252903L;
	private static APIService APIService = AVContext.getBean(APIService.class);
	private String result = "";
	private Map<String,Object> dataMap; 
	
	public void getModules()
	{
		HttpServletResponse response = ServletActionContext.getResponse();

		try {
			
			List<String> modules = APIService.getModules();
            
            String result = "";
			for(String module : modules)
			{
				result += module + ",";
			}
			
			if(result.length() > 1)
			{
				result = result.substring(0, result.length() - 1);
			}
			
			response.getWriter().write(result);
			
		} catch (Exception e) {			
			e.printStackTrace();
		}
	}
	
	public void getFeatures()
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		String module = request.getParameter("module");
		
		try {
			
			List<String> features = APIService.getFeatures(module);
			
			String result = "";
			for(String feature : features)
			{
				result += feature + ",";
			}
			
			if(result.length() > 1)
			{
				result = result.substring(0, result.length() - 1);
			}
			
			response.getWriter().write(result);
			
		} catch (Exception e) {			
			e.printStackTrace();
		}
	}
	
	public void getFunctions()
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		String module = request.getParameter("module");
		String feature = request.getParameter("feature");
		
		try {
			
			List<String> functions = APIService.getFunctions(module, feature);
			
			String result = "";
			for(String function : functions)
			{
				result += function + ",";
			}
			
			if(result.length() > 1)
			{
				result = result.substring(0, result.length() - 1);
			}
			
			response.getWriter().write(result);
			
		} catch (Exception e) {			
			e.printStackTrace();
		}
	}
	
	public String getRequestUrls()
	{		
		HttpServletRequest request = ServletActionContext.getRequest();
		String[] values = request.getParameterValues("Module");
		String module = values[0];		
		values = request.getParameterValues("Feature");
		String feature = values[0];
		values = request.getParameterValues("Function");
		String function = values[0];
		values = request.getParameterValues("RequestMethod");
		String requestMethod = values[0];
		
		APIModel api = new APIModel();
		api.setModule(module);
		api.setFeature(feature);
		api.setFunction(function);
		api.setRequestMethod(requestMethod);
		
		try {
			
			List<APIModel> apiModels = APIService.searchAPIModels(api, 0, 0);
			
			dataMap = new HashMap<String, Object>(); 
			dataMap.put("success", true); 
			dataMap.put("apis", apiModels.toArray());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return SUCCESS;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public Map<String,Object> getDataMap() {
		return dataMap;
	}

	public void setDataMap(Map<String,Object> dataMap) {
		this.dataMap = dataMap;
	}
}
