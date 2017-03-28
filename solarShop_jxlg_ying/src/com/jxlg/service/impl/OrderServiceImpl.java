package com.jxlg.service.impl;

import java.util.List;
import java.util.Map;

import com.jxlg.bean.Order;
import com.jxlg.bean.User;
import com.jxlg.dao.IOrderDao;
import com.jxlg.service.IOrderService;

public class OrderServiceImpl implements IOrderService {
	private IOrderDao orderDao;
	//查找一个用户的所有订单
	@Override
	public List listOrdersOfUser(User user) {
		// TODO Auto-generated method stub		
		String userid=user.getUserid();
		try {
			List list=orderDao.findOrderByUserid(userid);			
			return list;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	//删除一个订单
	@Override
	public void removeOrder(String orderid)  {
		// TODO Auto-generated method stub
	
		try {
			orderDao.deleteOrder(orderid);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//保存一个订单
	@Override
	public void saveOrder(Order order) {
		// TODO Auto-generated method stub
		
		try {
			orderDao.saveOrder(order);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	

	public IOrderDao getOrderDao() {
		return orderDao;
	}

	public void setOrderDao(IOrderDao orderDao) {
		this.orderDao = orderDao;
	}
	//查找所有的付款方式
	@Override
	public Map listAllPayways() {
		// TODO Auto-generated method stub
		
		try {
			Map map=orderDao.findAllPayway();
			
			return map;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	//通过订单id查找一个订单
	@Override
	public Order listOrderByOrderid(String orderid){
		// TODO Auto-generated method stub
	
		
		try {
			Order order=orderDao.findOrderByOrderid(orderid);
			
			return order;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}
