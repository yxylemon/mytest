package com.jxlg.dao;

import java.util.List;
import java.util.Map;

import com.jxlg.bean.Product;


public interface IProductDao {
	//查询所有产品
	Map findAllProducts() ;
	
	//通过产品id查找一个产品
	Product findProductById(Integer productid) ;
	//分页查询
	List<Product> selectProductPage(int page,int j);
	//搜索商品
	Map<String,Object> searchProductByName(String name,int page, int j);
	//保存商品
	void saveProduct(Product product);
}
