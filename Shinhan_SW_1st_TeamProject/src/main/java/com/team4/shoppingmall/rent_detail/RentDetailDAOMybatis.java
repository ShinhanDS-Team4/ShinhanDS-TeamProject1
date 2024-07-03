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
	String namespace = "com.saren.rent_detail."; //수정

<<<<<<< HEAD
	String namespace = "com.saren.rent_detail."; 

=======
>>>>>>> main
	// 대여상세 상세
	@Override
	public RentDetailDTO selectById(Integer rentdetail_id) {
		return sqlSession.selectOne(namespace+"selectById", rentdetail_id);
	}

<<<<<<< HEAD
	// 대여상세 목록
=======
>>>>>>> main
	@Override
	public List<RentDetailDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

<<<<<<< HEAD
=======
	@Override
	public List<RentDetailDTO> selectBySellerID(String member_id) {
		return sqlSession.selectList(namespace+"selectBySellerID", member_id);
	}
	
>>>>>>> main
	// 대여상세 생성
	@Override
	public int rentDetailInsert(RentDetailDTO rentdetail) {
		return sqlSession.insert(namespace+"rentDetailInsert", rentdetail);
	}
	
	// 대여상세 수정
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

	@Override
	public int rentDetailDelByRentCode(Integer rental_code) {
		return sqlSession.delete(namespace+"rentDetailDelByRentCode", rental_code);
	}
}

