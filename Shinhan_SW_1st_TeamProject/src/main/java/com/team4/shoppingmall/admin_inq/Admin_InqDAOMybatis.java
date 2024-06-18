package com.team4.shoppingmall.admin_inq;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Admin_InqDAOMybatis implements Admin_InqDAOInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.admin_inq.";
	
	@Override
	public Admin_InqDTO selectByInqId(Integer admin_inq_id) {
		return sqlSession.selectOne(namespace+"selectByInqId", admin_inq_id);
	}
	
	@Override
	public List<Admin_InqDTO> selectByMemberId(String member_id){
		return sqlSession.selectList(namespace+"selectByMemberId", member_id);
	}

	@Override
	public List<Admin_InqDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

	@Override
	public int admin_inqInsert(Admin_InqDTO admin_inq) {
		return sqlSession.insert(namespace+"admin_inqInsert", admin_inq);
	}

	@Override
	public int admin_inqUpdate(Admin_InqDTO admin_inq) {
		return sqlSession.update(namespace+"admin_inqUpdate", admin_inq);
	}

	@Override
	public int admin_inqDelete(Integer admin_inq_id) {
		return sqlSession.delete(namespace+"admin_inqDelete", admin_inq_id);
	}
}
