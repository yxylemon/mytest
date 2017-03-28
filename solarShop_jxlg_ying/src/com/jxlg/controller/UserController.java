package com.jxlg.controller;


import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jxlg.bean.Contactinfo;
import com.jxlg.bean.Orderline;
import com.jxlg.bean.Product;
import com.jxlg.bean.User;
import com.jxlg.service.IOrderService;
import com.jxlg.service.IOrderlineService;
import com.jxlg.service.IProductService;
import com.jxlg.service.IUserInfoService;
import com.jxlg.service.IUserService;
import com.jxlg.util.RandomNum;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;

@Controller
/*@RequestMapping("/user")*/
public class UserController {
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
	
	 //验证用户登录的用户名名和密码
	@RequestMapping("Login")
	 public String login(User user,HttpServletRequest request,HttpServletResponse response){
		System.out.println("login_user。。。。。。。。。");
		if((user.getUserid()!=null)&&(user.getPassword()!=null)){
			user = userService.login(user.getUserid(), user.getPassword());
			if(user!=null){
				request.getSession().setAttribute("user", user);
				return "/index2";
			}
		}
		request.getSession().setAttribute("flag", false);
		 return "/login";
	 }
	//用户注册
	@RequestMapping("register")
	public String register(User user,Contactinfo contactinfo,HttpServletRequest request,HttpServletResponse response){		
		System.out.println("register_user............");
		boolean flag = userService.isUser(user.getUserid());
		if(flag==true){
			return "/register";
		}else{
			System.out.println(user);
			request.getSession().setAttribute("user", user);
			contactinfo.setUserId(user.getUserid());
			userService.registerUser(user);
			userInfoService.saveOrupdataUserInfo(contactinfo);
			System.out.println(contactinfo);
			
			return "index2";
		}
		
		
	}
	
	//用户登录的时候验证该用户名是否存在
	@RequestMapping("userisExist")
	@ResponseBody
	public Map<String,Object> userisExist(User user,HttpServletRequest request,HttpServletResponse response){
		System.out.println("login_userisExist............");
		boolean flag = userService.isUser(user.getUserid());
		Map<String,Object> map=new HashMap<String,Object>();
		if(flag!=true){
			map.put("isExist",false);
			
		}else{
			map.put("isExist",true);
		}
		return map;
	}
	/**
	 * 用户退出登录
	 * @param product2
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("loginOut")
	public String test(Product product2,HttpServletRequest request,HttpServletResponse response){
		request.getSession().setAttribute("user", null);
		return "login";
	}
	/**
	 * 获得所有产品
	 * @param str
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("getAllproduct")
	@ResponseBody
	public Map<String, Object> getAllProduct(String str,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		
		Map map=productService.listAllProducts();
		int size=map.size();
		result.put("result", map);
		result.put("size", size);
		return result;
	}
	/**
	 * 产品分页
	 * @param page
	 * @param pageList
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("getProductByPage")
	@ResponseBody
	public Map<String, Object> getProductByPage(int page,int pageList,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		List list=productService.selectProductPage((page - 1) * pageList, pageList);
		int productSize=list.size();
		int maxpage=productService.listAllProducts().size();
		result.put("result", list);
		result.put("productSize", productSize);
		result.put("maxpage", maxpage);
		return result;
	}
	/**
	 * 产品搜索
	 * @param searchName
	 * @param page
	 * @param pageList
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("getProductBySearch")
	@ResponseBody
	public Map<String, Object> getProductBySearch(String searchName,int page,int pageList,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> map=productService.searchProductbyName(searchName, (page - 1) * pageList, pageList);
		List<Product> list=(List<Product>) map.get("products");
		int productSize=list.size();
		int maxpage=(int) map.get("productSize");
		result.put("result", list);
		result.put("productSize", productSize);
		result.put("maxpage", maxpage);
		return result;
	}
}
