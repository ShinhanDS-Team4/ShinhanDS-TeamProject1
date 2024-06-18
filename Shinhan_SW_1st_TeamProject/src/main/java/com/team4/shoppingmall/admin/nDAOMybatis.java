package com.team4.shoppingmall.admin;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class nDAOMybatis {
	
	//@Autowired
	SqlSession sqlSession;
	
	String namespace="com.saren.shoppingmall.admin.";
	Logger logger = LoggerFactory.getLogger(nDAOMybatis.class);
	
	public AdminDTO loginChk(String admin_id, String admin_pw) {
		AdminDTO aDTO = sqlSession.selectOne(namespace + "loginChk", admin_id);
		logger.info(aDTO==null?"존재하지 않는 직원":aDTO.toString());
		return aDTO;
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
		String admin_pw = sqlSession.selectOne(namespace + "selectByPw", selectByPwMap);
		logger.info(admin_pw);
		return admin_pw;
	}
	
	
}
