package com.jxlg.dao;

import java.util.List;
import java.util.Map;

import com.jxlg.bean.Order;

public interface IOrderDao {
	//保存一个订单
	void saveOrder(Order order) ;
	
	//删除一个订单
	void deleteOrder(String orderid);
	
	//通过订单id查找一个订单
	Order findOrderByOrderid(String orderid);
	
	//查找一个用户的所有订单
	List findOrderByUserid(String userid);
	
	//查找所有的付款方式
	Map findAllPayway();
	
	//查找用户第一页的订单
	List findOrderByPageNumber(Integer page,Integer userid);
}
