package com.team4.shoppingmall.rent;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team4.shoppingmall.coupon.CouponDTO;

@Repository
public class RentDAOMybatis implements RentDAOInterface {

	@Autowired
	SqlSession sqlSession;

	String namespace = "com.saren.rent.";
	
	@Override
	public int searchRentId() {
		return sqlSession.selectOne(namespace+"searchRentId");
	}

	// 대여상세
	@Override
	public RentDTO selectById(Integer rental_code) {
		return sqlSession.selectOne(namespace+"selectById", rental_code);
	}

	// 대여목록
	@Override
	public List<RentDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

	// 대여하기
	@Override
	public int rentInsert(RentDTO rent) {
		return sqlSession.insert(namespace+"rentInsert", rent);
	}

	// 대여상태 수정
	@Override
	public int rentUpdate(Integer rental_code) {
		return sqlSession.update(namespace+"rentUpdate", rental_code);
	}

}
