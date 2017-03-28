package com.jxlg.service.impl;

import java.util.List;

import com.jxlg.bean.Payway;
import com.jxlg.dao.IPaywayDao;
import com.jxlg.service.IPaywayService;

public class PaywayService implements IPaywayService{
	private IPaywayDao paywayDao;
	//通过付款id查找
	@Override
	public Payway findPaywayByid(Integer paywayId) {
		// TODO Auto-generated method stub
		Payway payway=paywayDao.findPaywayByid(paywayId);
		return payway;
	}
	//查找所有付款方式
	@Override
	public List<Payway> findAllPayway() {
		// TODO Auto-generated method stub
		List<Payway> list=paywayDao.findAllPayway();
		return list;
	}

	public IPaywayDao getPaywayDao() {
		return paywayDao;
	}

	public void setPaywayDao(IPaywayDao paywayDao) {
		this.paywayDao = paywayDao;
	}

}
