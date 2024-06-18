package com.team4.shoppingmall.buyer_inq;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Buyer_InqDAOMybatis implements Buyer_InqDAOInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.buyer_inq.";
	
	@Override
	public Buyer_InqDTO selectByInqId(Integer buyer_inq_id) {
		return sqlSession.selectOne(namespace+"selectByInqId", buyer_inq_id);
	}

	@Override
	public List<Buyer_InqDTO> selectByMemberId(String member_id) {
		return sqlSession.selectList(namespace+"selectByMemberId", member_id);
	}

	@Override
	public List<Buyer_InqDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

	@Override
	public int buyer_inqInsert(Buyer_InqDTO buyer_inq) {
		return sqlSession.insert(namespace+"buyer_inqInsert", buyer_inq);
	}

	@Override
	public int buyer_inqUpdate(Buyer_InqDTO buyer_inq) {
		return sqlSession.update(namespace+"buyer_inqUpdate", buyer_inq);
	}

	@Override
	public int buyer_inqDelete(Integer buyer_inq_id) {
		return sqlSession.delete(namespace+"buyer_inqDelete", buyer_inq_id);
	}
}
