package com.jxlg.service;

import com.jxlg.bean.User;

public interface IUserService {
	//更新用户信息
	void updateUserinfo(User user);
	
	//注册一个新用户
	void registerUser(User user);
	
	//登录
	User login(String username,String password);
	
	//通过id判断用户是否存在
	boolean isUser(String userid);
}
