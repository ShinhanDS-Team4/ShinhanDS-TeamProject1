package com.team4.shoppingmall.prod;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProdDAOMybatis implements ProdDAOInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.prod.";
	
	@Override
	public ProdDTO selectByProdId(String prod_id) {
		return sqlSession.selectOne(namespace+"selectByProdId", prod_id);
	}
	
	@Override
	public List<ProdDTO> selectByMemberId(String member_id) {
		return sqlSession.selectList(namespace+"selectByMemberId", member_id);
	}

	@Override
	public List<ProdDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

	@Override
	public int prodInsert(ProdDTO prod) {
		return sqlSession.insert(namespace+"prodInsert", prod);
	}

	@Override
	public int prodUpdate(ProdDTO prod) {
		return sqlSession.update(namespace+"prodUpdate", prod);
	}

	@Override
	public int prodDelete(Integer prod_id) {
		return sqlSession.delete(namespace+"prodDelete", prod_id);
	}

	@Override
	public int prodModify(ProdDTO prod) {
		return sqlSession.update(namespace+"prodModify", prod);
  }

	@Override
	public List<Map<String, Object>> selectAll2() {
		return sqlSession.selectList(namespace+"selectAll2"); 
	}

	@Override
	public List<Map<String, Object>> selectByCategory(int categoryId) {
		return sqlSession.selectList(namespace+"selectByCategory", categoryId); 
	}
}