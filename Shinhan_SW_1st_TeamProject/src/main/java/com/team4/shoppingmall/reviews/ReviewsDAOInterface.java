package com.team4.shoppingmall.reviews;

import java.util.List;
import java.util.Map;

public interface ReviewsDAOInterface {
	
	//상품 리뷰 목록
	public List<Map<String,String>> selectAllProductReviewByProdId(String prod_id);
	
	//리뷰 평균과 리뷰 수
	public ReviewsDTO reviewAvgByProdId(String prod_id);
	
	
	public ReviewsDTO selectById(Integer review_id);
	
	public List<ReviewsDTO> selectAll();
	
//	public List<MemberDTO> selectByCondition();
	
	public int reviewsInsert(ReviewsDTO reviews);
	
	public int reviewsUpdate(ReviewsDTO reviews);
	
	public int reviewsDelete(Integer review_id);

	public List<ReviewsDTO> selectBymemId(String member_id);
}