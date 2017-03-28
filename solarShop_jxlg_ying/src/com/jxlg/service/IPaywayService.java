package com.jxlg.service;

import java.util.List;

import com.jxlg.bean.Payway;

public interface IPaywayService {
	//通过付款id查找
	Payway findPaywayByid(Integer paywayId);
	//查找所有付款方式
	List<Payway> findAllPayway();
}
