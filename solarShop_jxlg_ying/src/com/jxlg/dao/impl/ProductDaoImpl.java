package com.jxlg.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.jxlg.bean.Product;
import com.jxlg.dao.IProductDao;


public class ProductDaoImpl extends HibernateDaoSupport implements IProductDao {
	//查询所有产品
	@Override
	public Map findAllProducts() {
		// TODO Auto-generated method stub
		Session session=this.getSession();
		Query query = session.createQuery("from Product");
		Map map=new HashMap();
		List<Product> list = query.list();
		for(Product p:list){
			map.put(p.getProductid(), p);
		}
		return map;
	}
	//通过产品id查找一个产品
	@Override
	public Product findProductById(Integer productid) {
		// TODO Auto-generated method stub
		Session session=this.getSession();
		Query query = session.createQuery("from Product");
		List<Product> list = query.list();
		for(Product p:list){
			if(productid.equals(p.getProductid())){
				return p;
			}
		}
		return null;
	}
	//分页查询
	@Override
	public List<Product> selectProductPage(int page, int j) {
		// TODO Auto-generated method stub
		String hql = "from Product p ORDER BY p.amount desc";
		Query query = this.getSession().createQuery(hql);
		query.setFirstResult(page);//从第几行开始
		query.setMaxResults(j);//返回多少行
		List<Product> list = query.list();
		return list;
	}
	//搜索商品
	@Override
	public Map<String,Object> searchProductByName(String name,int page, int j) {
		// TODO Auto-generated method stub
		Map<String, Object> result = new HashMap<String, Object>();
		String hql = "from Product p where p.name like '%"+name+"%' ORDER BY p.amount desc";
		Query query = this.getSession().createQuery(hql);
		List<Product> list = query.list();
		result.put("productSize", list.size());
		query.setFirstResult(page);//从第几行开始
		query.setMaxResults(j);//返回多少行
		List<Product> list2 = query.list();
		result.put("products", list2);
		return result;
	}
	//保存商品
	@Override
	public void saveProduct(Product product) {
		// TODO Auto-generated method stub
		Session session=this.getSession();
		session.save(product);
	}

}
