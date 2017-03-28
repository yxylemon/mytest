package com.jxlg.bean;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","fieldHandler"}) 
public class Orderline implements java.io.Serializable{

	//Fields
	
	private Integer lineid;//订单项id
	private String orderId;//订单id
	private Integer productId;//产品id
	private String productName;//产品名字
	private Integer amount;//产品数量
	private String userId;//用户id
	private Integer isFinished;//订单项状态，0表示该订单项没有生成订单，1表示生成定单了
	private Double unitPrice;//单价
	//Constructors
	
	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}
	public Double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public Integer getIsFinished() {
		return isFinished;
	}

	public void setIsFinished(Integer isFinished) {
		this.isFinished = isFinished;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	/** default constructor*/
	public Orderline() {
	}
	
	/** minimal constructor*/
	public Orderline(Integer amount) {
		this.amount = amount;
	}
	
	/** full constructor*/

	//Property accessors
	
	public Integer getLineid() {
		return lineid;
	}

	public void setLineid(Integer lineid) {
		this.lineid = lineid;
	}

	
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}
}
