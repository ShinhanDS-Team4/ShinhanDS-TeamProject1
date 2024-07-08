package com.team4.shoppingmall.admin;

import java.util.List;
import java.util.Map;

public interface AdminDAOInterface {
	
	public AdminDTO loginChk(String admin_id, String admin_pw);
	public String findById(String admin_email, String admin_name);
	public String findByPw(String admin_id, String admin_name, String admin_phone);
	public boolean updateByPw(String admin_id, String new_admin_pw);
	public int adminmypageedit(AdminDTO aDto);
    public List<Map<String, Object>> dailyVisitorDataSeller(String yymm);
    public List<Map<String, Object>> dailyVisitorDataCustomer(String yymm);
    public List<Map<String, Object>> dailyRevenueChart(String yymm);     
}
