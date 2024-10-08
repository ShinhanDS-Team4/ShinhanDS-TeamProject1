package com.team4.shoppingmall.admin;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {
	@Autowired
	AdminDAOMybatis adminDAOMybatis;
	
	public AdminDTO loginChk(String admin_id, String admin_pw) {
		return adminDAOMybatis.loginChk(admin_id,admin_pw);
	}
	
	public String findById(String admin_email, String admin_name) {
		return adminDAOMybatis.findById(admin_email, admin_name);
	}
	
	public String findByPw(String admin_id, String admin_name, String admin_phone) {
		return adminDAOMybatis.findByPw(admin_id, admin_name, admin_phone);
	}
	
	public boolean updateByPw(String admin_id, String new_admin_pw) {
        return adminDAOMybatis.updateByPw(admin_id, new_admin_pw);
    }
	
	public int adminmypageedit(AdminDTO aDto) {
		return adminDAOMybatis.adminmypageedit(aDto);
	}
	
    public List<Map<String, Object>> dailyVisitorDataSeller(String yymm) {
    	return adminDAOMybatis.dailyVisitorDataSeller(yymm);
    }

    public List<Map<String, Object>> dailyVisitorDataCustomer(String yymm) {
    	return adminDAOMybatis.dailyVisitorDataCustomer(yymm);
    }

	public List<Map<String, Object>> dailyRevenueChart(String yymm) {
		return adminDAOMybatis.dailyRevenueChart(yymm);
	}
	
}
