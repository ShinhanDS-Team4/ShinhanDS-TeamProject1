
package com.team4.shoppingmall.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDAOMybatis {
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace="com.saren.admin.";
	Logger logger = LoggerFactory.getLogger(AdminDAOMybatis.class);
	
	public AdminDTO loginChk(String admin_id, String admin_pw) {
		return sqlSession.selectOne(namespace + "loginChk", admin_id);
	}
	
	public String findById(String admin_email, String admin_name) {
		Map<String, Object> selectByIdMap = new HashMap<>();
		selectByIdMap.put("admin_email", admin_email);
		selectByIdMap.put("admin_name", admin_name);		
		String admin_id = sqlSession.selectOne(namespace + "findById", selectByIdMap);
		logger.info(admin_id);
		return admin_id;
	}
	
	public String findByPw(String admin_id, String admin_name, String admin_phone) {
		Map<String, Object> selectByPwMap = new HashMap<>();
		selectByPwMap.put("admin_id", admin_id);
		selectByPwMap.put("admin_name", admin_name);
		selectByPwMap.put("admin_phone", admin_phone);
		return sqlSession.selectOne(namespace + "findByPw", selectByPwMap);
	}

    public boolean updateByPw(String admin_id, String new_admin_pw) {
        Map<String, Object> updatePwMap = new HashMap<>();
        updatePwMap.put("admin_id", admin_id);
        updatePwMap.put("new_admin_pw", new_admin_pw);
        int is_updatePw = sqlSession.update(namespace + "updateByPw", updatePwMap);
        return is_updatePw > 0;
    }
    
    public int adminmypageedit(AdminDTO aDto) {
    	return sqlSession.update(namespace+"adminmypageedit", aDto);
    }
    
    public List<Map<String, Object>> dailyVisitorDataSeller(String yymm) {    	
    	return sqlSession.selectList(namespace+"dailyVisitorDataSeller",yymm);
    }
    public List<Map<String, Object>> dailyVisitorDataCustomer(String yymm) {    	
    	return sqlSession.selectList(namespace+"dailyVisitorDataCustomer",yymm);
    }

	public List<Map<String, Object>> dailyRevenueChart(String yymm) {		
		return sqlSession.selectList(namespace+"dailyRevenueChart",yymm);
	}
	
}