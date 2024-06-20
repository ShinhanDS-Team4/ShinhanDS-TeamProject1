package com.team4.shoppingmall.order_prod;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OrderProdDAOMybatis implements OrderProdDAOInterface {

	@Autowired
	SqlSession sqlSession;

	String namespace = "com.saren.orderprod.";

	// 주문상세
	@Override
	public OrderProdDTO selectById(Integer order_id) {
		return sqlSession.selectOne(namespace+"selectById", order_id);
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
	
	// orderlist.jsp에 출력할 상품명, 브랜드, 옵션, 상품가격, 이미지URL
	@Override
	public List<Map<String, Object>> selectById2(Integer order_id) { 
        return sqlSession.selectList(namespace + "selectById2", order_id);
    }

}
