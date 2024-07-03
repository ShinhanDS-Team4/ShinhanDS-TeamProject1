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

	
	//결제 완료된 주문 상품 목록
	public List<Map<String,Object>> orderProductById(String member_id){
		return sqlSession.selectList(namespace+"orderProductById", member_id);
	};
	
//	public List<OrderProdDetailDTO> selectById2(int order_id){
//		return sqlSession.selectList(namespace+"selectById2", order_id);
//	};
	
	//나의 주문 상품 정보 조회
	public int sequenceOrderId() {
		return sqlSession.selectOne(namespace+"sequenceOrderId");
	};


	@Override
	public OrderProdDTO selectById(Integer order_id) {
		return sqlSession.selectOne(namespace+"selectById", order_id);
	}

	@Override
	public List<OrderProdDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

	@Override
	public int orderprodInsert(OrderProdDTO orderprod) {
		return sqlSession.insert(namespace+"orderprodInsert", orderprod);
	}
	
	@Override
	public int orderprodUpdate(OrderProdDTO orderprod) {
		return sqlSession.update(namespace+"orderprodUpdate", orderprod);
	}


	@Override
	public List<OrderProdDetailDTO> selectById2(int order_id) { 
        return sqlSession.selectList(namespace + "selectById2", order_id);
    } 
	
	@Override
	public List<Prod_OptionDTO> selectOptions() { 
		List<Prod_OptionDTO> optlist = sqlSession.selectList(namespace + "selectOptions"); 
        return optlist;
	}

	// orderlist.jsp����, �ֹ����
	@Override
	public int orderCancel(int orderId) {
        return sqlSession.update(namespace + "orderCancel", orderId);
	}

	// orderlist.jsp����, �ֹ�ȯ��
	@Override
	public int orderRefund(int orderId) {
        return sqlSession.update(namespace + "orderRefund", orderId); 
	}

	@Override
	public int updateOrderPrice(OrderProdDTO orderprod) {
		return sqlSession.update(namespace+"updateOrderPrice", orderprod);
	}

	@Override
	public int orderprodDelete(int order_id) {
		return sqlSession.delete(namespace+"orderprodDelete",order_id);
	} 

}