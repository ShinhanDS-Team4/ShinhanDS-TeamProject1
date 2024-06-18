package com.team4.shoppingmall.category;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CategoryDAOMybatis implements CategoryDAOInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.category.";
	
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
}
