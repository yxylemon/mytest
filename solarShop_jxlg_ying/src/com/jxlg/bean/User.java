package com.jxlg.bean;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","fieldHandler"}) 
public class User implements java.io.Serializable{

	// Fields
	
	private String userid;//用户id
	private String password;//用户名密码
	// Constructors
	
	/** default constructor */
	public User() {
	}
	

	/** full constructor */


	// Property accessors
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}


	@Override
	public String toString() {
		return "User [userid=" + userid + ", password=" + password + "]";
	}
}
