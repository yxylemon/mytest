package com.jxlg.bean;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","fieldHandler"}) 
public class Order implements java.io.Serializable {

	//Fields
	
	private String orderid;//订单号
	private String name;//订单名
	private Integer finished;//是否完成支付
	private Double cost;//订单总价
	private String userId;//用户id
	private Integer orderstatusId;//订单状态
	private Integer paywayId;//付款方式
	private Integer refuned;//是否退款
	private Date  deadline;//订单提交时间
	//constructors
	
	public Date getDeadline() {
		return deadline;
	}

	public void setDeadline(Date deadline) {
		this.deadline = deadline;
	}

	public Integer getRefuned() {
		return refuned;
	}

	public void setRefuned(Integer refuned) {
		this.refuned = refuned;
	}

	/** default constructor */
	public Order() {
		
	}
	
	/** full constructor */

	//property accessors
	
	public String getOrderid() {
		return orderid;
	}

	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getFinished() {
		return finished;
	}

	public void setFinished(Integer finished) {
		this.finished = finished;
	}

	public Double getCost() {
		return cost;
	}

	public void setCost(Double cost) {
		this.cost = cost;
	}


	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Integer getOrderstatusId() {
		return orderstatusId;
	}

	public void setOrderstatusId(Integer orderstatusId) {
		this.orderstatusId = orderstatusId;
	}

	public Integer getPaywayId() {
		return paywayId;
	}

	public void setPaywayId(Integer paywayId) {
		this.paywayId = paywayId;
	}


	
}
