package com.jxlg.dao;

import com.jxlg.bean.User;

public interface IUserDao {
	//保存一个用户
	void saveUser(User user) ;
	
	//更新一个用户
	void updateUser(User user) ;
	
	//通过用户id查找一个用户
	User findUserByUserid(String username);

}
