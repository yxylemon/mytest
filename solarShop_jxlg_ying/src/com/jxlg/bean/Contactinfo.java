package com.jxlg.bean;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","fieldHandler"}) 
public class Contactinfo implements java.io.Serializable{

	// Fields
	private Integer contactid;//用户信息id
	private	String  userId;//用户id
	private String street;//详细地址
	private String province;//省份
	private String city;//城市
	private String country;//县市
	private String zip;//
	private String email;//邮编
	private String cellphone;//电话
	
	// Constructors
	
	public String getCellphone() {
		return cellphone;
	}




	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}




	/** default constructor */
	public Contactinfo() {
	}
	
	


	// Property accessors
	public Integer getContactid() {
		return contactid;
	}

	public void setContactid(Integer contactid) {
		this.contactid = contactid;
	}

	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}



	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}


}
