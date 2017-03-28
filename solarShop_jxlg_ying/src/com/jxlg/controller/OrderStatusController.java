package com.jxlg.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jxlg.bean.Orderstatus;
import com.jxlg.service.IOrderService;
import com.jxlg.service.IOrderStatusService;
import com.jxlg.service.IOrderlineService;
import com.jxlg.service.IPaywayService;
import com.jxlg.service.IProductService;
import com.jxlg.service.IUserInfoService;
import com.jxlg.service.IUserService;

@Controller
@RequestMapping("/action/orderStatus")
public class OrderStatusController {
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
	@Resource(name="orderStatusService")
	private IOrderStatusService orderStatusService;
	
	/**
	 * 通过订单状态id获得订单状态对象
	 * @param orderStatus
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("getOrderStatusById")
	@ResponseBody
	public Map<String, Object> getAllOrder(Orderstatus orderStatus, HttpServletRequest request,HttpServletResponse response){
		
		Map<String, Object> result = new HashMap<String, Object>();
		orderStatus=orderStatusService.findById(orderStatus.getStatusid());
		result.put("orderStatus", orderStatus);
		return result;
	}
}
