package com.jxlg.service.impl;

import java.util.List;

import com.jxlg.bean.Orderstatus;
import com.jxlg.dao.IOrderStatusDao;
import com.jxlg.service.IOrderStatusService;

public class OrderStatusServiceImpl implements IOrderStatusService {

	private IOrderStatusDao orderStatusDao;
	//查找所有订单状态
	@Override
	public List<Orderstatus> findAllOrderStatus() {
		// TODO Auto-generated method stub
		List<Orderstatus> list=orderStatusDao.findAllOrderStatus();
		return list;
	}

	public IOrderStatusDao getOrderStatusDao() {
		return orderStatusDao;
	}

	public void setOrderStatusDao(IOrderStatusDao orderStatusDao) {
		this.orderStatusDao = orderStatusDao;
	}
	//通过状态id查找订单状态
	@Override
	public Orderstatus findById(int orderStatusId) {
		// TODO Auto-generated method stub
		return orderStatusDao.findById(orderStatusId);
	}

}
