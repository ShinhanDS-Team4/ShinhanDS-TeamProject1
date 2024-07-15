package com.team4.shoppingmall.order_prod;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.team4.shoppingmall.order_detail.Order_DetailDAOInterface;
import com.team4.shoppingmall.order_detail.Order_DetailDTO;
import com.team4.shoppingmall.prod.ProductNewVO;
import com.team4.shoppingmall.seller_prod_stock.Seller_Prod_StockDAOInterface;
import com.team4.shoppingmall.seller_prod_stock.Seller_Prod_StockDAOMybatis;
import com.team4.shoppingmall.seller_prod_stock.Seller_Prod_StockDTO;
import com.team4.shoppingmall.seller_prod_stockTest.Seller_Prod_StockTestDAOInterface;
import com.team4.shoppingmall.seller_prod_stockTest.Seller_Prod_StockTestDTO;

@Service
public class OrderProdService {

	@Autowired
	OrderProdDAOInterface orderprodDAO;

	@Autowired
	Order_DetailDAOInterface orderDetailDAO;

	@Autowired
	Seller_Prod_StockTestDAOInterface seller_Prod_StockTestDAO; 

	

	//결제 완료된 주문 상품 목록
	public List<Map<String,Object>> orderProductById(String member_id){
		return orderprodDAO.orderProductById(member_id);
	};
	

	public OrderProdDTO selectById(Integer order_id) {
		return orderprodDAO.selectById(order_id);
	}


	public List<OrderProdDTO> selectAll() {
		return orderprodDAO.selectAll();
	}
	

	@Transactional
	public int orderprodInsert(ProductNewVO prodVO, int total_price, String member_id) {
		
		OrderProdDTO order = new OrderProdDTO();
		
		order.setMember_id(member_id);
		order.setTotal_price(total_price);
		
		//1.주문 생성
		int result = orderprodDAO.orderprodInsert(order);
		
		
		//2.주문상세 생성
		//생성된 주문id 시퀀스 번호 찾기 
		int order_id = orderprodDAO.sequenceOrderId(); 
		//Integer orderId = order.getOrder_id(); 
	
		Order_DetailDTO orderDetailDTO = new Order_DetailDTO();
		
		int productPrice = Integer.parseInt(prodVO.getProductPrice()); 
		
		orderDetailDTO.setOrder_num(prodVO.getOrder_num());
		orderDetailDTO.setOrder_product_price(productPrice);
		orderDetailDTO.setOrder_id(order_id);
		orderDetailDTO.setS_stock_id(prodVO.getS_stock_id());
		
		result = orderDetailDAO.orderDetailInsert(orderDetailDTO);
		
		//3.수량 업데이트
		seller_Prod_StockTestDAO.sellProdStockUpdate(prodVO);
		
		return order_id;
	}

	public int orderprodUpdate(OrderProdDTO orderprod) {
		return orderprodDAO.orderprodUpdate(orderprod);
	}
	


	public int updateOrderPrice(OrderProdDTO orderprod) {
		return orderprodDAO.updateOrderPrice(orderprod);
	}
	
	// orderlist.jsp�� ����� ��ǰ��, �귣��, �ɼ�, ��ǰ����, �̹���URL
	public List<OrderProdDetailDTO> selectById2(String orderId) {
        return orderprodDAO.selectById2(orderId);
    }


	public Object selectOptions() { 
        return orderprodDAO.selectOptions();
	}

	public int orderCancel(int orderId) {
		return orderprodDAO.orderCancel(orderId);
	}

	public int orderRefund(int orderId) {
		return orderprodDAO.orderRefund(orderId);
	}
	
	public int orderprodDelete(int order_id) {
		return orderprodDAO.orderprodDelete(order_id);
	}


	public List<OrderProdDTO> selectByMemId(String member_id) {
		return orderprodDAO.selectByMemId(member_id);
	}
	
	

}