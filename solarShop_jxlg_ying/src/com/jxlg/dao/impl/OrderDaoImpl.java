package com.jxlg.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.hibernate.Query;
import org.hibernate.Session;

import com.jxlg.bean.Order;
import com.jxlg.bean.Payway;
import com.jxlg.bean.User;
import com.jxlg.dao.IOrderDao;


public class OrderDaoImpl extends HibernateDaoSupport implements IOrderDao{

	//保存一个订单
	@Override
	public void saveOrder(Order order) {
		// TODO Auto-generated method stub
		
		this.getSession().save(order);
	}

	//删除一个订单
	@Override
	public void deleteOrder(String orderid) {
		// TODO Auto-generated method stub
		
		Order o = (Order)this.getSession().get(Order.class, orderid);
		this.getSession().delete(o);
	}

	//通过订单id查找一个订单
	@Override
	public Order findOrderByOrderid(String orderid) {
		// TODO Auto-generated method stub
		
		Query query = this.getSession().createQuery("from Order");
		List<Order> list = query.list();
		for(Order order:list){
			if(orderid.equals(order.getOrderid())){
				return order;
			}
		}
		return null;
	}

	//查找一个用户的所有订单
	@Override
	public List findOrderByUserid(String userid) {
		// TODO Auto-generated method stub
		Query query = this.getSession().createQuery("from Order order by deadline desc");
		
		List<Order> list = query.list();
		List list1=new ArrayList();
		for(Order order:list){
			if(userid.equals(order.getUserId())){
					list1.add(order);
			}
		}
		 return list1;
	}

	//查找所有的付款方式
	@Override
	public Map findAllPayway()  {
		// TODO Auto-generated method stub
		
		Query query = this.getSession().createQuery("from Payway");
		List<Payway> list = query.list();
		Map map=new HashMap();
		for(Payway payway:list){
			map.put(payway.getPaywayid(),payway);
			System.out.println("payway的id"+payway.getPaywayid());
			
		}
		return map;
	}

	//查找用户分页的订单
	@Override
	public List findOrderByPageNumber(Integer page, Integer userid) {
		// TODO Auto-generated method stub
		return null;
	}
	
}
