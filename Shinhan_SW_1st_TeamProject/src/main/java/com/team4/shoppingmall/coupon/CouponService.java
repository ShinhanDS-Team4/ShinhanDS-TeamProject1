package com.team4.shoppingmall.coupon;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team4.shoppingmall.member.MemberDTO;

@Service
public class CouponService {
	
	@Autowired
	CouponDAOInterface couponDAO;
	
	// 쿠폰상세
	public CouponDTO selectById(CouponDTO couponDTO) {
		return couponDAO.selectById(couponDTO);
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
	public int couponUse(CouponDTO couponDTO) {
		return couponDAO.couponUse(couponDTO);
	} 

	// home에서, 가장 최근 쿠폰 가져오기
	public CouponDTO selectFirst() {
		return couponDAO.selectFirst();
	}

	// 쿠폰 발급 
	public int assignCouponToMember(CouponDTO coupon) { 
		return couponDAO.assignCouponToMember(coupon); 
	} 

	// 이미 발급된 쿠폰인지 확인
	public int hasCoupon(CouponDTO coupon) {
		return couponDAO.hasCoupon(coupon); 

	}

}