package com.team4.shoppingmall.prodTest;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProdTestDAOMybatis implements ProdDAOTestInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.prod.";
	
	//상품 상세 정보 조회
	@Override
	public Map<String,Object> selectProdDetailInfoByProdId(String prod_id) {
		return sqlSession.selectOne(namespace+"selectProdDetailInfoByProdId", prod_id);
	}
	
	@Override
	public ProdTestDTO selectByProdId(String prod_id) {
		return sqlSession.selectOne(namespace+"selectByProdId", prod_id);
	}
	
	@Override
	public List<ProdTestDTO> selectByMemberId(String member_id) {
		return sqlSession.selectList(namespace+"selectByMemberId", member_id);
	}

	@Override
	public List<ProdTestDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

	@Override
	public int prodInsert(ProdTestDTO prod) {
		return sqlSession.insert(namespace+"prodInsert", prod);
	}

	@Override
	public int prodUpdate(ProdTestDTO prod) {
		return sqlSession.update(namespace+"prodUpdate", prod);
	}

	@Override
	public int prodDelete(Integer prod_id) {
		return sqlSession.delete(namespace+"prodDelete", prod_id);
	}
}