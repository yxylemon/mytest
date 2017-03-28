package com.jxlg.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jxlg.bean.Order;
import com.jxlg.bean.User;
import com.jxlg.service.IOrderService;
import com.jxlg.service.IOrderlineService;
import com.jxlg.service.IPaywayService;
import com.jxlg.service.IProductService;
import com.jxlg.service.IUserInfoService;
import com.jxlg.service.IUserService;
import com.jxlg.util.OrderUtil;
import com.pingplusplus.Pingpp;
import com.pingplusplus.exception.APIConnectionException;
import com.pingplusplus.exception.APIException;
import com.pingplusplus.exception.AuthenticationException;
import com.pingplusplus.exception.ChannelException;
import com.pingplusplus.exception.InvalidRequestException;
import com.pingplusplus.exception.PingppException;
import com.pingplusplus.model.App;
import com.pingplusplus.model.Charge;
import com.pingplusplus.model.ChargeCollection;
import com.pingplusplus.model.Refund;

@Controller()
@RequestMapping("/action/charge")
public class ChargeController {
	
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
	public static String apiKey = "sk_test_rfT0KSK0CqDSf9KSSC88OWzH";
	/**
	 * pingpp 管理平台对应的应用 ID
	 */
	public static String appId = "app_DmvHaTHqjLSSX1mX";
	public User user;
	@RequestMapping("chargeTest")
	@ResponseBody
	public Map<String, Object> test(String channel,BigDecimal amount,String orderid, HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(channel+":"+amount);
		Pingpp.apiKey = apiKey;
        System.out.println("---------创建 charge");
        Order order=(Order) request.getSession().getAttribute("order");
        orderid=order.getOrderid();
         user=(User) request.getSession().getAttribute("user");
        
        Charge charge =charge(channel,amount,orderid,user.getUserid(),user.getPassword());
       /* System.out.println("订单id："+charge.getId());
        System.out.println("---------查询 charge");
        retrieve(charge.getId());
        System.out.println("是否支付成功："+charge.getPaid());
        System.out.println("---------查询 charge列表");
        all();*/
        result.put("charge", charge);
		return result;
	}
	@RequestMapping("refunCharge")
	@ResponseBody
	public Map<String, Object> refunchargeTest( String orderid,double amount,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		boolean isrefunCharge=OrderUtil.refunChargeByOrderid(orderid, amount);
		if(isrefunCharge==true){
			Order order=orderService.listOrderByOrderid(orderid);
			order.setRefuned(1);
			order.setOrderstatusId(3);
			orderService.saveOrder(order);
		}
		
		result.put("isrefunCharge", isrefunCharge);
		return result;
	}
	//创建订单
	 public Charge charge(String channel,BigDecimal amount,String orderid,String userid,String password) {
	        Charge charge = null;
	        Map<String, Object> chargeMap = new HashMap<String, Object>();
	        Map<String, String> extra = new HashMap<String, String>();
	        extra.put("success_url", "http://127.0.0.1:8888/solarShop_jxlg/action/charge/toOrder");
	        chargeMap.put("amount", amount);
	        chargeMap.put("currency", "cny");
	        chargeMap.put("subject", "理工太阳能");
	        chargeMap.put("body", "热水器付款");
	        chargeMap.put("order_no", orderid);
	        chargeMap.put("channel", channel);
	        chargeMap.put("client_ip", "127.0.0.1");
	        Map<String, String> app = new HashMap<String, String>();
	       
	        app.put("id",appId);
	        chargeMap.put("app", app);
	        chargeMap.put("extra", extra);
	        try {
	            //发起交易请求
	            charge = Charge.create(chargeMap);
	           /* System.out.println(charge);*/
	        } catch (PingppException e) {
	            e.printStackTrace();
	        }
	        return charge;
	    }
	 
	    /**
	     * 查询 Charge
	     * 
	     * 该接口根据 charge Id 查询对应的 charge 。
	     * 参考文档：https://pingxx.com/document/api#api-c-inquiry
	     * 
	     * 该接口可以传递一个 expand ， 返回的 charge 中的 app 会变成 app 对象。
	     * 参考文档： https://pingxx.com/document/api#api-expanding
	     * @param id
	     */
	    public void retrieve(String id) {
	        try {
	            Map<String, Object> param = new HashMap<String, Object>();
	            List<String> expande = new ArrayList<String>();
	            expande.add("app");
	            param.put("expand", expande);
	            //Charge charge = Charge.retrieve(id);
	            //Expand app
	            Charge charge = Charge.retrieve(id, param);
	            if (charge.getApp() instanceof App) {
	                //App app = (App) charge.getApp();
	                // System.out.println("App Object ,appId = " + app.getId());
	            } else {
	                // System.out.println("String ,appId = " + charge.getApp());
	            }

	            System.out.println(charge);

	        } catch (PingppException e) {
	            e.printStackTrace();
	        }
	    }

	    /**
	     * 分页查询Charge
	     * 
	     * 该接口为批量查询接口，默认一次查询10条。
	     * 用户可以通过添加 limit 参数自行设置查询数目，最多一次不能超过 100 条。
	     * 
	     * 该接口同样可以使用 expand 参数。
	     * @return
	     */
	    public ChargeCollection all() {
	        ChargeCollection chargeCollection = null;
	        Map<String, Object> chargeParams = new HashMap<String, Object>();
	        chargeParams.put("limit", 3);

	//增加此处设施，刻意获取app expande 
//	        List<String> expande = new ArrayList<String>();
//	        expande.add("app");
//	        chargeParams.put("expand", expande);

	        try {
	            chargeCollection = Charge.all(chargeParams);
	            System.out.println(chargeCollection);
	        } catch (AuthenticationException e) {
	            e.printStackTrace();
	        } catch (InvalidRequestException e) {
	            e.printStackTrace();
	        } catch (APIConnectionException e) {
	            e.printStackTrace();
	        } catch (APIException e) {
	            e.printStackTrace();
	        } catch (ChannelException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        return chargeCollection;
	    }
	    //退款方法，通过订单id
	    public void refunCharge(){
	    	try {
				Charge ch = Charge.retrieve("ch_WbLiTKK8WvzDLS4Sm5irjTS0");
				Map<String, Object> refundMap = new HashMap<String, Object>();
				refundMap.put("amount", 500);
				refundMap.put("description", "Refund Description");
				Refund re = ch.getRefunds().create(refundMap);
				
				System.out.println(re.getSucceed());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
	    }
	    //支付成功后,跳转到订单页面
	    @RequestMapping("toOrder")
		public String toOrder(HttpServletRequest request,HttpServletResponse response){
	    	request.getSession().setAttribute("user", user);
			return "views/order2";
	}
}
