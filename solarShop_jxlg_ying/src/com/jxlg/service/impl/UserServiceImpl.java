package com.jxlg.service.impl;

import com.jxlg.bean.User;
import com.jxlg.dao.IUserDao;
import com.jxlg.service.IUserService;

public class UserServiceImpl implements IUserService {
	
	private IUserDao userDao;
	//更新用户信息
	@Override
	public void updateUserinfo(User user) {
		// TODO Auto-generated method stub
	
		try {
			userDao.updateUser(user);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			
		}
	}

	

	public IUserDao getUserDao() {
		return userDao;
	}



	public void setUserDao(IUserDao userDao) {
		this.userDao = userDao;
	}


	//注册一个新用户
	@Override
	public void registerUser(User user) {
		// TODO Auto-generated method stub
		
		try {
			userDao.saveUser(user);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			
		}
	}
	//登录
	@Override
	public User login(String userid, String password) {
		
		// TODO Auto-generated method stub
		
		User user=null;
		try {
			 user=userDao.findUserByUserid(userid);
			 if(user!=null){
				 if(user.getPassword().equals(password)){
					 return user;
				 }
			 }
			 
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			
		}
		return null;
	}


	//通过id判断用户是否存在
	@Override
	public boolean isUser(String userid) {
		// TODO Auto-generated method stub
		User user=null;
		user=userDao.findUserByUserid(userid);
		if(user!=null){
			return true;
		} else{
			return false;
		}
	
	}
}
