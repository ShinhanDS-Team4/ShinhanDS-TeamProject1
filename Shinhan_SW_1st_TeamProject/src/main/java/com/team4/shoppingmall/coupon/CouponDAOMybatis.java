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
	public CouponDTO selectById(CouponDTO couponDTO) {
		return sqlSession.selectOne(namespace+"couponSelectById", couponDTO);
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

	// 가장 최근의 쿠폰 가져오기
	@Override
	public CouponDTO selectFirst() {
		return sqlSession.selectOne(namespace+"selectFirst");
	}

	// 쿠폰 발급하기(insert)
	@Override
	public int assignCouponToMember(CouponDTO coupon) { 
		return sqlSession.insert(namespace+"assignCouponToMember", coupon);
	}

	// 이미 발급받은 쿠폰인지 확인
	@Override
	public int hasCoupon(CouponDTO coupon) {
		return sqlSession.selectOne(namespace+"hasCoupon", coupon); 
	}
	
}