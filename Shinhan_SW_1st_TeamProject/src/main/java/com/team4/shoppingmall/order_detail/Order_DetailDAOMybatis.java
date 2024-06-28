package com.team4.shoppingmall.order_detail;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Order_DetailDAOMybatis implements Order_DetailDAOInterface{
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.order_detail.";
	
	@Override
	public List<Order_DetailDTO> selectByOrder_Id(int order_id) {
		return sqlSession.selectList(namespace+"selectByOrder_Id", order_id);
	};
	
	@Override
	public List<Order_DetailDTO> selectByOrderDetail_Id(int orderdetail_id) {
		return sqlSession.selectList(namespace+"selectByOrderDetail_Id", orderdetail_id);
	};
	
	@Override
	public List<Order_DetailDTO> selectBySellerID(String member_id) {
		return sqlSession.selectList(namespace+"selectBySellerID", member_id);
	}

	@Override
	public List<Order_DetailDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	};

	@Override
	public int orderDetailInsert(Order_DetailDTO order_detail) {
		return sqlSession.insert(namespace+"orderDetailInsert", order_detail);
	};

	@Override
	public int orderDetailUpdate(Order_DetailDTO order_detail) {
		return sqlSession.update(namespace+"orderDetailUpdate", order_detail);
	};
	
	@Override
	public int orderDetailStatusUpdate(Order_DetailDTO order_detail) {
		return sqlSession.update(namespace+"orderDetailStatusUpdate", order_detail);
	};
	
	@Override
	public int orderDetailDelete(int orderdetail_id) {
		return sqlSession.delete(namespace+"orderDetailDelete", orderdetail_id);
	}

	

	

	
	
}
