package com.jxlg.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.jxlg.bean.Contactinfo;
import com.jxlg.dao.IUserInfoDao;

public class UserInfoDapImpl extends HibernateDaoSupport implements IUserInfoDao {

	//通过用户id查找用户详细信息
	@Override
	public Contactinfo getUserInfo(String userid) {
		// TODO Auto-generated method stub
		Query query = this.getSession().createQuery("from Contactinfo");
		List<Contactinfo> list=query.list();
		for(Contactinfo con:list){
			if(userid.equals(con.getUserId())){
				return con;
			}
		}
		return null;
	}

	//保存用户详细信息
	@Override
	public void saveOrupdataUserInfo(Contactinfo con) {
		// TODO Auto-generated method stub
		this.getSession().saveOrUpdate(con);
	}
	
}
