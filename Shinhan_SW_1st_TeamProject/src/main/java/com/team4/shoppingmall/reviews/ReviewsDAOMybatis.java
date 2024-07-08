package com.team4.shoppingmall.reviews;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewsDAOMybatis implements ReviewsDAOInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.reviews.";
	
	
	//상품 리뷰 목록
	public List<Map<String,String>> selectAllProductReviewByProdName(String prod_name){
		return sqlSession.selectList(namespace+"selectAllProductReviewByProdName", prod_name);
	};
	//리뷰 평균과 리뷰 수
	public Map<Integer, Integer> reviewAvgByProdId(String prod_id) {
		return sqlSession.selectOne(namespace+"reviewAvgByProdId", prod_id);
	};
	
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

	@Override
	public List<ReviewsDTO> selectBymemId(String member_id) {
		return sqlSession.selectList(namespace+"selectBymemId", member_id);
	}
	
}