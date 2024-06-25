package com.team4.shoppingmall.reviews;

import java.util.List;

public interface ReviewsDAOInterface {
	
	//주문한 상품의 리뷰정보
	public List<ReviewsDTO> selectAllProductReviewByProdId(String prod_id);
	
	public ReviewsDTO selectById(Integer review_id);
	
	public List<ReviewsDTO> selectAll();
	
//	public List<MemberDTO> selectByCondition();
	
	public int reviewsInsert(ReviewsDTO reviews);
	
	public int reviewsUpdate(ReviewsDTO reviews);
	
	public int reviewsDelete(Integer review_id);
}
