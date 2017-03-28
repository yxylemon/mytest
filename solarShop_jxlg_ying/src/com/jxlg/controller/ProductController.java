package com.jxlg.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jxlg.bean.Orderline;
import com.jxlg.bean.Product;
import com.jxlg.bean.User;
import com.jxlg.service.IOrderService;
import com.jxlg.service.IOrderlineService;
import com.jxlg.service.IProductService;
import com.jxlg.service.IUserInfoService;
import com.jxlg.service.IUserService;

@Controller
@RequestMapping("/action/product")
public class ProductController {
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
	 * 获得所有的产品
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
		result.put("result", map);
		return result;
	}
	/**
	 * 分页查询
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
	
	//将产品加入到orderline中，并给其赋产品的id，用户的id，如果该orderline已存在，则其数量加一
	@RequestMapping("addProduct")
	@ResponseBody
	public Map<String, Object> addProduct(Product product2,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("进入addProduct。。。。。。");
		int productId=product2.getProductid();
		User user=(User) request.getSession().getAttribute("user");
		String userid=user.getUserid();
		Product product=productService.getProductByProductid(productId);
		int amo=product.getAmount()+1;
		product.setAmount(amo);
		productService.saveProduct(product);
		Double unitPrice=product.getBaseprice();
		String productName=product.getName();
		List<Orderline> list= orderlineService.findOrderlineByUser(userid);
		int temp=0;
		if(list.size()!=0){
			for(Orderline orderline:list){
				if((orderline.getProductId()==productId)&&(orderline.getUserId().equals(userid))&&(orderline.getIsFinished()==0)&&(orderline.getOrderId()==null)){
					int sum=orderline.getAmount()+1;
					orderline.setAmount(sum);
					temp=1;
					orderlineService.saveOrderline(orderline);
				}
			}
		}
		if(temp==0){
			Orderline neworderline=new Orderline();
			neworderline.setAmount(1);
			neworderline.setProductId(productId);
			neworderline.setUserId(userid);
			neworderline.setUnitPrice(unitPrice);
			neworderline.setProductName(productName);
			neworderline.setIsFinished(0);
			orderlineService.saveOrderline(neworderline);
		}
		/*result.put("result", map);*/
		return result;
	}
	/**
	 * 通过id获得产品,跳转到产品详细信息页面
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("getProductById/{id}")
	public String getProductById(@PathVariable Integer id,HttpServletRequest request,HttpServletResponse response){
		Product product= productService.getProductByProductid(id);
		String s=product.getDescription();
		s = s.replace("\r\n", "<br>&nbsp;&nbsp;");//这才是正确的！
		s= s.replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
		s =s.replace(" ", "&nbsp;");
		product.setDescription(s);
		request.getSession().setAttribute("product", product);
		return "views/productDetail2";
	}
}
