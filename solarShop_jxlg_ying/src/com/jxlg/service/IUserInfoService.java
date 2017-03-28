package com.jxlg.service;

import com.jxlg.bean.Contactinfo;

public interface IUserInfoService {
	//通过用户id查找用户详细信息
	Contactinfo getUserInfo(String userid);
	//保存用户详细信息
	void saveOrupdataUserInfo(Contactinfo con);
}
