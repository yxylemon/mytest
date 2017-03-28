package com.jxlg.bean;


import org.codehaus.jackson.annotate.JsonIgnoreProperties;
@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","fieldHandler"}) 
public class Orderstatus implements java.io.Serializable {
	
	// Fields
	
	private Integer statusid;//订单状态id
	private String name;//状态名
	private String description;//描述
	
	
	// Constructors
	
	/** default constructor */
	public Orderstatus() {
	}
	
	
	/**  full constructor  */
	
	// property accessors
	
	public Integer getStatusid() {
		return statusid;
	}


	public void setStatusid(Integer statusid) {
		this.statusid = statusid;
	}
	
	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}
}
