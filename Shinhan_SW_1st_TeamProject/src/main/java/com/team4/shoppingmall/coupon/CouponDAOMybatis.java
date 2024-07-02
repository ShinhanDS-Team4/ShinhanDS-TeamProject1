package com.team4.shoppingmall.coupon;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CouponDAOMybatis implements CouponDAOInterface {

	//@Autowired
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
	public int couponUse(String coupon_id) {
		return sqlSession.update(namespace+"couponUse", coupon_id);
	}

//	@Override
//	public int couponUpdate(CouponDTO coupon) {
//		return sqlSession.update(namespace+"couponUpdate", coupon);
//	}
 
//	@Override
//	public int couponDelete(String coupon_id) {
//		return sqlSession.delete(namespace+"couponDelete", coupon_id);
//	}
	
//	@Override
//	public int couponInsert(CouponDTO coupon) {
//		return sqlSession.insert(namespace+"couponInsert", coupon);
//	}
	


 
 
}
