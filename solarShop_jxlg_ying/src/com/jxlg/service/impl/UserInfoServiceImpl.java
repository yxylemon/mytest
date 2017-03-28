package com.jxlg.service.impl;

import com.jxlg.bean.Contactinfo;
import com.jxlg.dao.IUserInfoDao;
import com.jxlg.service.IUserInfoService;

public class UserInfoServiceImpl implements IUserInfoService{
	private IUserInfoDao userInfoDao;


	public IUserInfoDao getUserInfoDao() {
		return userInfoDao;
	}

	public void setUserInfoDao(IUserInfoDao userInfoDao) {
		this.userInfoDao = userInfoDao;
	}
	//通过用户id查找用户详细信息
	@Override
	public Contactinfo getUserInfo(String userid) {
		// TODO Auto-generated method stub
		
		Contactinfo con=userInfoDao.getUserInfo(userid);
		return con;
	}
	//保存用户详细信息
	@Override
	public void saveOrupdataUserInfo(Contactinfo con) {
		// TODO Auto-generated method stub
		userInfoDao.saveOrupdataUserInfo(con);
	}
}
