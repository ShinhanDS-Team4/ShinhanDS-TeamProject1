package com.team4.shoppingmall.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {
	@Autowired
	nDAOMybatis adminDAOMybatis;
	
	public AdminDTO loginChk(String admin_id, String admin_pw) {
		return adminDAOMybatis.loginChk(admin_id,admin_pw);
	}
	
	public String findById(String admin_email, String admin_name) {
		return adminDAOMybatis.findById(admin_email, admin_name);
	}
	
	public String findByPw(String admin_id, String admin_name, String admin_phone) {
		return adminDAOMybatis.findByPw(admin_id, admin_name, admin_phone);
	}
}
