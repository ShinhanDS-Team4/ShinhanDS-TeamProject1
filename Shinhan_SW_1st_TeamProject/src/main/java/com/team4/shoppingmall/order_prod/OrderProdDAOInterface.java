package com.team4.shoppingmall.order_prod;

import java.util.List; 

public interface OrderProdDAOInterface {
	
	
	// 林巩惑技
	public OrderProdDTO selectById(Integer order_id);
	
	// 林巩格废
	public List<OrderProdDTO> selectAll();
	
	// 林巩积己
	public int orderprodInsert(OrderProdDTO orderprod); 
	
	// 林巩荐沥
	public int orderprodUpdate(OrderProdDTO orderprod);


}
