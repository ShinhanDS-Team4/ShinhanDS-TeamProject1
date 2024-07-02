package com.team4.shoppingmall.reviews;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewsService {
	
	@Autowired
	ReviewsDAOInterface reviewsDAO;
	
	//ÏÉÅÌíà Î¶¨Î∑∞ Î™©Î°ù
	public List<Map<String,String>> selectAllProductReviewByProdId(String prod_id){
		return reviewsDAO.selectAllProductReviewByProdId(prod_id);
	};
	//Î¶¨Î∑∞ ÌèâÍ∑†Í≥º Î¶¨Î∑∞ Ïàò
	public ReviewsDTO reviewAvgByProdId(String prod_id) {
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
	
	//≥ª ∏Æ∫‰ ∫“∑Øø¿±‚∏¶ ¿ß«— memberId∑Œ select«œ±‚
	public List<ReviewsDTO> selectBymemId(String member_id){
		return reviewsDAO.selectBymemId(member_id);
	}
}