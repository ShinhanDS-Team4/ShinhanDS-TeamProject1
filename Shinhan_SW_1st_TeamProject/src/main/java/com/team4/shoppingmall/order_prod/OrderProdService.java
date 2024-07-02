package com.team4.shoppingmall.order_prod;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderProdService {

	@Autowired
	OrderProdDAOInterface orderprodDAO;

	// 주문상세
	public OrderProdDTO selectById(Integer order_id) {
		return orderprodDAO.selectById(order_id);
	}

	// 주문목록
	public List<OrderProdDTO> selectAll() {
		return orderprodDAO.selectAll();
	}

	// 주문생성
	public int orderprodInsert(OrderProdDTO orderprod) {
		return orderprodDAO.orderprodInsert(orderprod);
	}

	// 주문수정
	public int orderprodUpdate(OrderProdDTO orderprod) {
		return orderprodDAO.orderprodUpdate(orderprod);
	}
	
	//할인 적용 업데이트
	public int updateOrderPrice(OrderProdDTO orderprod) {
		return orderprodDAO.updateOrderPrice(orderprod);
	}
	
	// orderlist.jsp에 출력할 상품명, 브랜드, 옵션, 상품가격, 이미지URL
	public Map<String, Object> selectById2(int order_id) {
        return orderprodDAO.selectById2(order_id);
    }

	// orderlist.jsp에서, 상세상품 옵션 출력시, 모든 옵션 가져오기
	public Object selectOptions() { 
        return orderprodDAO.selectOptions();
	}

	// orderlist.jsp에서, 주문취소
	public int orderCancel(int orderId) {
		return orderprodDAO.orderCancel(orderId);
	}

	// orderlist.jsp에서, 환불
	public int orderRefund(int orderId) {
		return orderprodDAO.orderRefund(orderId);
	}

}