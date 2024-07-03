package com.team4.shoppingmall.prod_option;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Prod_OptionDAOMybatis implements Prod_OptionDAOInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.prod_option.";
	
	@Override
	public Prod_OptionDTO selectByOptionId(Integer opt_id) {
		return sqlSession.selectOne(namespace+"selectByOptionId", opt_id);
	}
	
	@Override
	public List<Prod_OptionDTO> selectByProdId(String prod_id) {
		return sqlSession.selectList(namespace+"selectByProdId", prod_id);
	}
	
	@Override
	public Integer findMaxOptId() {
		return sqlSession.selectOne(namespace+"findMaxOptId");
	}

	@Override
	public List<Prod_OptionDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

	@Override
	public int prod_optionInsert(Prod_OptionDTO prod_option) {
		return sqlSession.insert(namespace+"prod_optionInsert", prod_option);
	}

	@Override
	public int prod_optionUpdate(Prod_OptionDTO prod_option) {
		return sqlSession.update(namespace+"prod_optionUpdate", prod_option);
	}

	@Override
	public int prod_optionDelete(Integer opt_id) {
		return sqlSession.delete(namespace+"prod_optionDelete", opt_id);
	}
}
