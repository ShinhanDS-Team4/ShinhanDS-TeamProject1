package com.team4.shoppingmall.order_detail;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Order_DetailService {
	@Autowired
	Order_DetailDAOInterface order_DetailDAO;

	public List<Order_DetailDTO> selectByOrder_Id(int order_id) {
		return order_DetailDAO.selectByOrder_Id(order_id);
	}
	
	public List<Order_DetailDTO> selectBySellerID(String member_id){
		return order_DetailDAO.selectBySellerID(member_id);
	}
	
	public List<Order_DetailDTO> selectAll() {
		return order_DetailDAO.selectAll();
	}

	public int orderDetailInsert(Order_DetailDTO order_detail) {
		return order_DetailDAO.orderDetailInsert(order_detail);
	}

	public int orderDetailUpdate(Order_DetailDTO order_detail) {
		return order_DetailDAO.orderDetailUpdate(order_detail);
	}
	
	public int orderDetailStatusUpdate(Order_DetailDTO order_detail) {
		return order_DetailDAO.orderDetailStatusUpdate(order_detail);
	}

	public int orderDetailDelete(int orderdetail_id) {
		return order_DetailDAO.orderDetailDelete(orderdetail_id);
	}
	
	public int orderDetailDelByOrderID(int order_id) {
		return order_DetailDAO.orderDetailDelByOrderID(order_id);
	}
}
