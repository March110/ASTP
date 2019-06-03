package com.beyondsoft.astp.actions;


public class PageAction extends BaseAction
{
	private static final long serialVersionUID = 4831560043258406194L;

	private Integer pageNo = 1;
	private Integer pageSize = 100;
	private Integer total = 0;

	public Integer getPageNo()
	{
		return pageNo;
	}
	public void setPageNo(Integer pageNo)
	{
		this.pageNo = pageNo;
	}

	public Integer getPageSize()
	{
		return pageSize;
	}	
	public void setPageSize(Integer pageSize)
	{
		this.pageSize = pageSize;
	}

	public Integer getTotal()
	{
		return total;
	}
	public void setTotal(Integer total)
	{
		this.total = total;
	}	
	
	public String execute() throws Exception 
	{
		return SUCCESS;
	}		
	
	
	 
}