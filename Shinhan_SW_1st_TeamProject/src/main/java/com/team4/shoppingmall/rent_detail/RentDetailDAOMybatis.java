package com.team4.shoppingmall.rent_detail;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team4.shoppingmall.coupon.CouponDTO;

@Repository
public class RentDetailDAOMybatis implements RentDetailDAOInterface {

	@Autowired
	SqlSession sqlSession;

	String namespace = "com.saren.rent_detail."; //�닔�젙

	// ���뿬�긽�꽭 �긽�꽭
	@Override
	public RentDetailDTO selectById(Integer rentdetail_id) {
		return sqlSession.selectOne(namespace+"selectById", rentdetail_id);
	}

	// ���뿬�긽�꽭 紐⑸줉
	@Override
	public List<RentDetailDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

	@Override
	public List<RentDetailDTO> selectBySellerID(String member_id) {
		return sqlSession.selectList(namespace+"selectBySellerID", member_id);
	}
	
	// ���뿬�긽�꽭 �깮�꽦
	@Override
	public int rentDetailInsert(RentDetailDTO rentdetail) {
		return sqlSession.insert(namespace+"rentDetailInsert", rentdetail);
	}
	
	// ���뿬�긽�꽭 �닔�젙
	@Override
	public int rentDetailUpdate(RentDetailDTO rentdetail) {
		return sqlSession.update(namespace+"rentDetailUpdate", rentdetail);
	}
	
	@Override
	public int rentDetailStatusUpdate(RentDetailDTO rentdetail) {
		return sqlSession.update(namespace+"rentDetailStatusUpdate", rentdetail);
	}

	@Override
	public int rentDetailDelete(int rentdetail_id) {
		return sqlSession.delete(namespace+"rentDetailDelete", rentdetail_id);
	}

	@Override
	public List<RentDetailDTO> selectByRental_code(int rental_code) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+"selectByRental_code",rental_code);
	}
}
