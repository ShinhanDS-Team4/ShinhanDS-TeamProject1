package com.team4.shoppingmall.customer;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team4.shoppingmall.coupon.CouponDTO;

@Repository
public class CustomerDAOMybatis implements CustomerDAOInterface {

	//@Autowired
	SqlSession sqlSession;

	String namespace = "com.saren.customer.";

	// °í°´»ó¼¼
	@Override
	public CustomerDTO selectById(Integer rental_code) {
		return sqlSession.selectOne(namespace+"selectById", rental_code);
	}
	
	// °í°´¸ñ·Ï
	@Override
	public List<CustomerDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}
	
	// °í°´µî·Ï
	@Override
	public int customerInsert(CustomerDTO customer) {
		return sqlSession.insert(namespace+"customerInsert", customer);
	}
	
	// °í°´¼öÁ¤
	@Override
	public int customerUpdate(Integer rental_code) {
		return sqlSession.update(namespace+"customerUpdate", rental_code);
	}

}
