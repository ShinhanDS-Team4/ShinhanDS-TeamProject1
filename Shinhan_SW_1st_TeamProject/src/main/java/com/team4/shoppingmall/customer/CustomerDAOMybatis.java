package com.team4.shoppingmall.customer;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CustomerDAOMybatis implements CustomerDAOInterface {

	@Autowired
	SqlSession sqlSession;

	String namespace = "com.saren.customer.";

	// 占쏙옙占쏙옙
	@Override
	public CustomerDTO selectById(String customer_id) {
		return sqlSession.selectOne(namespace+"selectById", customer_id);
	}
	
	// 占쏙옙占쏙옙占�
	@Override
	public List<CustomerDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}
	
	// 占쏙옙占쏙옙占�
	@Override
	public int customerInsert(CustomerDTO customer) {
		return sqlSession.insert(namespace+"customerInsert", customer);
	}
	
	// 占쏙옙占쏙옙占쏙옙
	@Override
	public int customerUpdate(CustomerDTO customer) {
		return sqlSession.update(namespace+"customerUpdate", customer);
	}
	
	@Override
    public Long TotalMoneyAmount() {
        return sqlSession.selectOne(namespace + "TotalMoneyAmount");
    }

}
