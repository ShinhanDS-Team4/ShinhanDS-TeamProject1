package com.team4.shoppingmall.reviews;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewsService {
	
	@Autowired
	ReviewsDAOInterface reviewsDAO;
	
	//상품 리뷰 목록
	public List<Map<String,String>> selectAllProductReviewByProdName(String prod_name){
		return reviewsDAO.selectAllProductReviewByProdName(prod_name);
	};
	//리뷰 평균과 리뷰 수
	public Map<Integer, Integer> reviewAvgByProdId(String prod_id) {
		return reviewsDAO.reviewAvgByProdId(prod_id);
	};
	
	public ReviewsDTO selectById(Integer review_id) {
		return reviewsDAO.selectById(review_id);
	}
	
	public List<ReviewsDTO> selectAll() {
		return reviewsDAO.selectAll();
	}
	
	public int reviewsInsert(ReviewsDTO reviews) {
		return reviewsDAO.reviewsInsert(reviews);
	}
	
	public int reviewsUpdate(ReviewsDTO reviews) {
		return reviewsDAO.reviewsUpdate(reviews);
	}
	
	public int reviewsDelete(Integer review_id) {
		return reviewsDAO.reviewsDelete(review_id);
	}
	
	//내 리뷰 불러오기를 위한 memberId로 select하기
	public List<ReviewsDTO> selectBymemId(String member_id){
		return reviewsDAO.selectBymemId(member_id);
	}
}