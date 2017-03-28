package com.jxlg.dao;

import java.util.List;

import com.jxlg.bean.Payway;

public interface IPaywayDao {
	//通过付款id查找
	Payway findPaywayByid(Integer paywayId);
	//查找所有付款方式
	List<Payway> findAllPayway();
}
