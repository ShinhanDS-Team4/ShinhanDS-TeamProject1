package com.team4.shoppingmall.coupon;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CouponDAOMybatis implements CouponDAOInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.coupon.";
	
	// 쿠폰상세
	@Override
	public CouponDTO selectById(String coupon_id) {
		return sqlSession.selectOne(namespace+"couponSelectById", coupon_id);
	}

	// 쿠폰목록
	@Override
	public List<CouponDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}
	
	// 쿠폰사용
	@Override
	public int couponUse(CouponDTO couponDTO) {
		return sqlSession.update(namespace+"couponUse", couponDTO);
	}

	@Override
	public List<CouponDTO> selectCustomerCouponList(String member_id) {
		return sqlSession.selectList(namespace+"selectCustomerCouponList", member_id);
	}
	 
}