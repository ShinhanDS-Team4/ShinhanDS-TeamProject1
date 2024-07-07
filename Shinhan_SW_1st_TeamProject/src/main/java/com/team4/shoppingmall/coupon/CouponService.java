package com.team4.shoppingmall.coupon;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CouponService {
	
	@Autowired
	CouponDAOInterface couponDAO;
	
	// 荑좏룿�긽�꽭
	public CouponDTO selectById(int coupon_id) {
		return couponDAO.selectById(coupon_id);
	}
	
	// 荑좏룿紐⑸줉
	public List<CouponDTO> selectAll() {
		return couponDAO.selectAll();
	}
	
	//�쉶�썝蹂� 蹂댁쑀 荑좏룿 紐⑸줉
	public List<CouponDTO> selectCustomerCouponList(String member_id){
		return couponDAO.selectCustomerCouponList(member_id);
	}
	
	// 荑좏룿�궗�슜
	public int couponUse(CouponDTO couponDTO) {
		return couponDAO.couponUse(couponDTO);
	}
}