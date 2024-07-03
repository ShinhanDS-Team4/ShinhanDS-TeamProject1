package com.team4.shoppingmall.order_prod;

import java.util.List; 

public interface OrderProdDAOInterface {
	
	
	// 주문상세
	public OrderProdDTO selectById(Integer order_id);
	
	// 주문목록
	public List<OrderProdDTO> selectAll();
	
	// 주문생성
	public int orderprodInsert(OrderProdDTO orderprod); 
	
	// 주문수정
	public int orderprodUpdate(OrderProdDTO orderprod);


}