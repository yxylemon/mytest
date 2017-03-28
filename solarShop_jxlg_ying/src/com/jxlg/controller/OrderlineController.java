package com.jxlg.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jxlg.bean.Order;
import com.jxlg.bean.Orderline;
import com.jxlg.bean.Product;
import com.jxlg.bean.User;
import com.jxlg.service.IOrderService;
import com.jxlg.service.IOrderlineService;
import com.jxlg.service.IProductService;
import com.jxlg.service.IUserInfoService;
import com.jxlg.service.IUserService;

@Controller
@RequestMapping("/action/orderline")
public class OrderlineController {
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
	
	/**
	 * 判断该订单项是否是当前用户，并且该订单项是否处于未提交状态
	 * @param product2
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("getAllOrderlineByUserId")
	@ResponseBody
	public Map<String, Object> getAllOrderlineByUserId(HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		User user=(User) request.getSession().getAttribute("user");
		String userid=user.getUserid();
		List<Orderline> list=orderlineService.findOrderlineByUser(userid);
		List<Orderline> list2=new ArrayList<Orderline>();
		for(Orderline orderline:list){
			if((orderline.getIsFinished()==0)&&(orderline.getOrderId()==null)){
				list2.add(orderline);
			}
		}
		result.put("orderlines", list2);
		return result;
	}
	/**
	 * 通过订单项id来删除订单项
	 * @param orderline
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("deleteOrderlinePoductId")
	@ResponseBody
	public Map<String, Object> deleteOrderlinePoductId(Orderline orderline,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("进入orderline的删除方法。。。。");
		System.out.println(orderline.getLineid());
		result.put("msg", false);
		try {
			orderlineService.deleteOrderline(orderline.getLineid());
			result.put("msg", true);
		} catch (Exception e) {
			result.put("msg", false);
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	/**
	 * 通过订单项id来保存订单项
	 * @param orderline
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("saveOrderlineById")
	@ResponseBody
	public Map<String, Object> saveOrderlineById(Orderline orderline,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("进入orderline的保存方法。。。。");
		System.out.println(orderline.getLineid());
		result.put("msg", false);
		try {
			int OrderlineId=orderline.getLineid();
			int amount=orderline.getAmount();
			Orderline orderline2=orderlineService.findOrderlineByOrderlineId(OrderlineId);
			int productid=orderline2.getProductId();
			int temp=amount-orderline2.getAmount();
			Product product=productService.getProductByProductid(productid);
			int beforeChange=product.getAmount();
			product.setAmount(beforeChange+temp);
			productService.saveProduct(product);
			orderline2.setAmount(amount);
			orderlineService.saveOrderline(orderline2);
			result.put("msg", true);
		} catch (Exception e) {
			result.put("msg", false);
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	/**
	 * 删除用户所有订单项
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("deleteAllOrderline")
	@ResponseBody
	public Map<String, Object> deleteAllOrderline(HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("msg", false);
		try {
			User user=(User) request.getSession().getAttribute("user");
			String userid=user.getUserid();
			List<Orderline> list=orderlineService.findOrderlineByUser(userid);
			for(Orderline orderline:list){
				if(orderline.getIsFinished()==0&&orderline.getOrderId()==null){
					orderlineService.deleteOrderline(orderline.getLineid());
				}
			}
			result.put("msg", true);
		} catch (Exception e) {
			result.put("msg", false);
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	/**
	 * 通过订单id获得订单项集合
	 * @param order
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("getOrderlineByorderId")
	@ResponseBody
	public Map<String, Object> getOrderlineByorderId(Order order,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		User user=(User) request.getSession().getAttribute("user");
		String userid=user.getUserid();
		String orderid=order.getOrderid();
		List<Orderline> list=orderlineService.findOrderlineByUser(userid);
		List<Orderline> list2=new ArrayList<Orderline>();
		for(Orderline orderline:list){
			if(orderid.equals(orderline.getOrderId())){
				list2.add(orderline);
			}
		}
		result.put("orderlines", list2);
		return result;
	}
}
