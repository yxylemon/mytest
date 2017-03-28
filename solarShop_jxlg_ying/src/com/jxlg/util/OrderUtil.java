package com.jxlg.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.pingplusplus.Pingpp;
import com.pingplusplus.model.Charge;
import com.pingplusplus.model.ChargeCollection;
import com.pingplusplus.model.Refund;

public class OrderUtil {
	public static String apiKey = "sk_test_rfT0KSK0CqDSf9KSSC88OWzH";
	/**
	 * pingpp 管理平台对应的应用 ID
	 */
	public static String appId = "app_DmvHaTHqjLSSX1mX";
	public static boolean chargeSuccess(String orderid){
		Pingpp.apiKey = apiKey;
		ChargeCollection chargeCollection = null;
        Map<String, Object> chargeParams = new HashMap<String, Object>();
        chargeParams.put("limit", 99);

//增加此处设施，刻意获取app expande 
//        List<String> expande = new ArrayList<String>();
//        expande.add("app");
//        chargeParams.put("expand", expande);

        try {
            chargeCollection = Charge.all(chargeParams);
            List<Charge> list= chargeCollection.getData();
            for(Charge c:list){
            	if((orderid.equals(c.getOrderNo()))&&(c.getPaid()==true)){
            		return true;
            	}
            }
        } catch (Exception e) {
            e.printStackTrace();
        } 
		return false;
	}
	
	public static Charge getChargeByOrderid(String orderid){
		Pingpp.apiKey = apiKey;
		ChargeCollection chargeCollection = null;
        Map<String, Object> chargeParams = new HashMap<String, Object>();
        chargeParams.put("limit", 99);
        try {
            chargeCollection = Charge.all(chargeParams);
            List<Charge> list= chargeCollection.getData();
            for(Charge c:list){
            	if((orderid.equals(c.getOrderNo()))&&(c.getPaid()==true)){
            		return c;
            	}
            }
        } catch (Exception e) {
            e.printStackTrace();
        } 
		return null;
	}
	
	public static boolean refunChargeByOrderid(String orderid,double amount){
		Charge charge=OrderUtil.getChargeByOrderid(orderid);
		charge.getRefunded();
		System.out.println(charge.getRefunded());
		if(charge.getRefunded()){
			return false;
		}
		try {
			Map<String, Object> refundMap = new HashMap<String, Object>();
			refundMap.put("amount", amount*100);
			refundMap.put("description", "Refund Description");
			Refund re = charge.getRefunds().create(refundMap);
			Charge charge2=OrderUtil.getChargeByOrderid(orderid);
			charge2.getRefunded();
			System.out.println(charge2.getRefunded());
			/*System.out.println(re.getSucceed());*/
			return charge2.getRefunded();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return false;
	}
}
