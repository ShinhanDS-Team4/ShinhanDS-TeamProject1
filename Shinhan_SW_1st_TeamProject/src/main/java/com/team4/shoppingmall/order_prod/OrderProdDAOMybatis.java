package com.team4.shoppingmall.order_prod;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OrderProdDAOMybatis implements OrderProdDAOInterface {

	//@Autowired
	SqlSession sqlSession;

	String namespace = "com.saren.orderprod.";

	// 주문상세
	@Override
	public OrderProdDTO selectById(Integer order_id) {
		return sqlSession.selectOne(namespace+"", order_id);
	}

	// 주문목록
	@Override
	public List<OrderProdDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

	// 주문생성
	@Override
	public int orderprodInsert(OrderProdDTO orderprod) {
		return sqlSession.insert(namespace+"orderprodInsert", orderprod);
	}

	// 주문수정
	@Override
	public int orderprodUpdate(OrderProdDTO orderprod) {
		return sqlSession.update(namespace+"orderprodUpdate", orderprod);
	}

}