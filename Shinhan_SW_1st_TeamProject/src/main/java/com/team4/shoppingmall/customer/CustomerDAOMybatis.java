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

	@Override
	public CustomerDTO selectById(String member_id) {
		return sqlSession.selectOne(namespace+"selectById", member_id);
	}
	
	@Override
	public List<CustomerDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}
	
	@Override
	public int customerInsert(CustomerDTO customer) {
		return sqlSession.insert(namespace+"customerInsert", customer);
	}
	
	@Override
	public int customerUpdate(Integer rental_code) {
		return sqlSession.update(namespace+"customerUpdate", rental_code);
	}
	
	@Override
    public Long TotalMoneyAmount() {
        return sqlSession.selectOne(namespace + "TotalMoneyAmount");
    }

}
