package com.beyondsoft.astp.actions;

import com.beyondsoft.astp.common.model.User;
import com.beyondsoft.astp.common.service.UserService;
import com.beyondsoft.astp.core.util.AVContext;
import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends  ActionSupport
{
	private User user;

	private static final long serialVersionUID = 869075830262031647L;
	
	public User getUser()
	{
		return user;
	}
	
	public void setUser(User user)
	{
		this.user = user;
	}
	
	public String execute() throws Exception 
	{
		UserService userService = AVContext.getBean(UserService.class);
		
		userService.login(user);
		
		return SUCCESS;
	}
}