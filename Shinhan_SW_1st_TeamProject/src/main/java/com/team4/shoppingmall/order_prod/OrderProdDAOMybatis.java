package com.team4.shoppingmall.order_prod;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team4.shoppingmall.prod_option.Prod_OptionDTO;

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
	public Map<String, Object> selectById2(int order_id) { 
        return sqlSession.selectOne(namespace + "selectById2", order_id);
    } 
	
	// orderlist.jsp에서, 상세상품 옵션 출력시, 모든 옵션 가져오기
	@Override
	public List<Prod_OptionDTO> selectOptions() { 
		List<Prod_OptionDTO> optlist = sqlSession.selectList(namespace + "selectOptions"); 
        return optlist;
	}

	// orderlist.jsp에서, 주문취소
	@Override
	public int orderCancel(int orderId) {
        return sqlSession.update(namespace + "orderCancel", orderId);
	}

	// orderlist.jsp에서, 주문환불
	@Override
	public int orderRefund(int orderId) {
        return sqlSession.update(namespace + "orderRefund", orderId); 
	}

	@Override
	public int updateOrderPrice(OrderProdDTO orderprod) {
		return sqlSession.update(namespace+"updateOrderPrice", orderprod);
	} 

}
