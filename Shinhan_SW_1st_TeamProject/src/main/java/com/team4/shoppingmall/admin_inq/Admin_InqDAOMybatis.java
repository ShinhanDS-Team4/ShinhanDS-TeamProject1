package com.team4.shoppingmall.admin_inq;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	@Override
	public Integer findMaxAdminInqId() {
		return sqlSession.selectOne(namespace+"findMaxAdminInqId");
	}

	@Override
	public List<Admin_InqDTO> selectBySellerAll() {
		return sqlSession.selectList(namespace+"selectBySellerAll");
	}
	
	@Override
	public List<Admin_InqDTO> selectByCustomerAll() {
		return sqlSession.selectList(namespace+"selectByCustomerAll");
	}
	
	@Override
	public List<Admin_InqDTO> searchFaq(String searchQuery, String boardType) {
		Map<String, Object> selectseller = new HashMap<>();
		selectseller.put("searchQuery", searchQuery);
		selectseller.put("boardType", boardType);
		return sqlSession.selectList(namespace+"searchFaq", selectseller);
	}
	
	@Override
	public int admin_reply_delete(Integer admin_inq_id) {
		return sqlSession.update(namespace+"admin_reply_delete", admin_inq_id);
	}
	
	@Override
	public int admin_replyUpdate(Admin_InqDTO reply_update) {
		return sqlSession.update(namespace+"admin_replyUpdate", reply_update);
	}	
}
