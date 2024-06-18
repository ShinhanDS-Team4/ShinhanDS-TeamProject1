package com.team4.shoppingmall.reviews;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewsDAOMybatis implements ReviewsDAOInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.reviews.";
	
	@Override
	public ReviewsDTO selectById(Integer review_id) {
		return sqlSession.selectOne(namespace+"selectById", review_id);
	}

	@Override
	public List<ReviewsDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

	@Override
	public int reviewsInsert(ReviewsDTO reviews) {
		return sqlSession.insert(namespace+"reviewsInsert", reviews);
	}

	@Override
	public int reviewsUpdate(ReviewsDTO reviews) {
		return sqlSession.update(namespace+"reviewsUpdate", reviews);
	}

	@Override
	public int reviewsDelete(Integer review_id) {
		return sqlSession.delete(namespace+"reviewsDelete", review_id);
	}
}