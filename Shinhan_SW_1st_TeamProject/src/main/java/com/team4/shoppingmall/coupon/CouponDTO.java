package com.team4.shoppingmall.coupon;

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
public class CouponDTO {
	Integer coupon_id;
	String member_id;
	String coupon_name;
	Double discount_rate;
	Integer quantity; 
}