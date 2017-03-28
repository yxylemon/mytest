package com.jxlg.bean;

import java.util.HashSet;
import java.util.Set;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","fieldHandler"}) 
public class Category implements java.io.Serializable{
	
	//Fields
	
	private Integer categoryid;
	private String name;
	private String description;
	//Constructors
	
	/** default constructor*/
	public Category() {
	}
	
	/**  minimal constructor */
	public Category(String name) {
		this.name = name;
	}
	
	
	/** full constructor*/

	//Property accessors
	
	public Integer getCategoryid() {
		return categoryid;
	}

	public void setCategoryid(Integer categoryid) {
		this.categoryid = categoryid;
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
