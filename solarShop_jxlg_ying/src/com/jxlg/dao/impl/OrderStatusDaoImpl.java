package com.jxlg.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.jxlg.bean.Orderstatus;
import com.jxlg.dao.IOrderStatusDao;

public class OrderStatusDaoImpl extends HibernateDaoSupport implements IOrderStatusDao{
	//查找所有订单状态
	@Override
	public List<Orderstatus> findAllOrderStatus() {
		// TODO Auto-generated method stub
		Query query = this.getSession().createQuery("from Orderstatus");
		List<Orderstatus> list = query.list();
		return list;
	}
	//通过状态id查找订单状态
	@Override
	public Orderstatus findById(int orderStatusId) {
		// TODO Auto-generated method stub
		Query query = this.getSession().createQuery("from Orderstatus");
		List<Orderstatus> list = query.list();
		for(Orderstatus orderstatus:list){
			if(orderstatus.getStatusid()==orderStatusId){
				return orderstatus;
			}
		}
		return null;
	}

}
