package com.team4.shoppingmall.coupon;

import java.util.List;

public interface CouponDAOInterface {
	
	// 쿠폰상세
	public CouponDTO selectById(CouponDTO couponDTO);
	
	// 쿠폰목록
	public List<CouponDTO> selectAll();
	
//	public List<CouponDTO> selectByCondition();
	
	// 쿠폰등록
//	public int couponInsert(CouponDTO coupon);
	
	// 쿠폰수정
//	public int couponUpdate(CouponDTO coupon);
	
	// 쿠폰삭제
//	public int couponDelete(String coupon_id);
	
	// 쿠폰사용
	public int couponUse(CouponDTO couponDTO);

	//회원별 보유 쿠폰 목록
	public List<CouponDTO> selectCustomerCouponList(String member_id);

	// 가장 최근 쿠폰 가져오기
	public CouponDTO selectFirst();

	// 쿠폰 받기
	public int assignCouponToMember(CouponDTO coupon);

	// 사용자가 쿠폰 발급받았는지 확인
	public int hasCoupon(CouponDTO coupon);
}