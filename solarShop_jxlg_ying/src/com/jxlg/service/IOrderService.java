package com.jxlg.service;

import java.util.List;
import java.util.Map;

import com.jxlg.bean.Order;
import com.jxlg.bean.User;

public interface IOrderService {
	//列出用户订单
	List listOrdersOfUser(User user) ;
	
	//删除订单
	void removeOrder(String orderid);
	
	//保存一个订单
	void saveOrder(Order order);
	
	//列出所有的付款方式
	Map listAllPayways();
	
	//通过订单id获取一个订单
	Order listOrderByOrderid(String orderid);
}
