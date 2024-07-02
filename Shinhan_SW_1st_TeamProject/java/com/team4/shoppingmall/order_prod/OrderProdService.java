package com.team4.shoppingmall.order_prod;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderProdService {

	@Autowired
	OrderProdDAOInterface orderprodDAO;

	// 林巩惑技
	public OrderProdDTO selectById(Integer order_id) {
		return orderprodDAO.selectById(order_id);
	}

	// 林巩格废
	public List<OrderProdDTO> selectAll() {
		return orderprodDAO.selectAll();
	}

	// 林巩积己
	public int orderprodInsert(OrderProdDTO orderprod) {
		return orderprodDAO.orderprodInsert(orderprod);
	}

	// 林巩荐沥
	public int orderprodUpdate(OrderProdDTO orderprod) {
		return orderprodDAO.orderprodUpdate(orderprod);
	}
}