package com.team4.shoppingmall.buyer_inq;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Buyer_InqDAOMybatis implements Buyer_InqDAOInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.buyer_inq.";
	
	//상품ID의 전체 문의 목록 조회 
	public List<Buyer_InqDTO> selectByProdId(String prod_id) {
		return sqlSession.selectList(namespace+"selectByProdId", prod_id);
	}
	
	@Override
	public Buyer_InqDTO selectByInqId(Integer buyer_inq_id) {
		return sqlSession.selectOne(namespace+"selectByInqId", buyer_inq_id);
	}
	
	@Override
	public Buyer_InqDetailDTO selectByInqIdFORseller(Integer buyer_inq_id) {
		System.out.println("selectByInqIdFORseller DAOMybatis ����");
		return sqlSession.selectOne(namespace+"selectByInqIdFORseller", buyer_inq_id);
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
	public List<Buyer_InqDTO> selectInqList(String member_id){
		return sqlSession.selectList(namespace+"selectInqList",member_id);
	}

	//insert 타입 수정
	@Override
	public int buyer_inqInsert(Map<String,String> buyer_inq_map) {
		return sqlSession.insert(namespace+"buyer_inqInsert", buyer_inq_map);
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
