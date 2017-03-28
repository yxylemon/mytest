package com.jxlg.service;

import java.util.List;

import com.jxlg.bean.Orderline;

public interface IOrderlineService {
		
			//保存一个订单
			void saveOrderline(Orderline orderline) ;
			
			//删除一个订单
			void deleteOrderline(Integer OrderlineId);
			
			//通过订单id查找一个订单
			Orderline findOrderlineByOrderlineId(Integer OrderlineId);
			//查找一个用户的所有订单
			List<Orderline> findOrderlineByUser(String userid);
}
