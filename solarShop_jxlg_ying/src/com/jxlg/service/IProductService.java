package com.jxlg.service;

import java.util.List;
import java.util.Map;

import com.jxlg.bean.Product;

public interface IProductService {
	//列出所有产品
	Map listAllProducts() ;
	
	//通过产品id得到一个产品
	Product getProductByProductid(Integer productid) ;
	//分页查询
	List<Product> selectProductPage(int page, int j);
	//搜索商品
	Map<String,Object> searchProductbyName(String name,int page, int j);
	//保存商品
	void saveProduct(Product product);
}


