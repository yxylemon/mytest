package com.jxlg.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.jxlg.dao.IOrderlineDao;
import com.jxlg.bean.Order;
import com.jxlg.bean.Orderline;
import com.jxlg.bean.User;


public class OrderlineDaoImpl extends HibernateDaoSupport implements IOrderlineDao {

	//保存一个订单项
	@Override
	public void saveOrderline(Orderline orderline) {
		// TODO Auto-generated method stub
		this.getSession().saveOrUpdate(orderline);
	}

	//删除一个订单项
	@Override
	public void deleteOrderline(Integer OrderlineId) {
		// TODO Auto-generated method stub
		Orderline o = (Orderline)this.getSession().get(Orderline.class, OrderlineId);
		this.getSession().delete(o);
	}

	//通过订单项id查找一个订单项
	@Override
	public Orderline findOrderlineByOrderlineId(Integer OrderlineId) {
		// TODO Auto-generated method stub
		Query query = this.getSession().createQuery("from Orderline");
		List<Orderline> list = query.list();
		for(Orderline orderline:list){
			if(OrderlineId.equals(orderline.getLineid())){
				return orderline;
			}
		}
		
		return null;
	}

	//查找一个用户的所有订单项
	@Override
	public List<Orderline> findOrderlineByUser(String userid) {
		// TODO Auto-generated method stub
		System.out.println("进入orderline。。。。。");
		Query query = this.getSession().createQuery("from Orderline");
		List<Orderline> list = query.list();
		List<Orderline> list1=new ArrayList<Orderline>();
		for(Orderline orderline:list){
			if(userid.equals(orderline.getUserId())){
				/*Set orders = user.getOrders();*/
				list1.add(orderline);
			}
		}
		return list1;
		}
}
