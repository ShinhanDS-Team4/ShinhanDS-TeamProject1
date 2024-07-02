package com.team4.shoppingmall.order_detail;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


public interface Order_DetailDAOInterface {

	public Order_DetailDTO selectByOrderDetail_Id(int orderdetail_id);

	public List<Order_DetailDTO> selectAll();

	public int orderDetailInsert(Order_DetailDTO order_detail);

	public int orderDetailUpdate(Order_DetailDTO order_detail);

	public int orderDetailDelete(int orderdetail_id);
}
