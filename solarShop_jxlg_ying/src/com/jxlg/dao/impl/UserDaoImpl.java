package com.jxlg.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.jxlg.bean.User;
import com.jxlg.dao.IUserDao;

public class UserDaoImpl extends HibernateDaoSupport implements IUserDao{
	//保存一个用户
	@Override
	public void saveUser(User user)  {
		// TODO Auto-generated method stub
		Session session=this.getSession();
		session.save(user);
	}
	//更新一个用户
	@Override
	public void updateUser(User user){
		// TODO Auto-generated method stub
		Session session=this.getSession();
		session.saveOrUpdate(user);
	}
	//通过用户id查找一个用户
	@Override
	public User findUserByUserid(String userid) {
		// TODO Auto-generated method stub
		Session session=this.getSession();
		Query query = session.createQuery("from User");
		List<User> list = query.list();
		for(User user:list){
			if(userid.equals(user.getUserid())){
				return user;
			}
		}
		return null;
	}

}
