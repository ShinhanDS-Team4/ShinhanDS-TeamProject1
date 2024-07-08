package com.team4.shoppingmall.category;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CategoryDAOMybatis implements CategoryDAOInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.category.";
	
	//상품의 카테고리명 조회
	public CategoryDTO productCategoryByProdId(String prod_id) {
		return sqlSession.selectOne(namespace+"productCategoryByProdId", prod_id);
	};
	
	@Override
	public CategoryDTO selectById(Integer category_id) {
		return sqlSession.selectOne(namespace+"selectById", category_id);
	}

	@Override
	public List<CategoryDTO> selectByParentId(Integer parent_category_id) {
		return sqlSession.selectList(namespace+"selectByParentId", parent_category_id);
	}

	@Override
	public List<CategoryDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

	@Override
	public int categoryInsert(CategoryDTO category) {
		return sqlSession.insert(namespace+"categoryInsert", category);
	}

	@Override
	public int categoryUpdate(CategoryDTO category) {
		return sqlSession.update(namespace+"categoryUpdate", category);
	}

	@Override
	public int categoryDelete(Integer category_id) {
		return sqlSession.delete(namespace+"categoryDelete", category_id);
	}
	
	@Override
	public List<CategoryDTO> traceCurCtg(Map<String, Integer> traced) {
		return sqlSession.selectList(namespace+"traceCurCtg", traced);
	}


	@Override
	public List<CategoryDTO> categoryListBydepth(CategoryDTO category) {
		return sqlSession.selectList(namespace+"categoryListBydepth", category);
	}

	@Override
	public List<CategoryDTO> firstDepthCategoryList() {
		return sqlSession.selectList(namespace+"firstDepthCategoryList");
	}
}

