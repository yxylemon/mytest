package com.jxlg.bean;

import java.util.HashSet;
import java.util.Set;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","fieldHandler"}) 
public class Payway implements java.io.Serializable{

	//Fields 
	
	private Integer paywayid;//付款id
	private String paystyle;//付款方式
	
	//Constructors
	
	/** default constructor */
	public Payway() {
	}
	
	/** full constructor */

	// property accessors
	
	public Integer getPaywayid() {
		return paywayid;
	}

	public void setPaywayid(Integer paywayid) {
		this.paywayid = paywayid;
	}

	public String getPaystyle() {
		return paystyle;
	}

	public void setPaystyle(String paystyle) {
		this.paystyle = paystyle;
	}

}
