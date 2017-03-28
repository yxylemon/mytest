package com.jxlg.dao;

import java.util.List;

import com.jxlg.bean.Orderline;

public interface IOrderlineDao {
		//保存一个订单项
		void saveOrderline(Orderline orderline) ;
		
		//删除一个订单项
		void deleteOrderline(Integer OrderlineId);
		
		//通过订单项id查找一个订单项
		Orderline findOrderlineByOrderlineId(Integer OrderlineId);
		
		//查找一个用户的所有订单项
		List<Orderline> findOrderlineByUser(String userid);
		
		/*//查找所有的付款方式
		Map findAllPayway();
		
		//查找用户第一页的订单
		List findOrderByPageNumber(Integer page,Integer userid);*/
}
