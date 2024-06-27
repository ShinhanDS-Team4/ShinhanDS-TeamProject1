package com.team4.shoppingmall.prod_optionTest;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team4.shoppingmall.prod_option.Prod_OptionDTO;

@Repository
public class Prod_OptionTestDAOMybatis implements Prod_OptionTestDAOInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.prod_option.";
	
	//옵션명과 옵션값을 함께 조회
	@Override
	public List<Object> selectAllOptionsByProdId(String prod_id){
		 return sqlSession.selectList(namespace + "selectAllOptionsByProdId", prod_id);
	};
	
	//상품의 옵션조회
	public List<Prod_OptionDTO> productAllOptionsByProdId(String prod_id){
	 return sqlSession.selectList(namespace + "productAllOptionsByProdId", prod_id);
	};

	@Override
	public Prod_OptionTestDTO selectByOptionId(Integer opt_id) {
		return sqlSession.selectOne(namespace+"selectByOptionId", opt_id);
	}
	
	@Override
	public List<Prod_OptionTestDTO> selectByProdId(Integer prod_id) {
		return sqlSession.selectList(namespace+"selectByProdId", prod_id);
	}

	@Override
	public List<Prod_OptionTestDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

	@Override
	public int prod_optionInsert(Prod_OptionTestDTO prod_option) {
		return sqlSession.insert(namespace+"prod_optionInsert", prod_option);
	}

	@Override
	public int prod_optionUpdate(Prod_OptionTestDTO prod_option) {
		return sqlSession.update(namespace+"prod_optionUpdate", prod_option);
	}

	@Override
	public int prod_optionDelete(Integer opt_id) {
		return sqlSession.delete(namespace+"prod_optionDelete", opt_id);
	}
}
