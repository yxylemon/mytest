package com.jxlg.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jxlg.bean.Contactinfo;
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
@RequestMapping("/action/user")
public class CodeController {
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
	 * 通过用户id,来查询用户详细信息
	 * @param user
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("getUserInfo")
	@ResponseBody
	public Map<String, Object> getUserInfo(User user,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		String userid=user.getUserid();
		System.out.println("userid:"+userid);
		Contactinfo con= userInfoService.getUserInfo(userid);
		User user2=(User) request.getSession().getAttribute("user");
		if(con!=null){
			result.put("userinfo", con);
			result.put("user", user2);
		}else{
			result.put("userinfo", false);
		}
		return result;
	}
	/**
	 * 更新用户信息
	 * @param user
	 * @param contactinf
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("changeUserinfo")
	/*@ResponseBody*/
	public String changeUserinfo(User user,Contactinfo contactinf,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		userService.updateUserinfo(user);
		System.out.println(contactinf);
		userInfoService.saveOrupdataUserInfo(contactinf);
		return "views/userinfo2";
	}
	
	/**
	 * 通过传过来的电话号码,发送注册验证码
	 * @param tel
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("getCode")
	@ResponseBody
	public Map<String, Object> getCode(String tel,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(tel);
		String randomNum=RandomNum.getRandomNumber();
		request.getSession().setAttribute("randomNum", randomNum);
		 //官网的URL
		String url="http://gw.api.taobao.com/router/rest";
		//成为开发者，创建应用后系统自动生成
		String appkey="23327210";
		String secret="58953b7b96927e2e58034b72e003b648";
		/*String tel="15950172074";*/
		//短信模板的内容
		String json="{\"code\":\""+randomNum+"\",\"product\":\"理工太阳能热水器商城\"}";
		TaobaoClient client = new DefaultTaobaoClient(url, appkey, secret);
		AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
		req.setExtend("123456");
		req.setSmsType("normal");
		req.setSmsFreeSignName("注册验证");
		req.setSmsParamString(json);
		req.setRecNum(tel);
		req.setSmsTemplateCode("SMS_6125332");
		result.put("msg", false);
		try {
		AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
		boolean flag=rsp.getResult().getSuccess();
		result.put("msg", flag);
		} catch (Exception e) {
		// TODO: handle exception
	}
		return result;
	}
	
	/**
	 * 通过发过来的手机号码,发送变更信息验证码
	 * @param tel
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("getCode2")
	@ResponseBody
	public Map<String, Object> getCode2(String tel,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(tel);
		String randomNum=RandomNum.getRandomNumber();
		request.getSession().setAttribute("randomNum", randomNum);
		//官网的URL
		String url="http://gw.api.taobao.com/router/rest";
		//成为开发者，创建应用后系统自动生成
		String appkey="23327210";
		String secret="58953b7b96927e2e58034b72e003b648";
		/*String tel="15950172074";*/
		//短信模板的内容
		String json="{\"code\":\""+randomNum+"\",\"product\":\"理工太阳能热水器商城\"}";
		TaobaoClient client = new DefaultTaobaoClient(url, appkey, secret);
		AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
		req.setExtend("123456");
		req.setSmsType("normal");
		req.setSmsFreeSignName("变更验证");
		req.setSmsParamString(json);
		req.setRecNum(tel);
		req.setSmsTemplateCode("SMS_6125329");
		result.put("msg", false);
		try {
			AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
			boolean flag=rsp.getResult().getSuccess();
			result.put("msg", flag);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}
	/**
	 * 检验输入的验证码是否正确
	 * @param code
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("checkCode")
	@ResponseBody
	public Map<String, Object> checkCode(String code,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		String randomNum= (String) request.getSession().getAttribute("randomNum");
		result.put("msg", false);
		if(code.trim().equals(randomNum)){
			result.put("msg", true);
		}
		return result;
	}
}
