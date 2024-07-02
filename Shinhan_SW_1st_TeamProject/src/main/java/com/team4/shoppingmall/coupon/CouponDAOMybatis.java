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
	
	// ÄíÆù»ó¼¼
	@Override
	public CouponDTO selectById(String coupon_id) {
		return sqlSession.selectOne(namespace+"couponSelectById", coupon_id);
	}

	// ÄíÆù¸ñ·Ï
	@Override
	public List<CouponDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}
	
	// ÄíÆù»ç¿ë
	@Override
	public int couponUse(CouponDTO couponDTO) {
		return sqlSession.update(namespace+"couponUse", couponDTO);
	}

	@Override
	public List<CouponDTO> selectCustomerCouponList(String member_id) {
		return sqlSession.selectList(namespace+"selectCustomerCouponList", member_id);
	}
	 
}
