package com.beyondsoft.astp.actions;

import com.beyondsoft.astp.common.model.User;
import com.opensymphony.xwork2.ActionSupport;

public class EditUserAction extends ActionSupport
{
	private static final long serialVersionUID = -4002330385178018383L;

	private User user = new User();
	
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
		user.setId(1);
		user.setPassword("12345");
		user.setUsername("admin");
		return SUCCESS;
	}
}