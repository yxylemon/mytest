package com.jxlg.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.jxlg.bean.Payway;
import com.jxlg.dao.IPaywayDao;

public class PaywayDaoImpl extends HibernateDaoSupport implements IPaywayDao{
	//通过付款id查找
	@Override
	public Payway findPaywayByid(Integer paywayId) {
		// TODO Auto-generated method stub
		Query query = this.getSession().createQuery("from Payway");
		int i=paywayId;
		List<Payway> list = query.list();
		for(Payway payway:list){
			int j=payway.getPaywayid();
			if(i==j){
				return payway;
			}
		}
		return null;
	}
	//查找所有付款方式
	@Override
	public List<Payway> findAllPayway() {
		// TODO Auto-generated method stub
		Query query = this.getSession().createQuery("from Payway");
		List<Payway> list = query.list();
		return list;
	}

}
