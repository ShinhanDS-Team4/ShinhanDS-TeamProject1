package com.team4.shoppingmall.reviews;

import java.util.List;
import java.util.Map;

public interface ReviewsDAOInterface {
	
	//ÁÖ¹®ÇÑ »óÇ°ÀÇ ¸®ºäÁ¤º¸
	public List<Map<String,String>> selectAllProductReviewByProdId(String prod_id);
	
	public ReviewsDTO selectById(Integer review_id);
	
	public List<ReviewsDTO> selectAll();
	
//	public List<MemberDTO> selectByCondition();
	
	public int reviewsInsert(ReviewsDTO reviews);
	
	public int reviewsUpdate(ReviewsDTO reviews);
	
	public int reviewsDelete(Integer review_id);

	public List<ReviewsDTO> selectBymemId(String member_id);
}