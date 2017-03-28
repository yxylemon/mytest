package com.jxlg.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jxlg.bean.Contactinfo;
import com.jxlg.bean.Order;
import com.jxlg.bean.Orderline;
import com.jxlg.bean.Payway;
import com.jxlg.bean.User;
import com.jxlg.service.IOrderService;
import com.jxlg.service.IOrderlineService;
import com.jxlg.service.IPaywayService;
import com.jxlg.service.IProductService;
import com.jxlg.service.IUserInfoService;
import com.jxlg.service.IUserService;
import com.jxlg.util.OrderUtil;
import com.jxlg.util.RandomNum;
import com.pingplusplus.Pingpp;


@Controller
@RequestMapping("/action/order")
public class OrderController {
	@Resource(name="orderService")
	private IOrderService orderService;
	@Resource(name="productService")
	private IProductService productService;
	@Resource(name="userService")
	private IUserService userService;
	@Resource(name="orderlineService")
	private IOrderlineService orderlineService;
	@Resource(name="userInfoService")
	private IUserInfoService userInfoService;
	@Resource(name="paywayService")
	private IPaywayService paywayService;
	
	/**
	 * 跳转到订单确认页面
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("toOrderConfirm")
	public String toOrderConfirm(HttpServletRequest request,HttpServletResponse response){
		User user=(User) request.getSession().getAttribute("user");
		String userid=user.getUserid();
		Contactinfo userinfo= userInfoService.getUserInfo(userid);
		List<Payway> list=paywayService.findAllPayway();
		List<Orderline> list2=orderlineService.findOrderlineByUser(userid);
		List<Orderline> list3=new ArrayList<Orderline>();
		for(Orderline orderline:list2){
			if(orderline.getOrderId()==null){
				list3.add(orderline);
			}
		}
		request.getSession().setAttribute("userinfo", userinfo);
		request.getSession().setAttribute("payways", list);
		request.getSession().setAttribute("orderlines", list3);
		Double total=0.0;
		for(Orderline orderline:list3){
			int amount=orderline.getAmount();
			Double price=orderline.getUnitPrice();
			Double a=amount*price;
			total=total+a;
		}
		request.getSession().setAttribute("totalPrice", total);
		System.out.println(total);
		return "views/confirmOrder2";
	}
	/**
	 * 保存用户订单
	 * @param payway
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("saveOrder")
	public String saveOrder(Payway payway,HttpServletRequest request,HttpServletResponse response){
		Order order=new Order();
		User user=(User) request.getSession().getAttribute("user");
		String userid=user.getUserid();
		List<Payway> list=paywayService.findAllPayway();
		List<Orderline> list2=orderlineService.findOrderlineByUser(userid);
		List<Orderline> list3=new ArrayList<Orderline>();
		for(Orderline orderline:list2){
			if(orderline.getOrderId()==null){
				list3.add(orderline);
			}
		}
		Double total=0.0;
		//得到用户的订单总价
		for(Orderline orderline:list3){
			int amount=orderline.getAmount();
			Double price=orderline.getUnitPrice();
			Double a=amount*price;
			total=total+a;
		}
		String orderid=RandomNum.getLongNumber();
		boolean flag=true;
		while(flag==true){
			Order tempOrder=orderService.listOrderByOrderid(orderid);
			if(tempOrder!=null){
				orderid=RandomNum.getLongNumber();
			}else{
				flag=false;
			}
		}
		order.setOrderid(orderid);
		order.setCost(total);
		order.setUserId(userid);
		order.setPaywayId(payway.getPaywayid());
		/*order.setOrderstatusId(0);*/
		order.setFinished(0);
		order.setRefuned(0);
		Date date=new Date();
		order.setDeadline(date);
		
		System.out.println("orderid:"+order.getOrderid());
		for(Orderline orderline:list3){
			orderline.setOrderId(orderid);
			orderline.setIsFinished(1);
			orderlineService.saveOrderline(orderline);
		}
		request.getSession().setAttribute("chargePrice", total);
		request.getSession().setAttribute("order", order);
		if(payway.getPaywayid()==1){
			order.setOrderstatusId(4);
			orderService.saveOrder(order);
			return "views/order2";
		}else{
			order.setOrderstatusId(1);
			orderService.saveOrder(order);
			return "views/chargePage";
		}
	}
	
	/**
	 * 未完成订单支付的订单,通过其id跳转到支付页面来完成订单支付
	 * @param order
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("saveOrderbyid")
	public String saveOrderbyid(Order order, HttpServletRequest request,HttpServletResponse response){
		order=orderService.listOrderByOrderid(order.getOrderid());
		Double total=order.getCost();
		request.getSession().setAttribute("chargePrice", total);
		request.getSession().setAttribute("order", order);
		return "views/chargePage";
	}
	
	/**
	 * 删除一个订单
	 * @param order
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("deleteOrder")
	@ResponseBody
	public Map<String, Object> deleteOrder( Order order,HttpServletRequest request,HttpServletResponse response){
		
		Map<String, Object> result = new HashMap<String, Object>();
		User user=(User) request.getSession().getAttribute("user");
		order=orderService.listOrderByOrderid(order.getOrderid());
		String orderid=order.getOrderid();
		result.put("msg", false);
		if(order.getUserId().equals(user.getUserid())){
			List<Orderline> list=orderlineService.findOrderlineByUser(user.getUserid());
			for(Orderline orderline:list){
				if(orderid.equals(orderline.getOrderId())){
					orderlineService.deleteOrderline(orderline.getLineid());
				}
			}
			orderService.removeOrder(order.getOrderid());
			
			result.put("msg", true);
		}
		return result;
	}
	/**
	 * 获得用户的所有订单
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("getAllOrder")
	@ResponseBody
	public Map<String, Object> getAllOrder( HttpServletRequest request,HttpServletResponse response){
		
		Map<String, Object> result = new HashMap<String, Object>();
		User user=(User) request.getSession().getAttribute("user");
		List list=orderService.listOrdersOfUser(user);
		result.put("orders", list);
		return result;
	}
	/**
	 * 跳转到订单完成页面
	 * @param order
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("toOrderInfo")
	public String toOrderInfo(Order order, HttpServletRequest request,HttpServletResponse response){
		String orderid=order.getOrderid();
		request.getSession().setAttribute("orderinfoId", orderid);
		return "views/orderinfo2";
	}
	/**
	 * 通过订单id获得订单对象
	 * @param order
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("getOrderById")
	@ResponseBody
	public Map<String, Object> getOrderById(Order order, HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		String orderid=order.getOrderid();
		System.out.println("orderid:"+orderid);
		Order order2=orderService.listOrderByOrderid(orderid);
		System.out.println("paywayid:"+order2.getPaywayId());
		result.put("order", order2);
		return result;
	}
	/**
	 * 判断用户的订单是否完成支付
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("chargeSuccess")
	@ResponseBody
	public Map<String, Object> chargeSuccess( HttpServletRequest request,HttpServletResponse response){
		
		Map<String, Object> result = new HashMap<String, Object>();
		User user=(User) request.getSession().getAttribute("user");
		List<Order> list=orderService.listOrdersOfUser(user);
		for(Order order:list){
			if(order.getFinished()==0){
				boolean flag=OrderUtil.chargeSuccess(order.getOrderid());
				if(flag==true){
					order.setFinished(1);
					order.setOrderstatusId(2);
					orderService.saveOrder(order);
				}
				
			}
		}
		return result;
	}
	
	
}
