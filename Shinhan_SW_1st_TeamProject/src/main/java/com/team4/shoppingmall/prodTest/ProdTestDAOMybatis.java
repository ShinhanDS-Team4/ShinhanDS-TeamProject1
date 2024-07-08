package com.team4.shoppingmall.prodTest;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team4.shoppingmall.prod.ProdDTO;

@Repository
public class ProdTestDAOMybatis implements ProdDAOTestInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.prod.";
	
	//��ǰ �� ���� ��ȸ
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
	
	@Override
	public List<ProdDTO> selectByCtgId(Integer category_id) {
		return sqlSession.selectList(namespace+"selectByCtgId", category_id);
	}
	
	@Override
	public List<Map<String, Object>> selectAllProdByCurCtg(Map<String, Integer> currentCtg) {
		return sqlSession.selectList(namespace+"selectAllProdByCurCtg", currentCtg);
	}
	
	@Override
	public List<Map<String, Object>> selectProdByLwstCtgId(Map<String, Integer> currentCtg) {
		return sqlSession.selectList(namespace+"selectProdByLwstCtgId", currentCtg);
	}
	
	@Override
	public int selectAllProdNumsByCurCtg(Integer category_id) {
		return sqlSession.selectOne(namespace+"selectAllProdNumsByCurCtg", category_id);
	}
	
	@Override
	public int selectProdNumsByLwstCtgId(Integer category_id) {
		return sqlSession.selectOne(namespace+"selectProdNumsByLwstCtgId", category_id);
	}
	
	@Override
	public List<String> selectBrndsByCtgId(Map<String, Integer> currentCtg) {
		return sqlSession.selectList(namespace+"selectBrndsByCtgId", currentCtg);
	}
	
	@Override
	public Integer selectBrndsNumsByCtgId(Map<String, Integer> currentCtg) {
		return sqlSession.selectOne(namespace+"selectBrndsNumsByCtgId", currentCtg);
	}
	
	@Override
	public List<Map<String, Object>> searchByBrndAndPrc(Map<String, Object> schInfo) {
		return sqlSession.selectList(namespace+"searchByBrndAndPrc", schInfo);
	}
	
	@Override
	public Integer searchNumsByBrndAndPrc(Map<String, Object> schInfo) {
		return sqlSession.selectOne(namespace+"searchNumsByBrndAndPrc", schInfo);
	}
}