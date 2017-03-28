package com.jxlg.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jxlg.bean.Payway;
import com.jxlg.service.IOrderService;
import com.jxlg.service.IOrderlineService;
import com.jxlg.service.IPaywayService;
import com.jxlg.service.IProductService;
import com.jxlg.service.IUserInfoService;
import com.jxlg.service.IUserService;

@Controller
@RequestMapping("/action/payway")
public class PaywayController {
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
	 * 获得所有的付款方式
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("getAllPayway")
	@ResponseBody
	public Map<String, Object> getAllPayway( HttpServletRequest request,HttpServletResponse response){
		
		Map<String, Object> result = new HashMap<String, Object>();
		List list=paywayService.findAllPayway();
		result.put("payways", list);
		return result;
	}
	/**
	 * 通过付款id,获得付款方式对象
	 * @param payway
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("getPaywayByid")
	@ResponseBody
	public Map<String, Object> getPaywayByid(Payway payway, HttpServletRequest request,HttpServletResponse response){
		System.out.println("payway:"+payway.getPaywayid());
		Map<String, Object> result = new HashMap<String, Object>();
		Payway payway2=paywayService.findPaywayByid(payway.getPaywayid());
		System.out.println(payway2);
		result.put("payway", payway2);
		return result;
	}
}
