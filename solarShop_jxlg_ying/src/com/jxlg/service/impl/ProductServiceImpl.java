package com.jxlg.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jxlg.bean.Product;
import com.jxlg.dao.IProductDao;
import com.jxlg.service.IProductService;

public class ProductServiceImpl implements IProductService{
	
	private IProductDao productDao;
	//列出所有产品
	@Override
	public Map listAllProducts() {
		// TODO Auto-generated method stub
		
		Map map=null;
		try {
			map=productDao.findAllProducts();
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			
		}
		return map;
	}

	

	public IProductDao getProductDao() {
		return productDao;
	}



	public void setProductDao(IProductDao productDao) {
		this.productDao = productDao;
	}


	//通过产品id得到一个产品
	@Override
	public Product getProductByProductid(Integer productid) {
		// TODO Auto-generated method stub
		
		Product product=null;
		try {
			 product=productDao.findProductById(productid);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			
		}
		return product;
		
	}


	//分页查询
	@Override
	public List<Product> selectProductPage(int page, int j) {
		// TODO Auto-generated method stub
		List<Product> list = null;
		try {
			list = productDao.selectProductPage(page, j);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}


	//搜索商品
	@Override
	public Map<String,Object> searchProductbyName(String name,int page, int j) {
		// TODO Auto-generated method stub
		
		Map<String, Object> result=productDao.searchProductByName(name ,page, j);
		return result;
	}



	@Override
	public void saveProduct(Product product) {
		// TODO Auto-generated method stub
		productDao.saveProduct(product);
	}



	

}
