package com.team4.shoppingmall.order_prod;

import java.util.List;
import java.util.Map; 

public interface OrderProdDAOInterface {
	
	
	// 주문상세
	public OrderProdDTO selectById(Integer order_id);
	
	// 주문목록
	public List<OrderProdDTO> selectAll();
	
	// 주문생성
	public int orderprodInsert(OrderProdDTO orderprod); 
	
	// 주문수정
	public int orderprodUpdate(OrderProdDTO orderprod);
	
	// orderlist.jsp에 출력할 상품명, 브랜드, 옵션, 상품가격, 이미지URL 
	public List<Map<String, Object>> selectById2(Integer order_id);
	


}
