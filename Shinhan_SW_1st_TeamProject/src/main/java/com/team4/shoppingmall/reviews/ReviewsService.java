package com.team4.shoppingmall.reviews;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewsService {
	
	@Autowired
	ReviewsDAOInterface reviewsDAO;
	
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
}