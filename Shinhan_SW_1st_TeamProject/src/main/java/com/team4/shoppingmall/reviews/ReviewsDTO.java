package com.team4.shoppingmall.reviews;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ReviewsDTO {
	Integer review_id;
	String review_title;
	Double rate;
	Date review_date;
	String review_img;
	String review_content;
	Integer orderdetail_id;
	String member_id; //칼럼추가
	
	//필드추가
	int avg_rate;
	int review_count;
}