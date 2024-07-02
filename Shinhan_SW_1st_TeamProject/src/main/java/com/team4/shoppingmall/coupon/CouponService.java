package com.team4.shoppingmall.coupon;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CouponService {
	
	@Autowired
	CouponDAOInterface couponDAO;
	
	// 쿠폰상세
	public CouponDTO selectById(String coupon_id) {
		return couponDAO.selectById(coupon_id);
	}
	
	// 쿠폰목록
	public List<CouponDTO> selectAll() {
		return couponDAO.selectAll();
	}
	
	//회원별 보유 쿠폰 목록
	public List<CouponDTO> selectCustomerCouponList(String member_id){
		return couponDAO.selectCustomerCouponList(member_id);
	}
	
	// 쿠폰사용
	public int couponUse(String coupon_id) {
		return couponDAO.couponUse(coupon_id);
	}
}