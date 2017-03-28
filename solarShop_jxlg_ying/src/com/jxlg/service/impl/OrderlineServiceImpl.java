package com.jxlg.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.jxlg.bean.Orderline;
import com.jxlg.dao.IOrderlineDao;
import com.jxlg.service.IOrderlineService;
public class OrderlineServiceImpl implements IOrderlineService {
	private IOrderlineDao orderlineDao;
	public IOrderlineDao getOrderlineDao() {
		return orderlineDao;
	}

	public void setOrderlineDao(IOrderlineDao orderlineDao) {
		this.orderlineDao = orderlineDao;
	}

	//保存一个订单
	@Override
	public void saveOrderline(Orderline orderline) {
		// TODO Auto-generated method stub
		orderlineDao.saveOrderline(orderline);
		System.out.println("进入orderLine  save。。。。。");
	}
	//删除一个订单
	@Override
	public void deleteOrderline(Integer OrderlineId) {
		// TODO Auto-generated method stub
		orderlineDao.deleteOrderline(OrderlineId);
	}
	//通过订单id查找一个订单
	@Override
	public Orderline findOrderlineByOrderlineId(Integer OrderlineId) {
		// TODO Auto-generated method stub
		Orderline orderline=orderlineDao.findOrderlineByOrderlineId(OrderlineId);
		return orderline;
	}
	//查找一个用户的所有订单
	@Override
	public List<Orderline> findOrderlineByUser(String userid) {
		// TODO Auto-generated method stub
		List<Orderline> list=orderlineDao.findOrderlineByUser(userid);
		System.out.println("进入orderline findOrderlineByUser。。。。。");
		return list;
	}

	


}
