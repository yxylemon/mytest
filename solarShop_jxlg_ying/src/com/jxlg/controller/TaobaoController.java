package com.jxlg.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradeCreateRequest;
import com.alipay.api.response.AlipayTradeCreateResponse;
import com.jxlg.bean.Product;

@Controller
public class TaobaoController {

	@RequestMapping("totaobao")
	@ResponseBody
	public Map<String, Object> test(HttpServletRequest req,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		AlipayClient alipayClient = new DefaultAlipayClient("https://openapi.alipay.com/gateway.do","2016031601218954","your private_key","json","GBK","MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI6d306Q8fIfCOaTXyiUeJHkrIvYISRcc73s3vF1ZT7XN8RNPwJxo8pWaJMmvyTn9N4HQ632qJBVHf8sxHi/fEsraprwCtzvzQETrNRwVxLO5jVmRGi60j8Ue1efIlzPXV9je9mkjzOmdssymZkh2QhUrCmZYI/FCEa3/cNMW0QIDAQAB");
		AlipayTradeCreateRequest request = new AlipayTradeCreateRequest();
		/*request.setBizContent("{
			    "out_trade_no":"20150320010101001",
			    "seller_id":"2088102146225135",
			    "total_amount":88.88,
			    "discountable_amount":8.88,
			    "undiscountable_amount":80.00,
			    "buyer_logon_id":"15901825620",
			    "subject":"Iphone6 16G",
			    "body":"Iphone6 16G",
			    "buyer_id":"2088102146225135",
			      "goods_detail":[{
			                "goods_id":"apple-01",
			        "alipay_goods_id":"20010001",
			        "goods_name":"ipad",
			        "quantity":1,
			        "price":2000,
			        "goods_category":"34543238",
			        "body":"特价手机"
			        }],
			    "operator_id":"Yx_001",
			    "store_id":"NJ_001",
			    "terminal_id":"NJ_T_001",
			    "extend_params":{
			      "sys_service_provider_id":"2088511833207846"
			    },
			    "timeout_express":"90m",
			    "royalty_info":{
			      "royalty_type":"ROYALTY",
			        "royalty_detail_infos":[{
			                    "serial_no":1,
			          "trans_in_type":"userId",
			          "batch_no":"123",
			          "out_relation_id":"20131124001",
			          "trans_out_type":"userId",
			          "trans_out":"2088101126765726",
			          "trans_in":"2088101126708402",
			          "amount":0.1,
			          "desc":"分账测试1"
			          }]}}");
			AlipayTradeCreateResponse response = alipayClient.execute(request);*/
		return result;
	}
}
