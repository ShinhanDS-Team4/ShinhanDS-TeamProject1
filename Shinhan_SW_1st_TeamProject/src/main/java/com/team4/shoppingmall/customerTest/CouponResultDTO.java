package com.team4.shoppingmall.customerTest;

import com.team4.shoppingmall.coupon.CouponDTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter@Getter
@AllArgsConstructor
@NoArgsConstructor
public class CouponResultDTO {
	int discount;
	int discountedPrice;
	int couponID;
}
