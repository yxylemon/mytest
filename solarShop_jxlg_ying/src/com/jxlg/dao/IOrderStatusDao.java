package com.jxlg.dao;

import java.util.List;

import com.jxlg.bean.Orderstatus;

public interface IOrderStatusDao {
	//查找所有订单状态
	List<Orderstatus> findAllOrderStatus();
	//通过状态id查找订单状态
	Orderstatus findById(int orderStatusId);
}
