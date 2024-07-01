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
	Seller_Prod_StockTestDAOInterface seller_Prod_StockTestDAO; //Test파일
	
	// 주문상세
	public OrderProdDTO selectById(Integer order_id) {
		return orderprodDAO.selectById(order_id);
	}

	// 주문목록
	public List<OrderProdDTO> selectAll() {
		return orderprodDAO.selectAll();
	}


	// 주문생성, 주문상세 생성, 재고 업데이트
	@Transactional
	public int orderprodInsert(ProductNewVO prodVO, int total_price, String member_id) {
		
		OrderProdDTO order = new OrderProdDTO();
		
		order.setMember_id(member_id);
		order.setTotal_price(total_price);
		
		//1.주문 생성 
		int result = orderprodDAO.orderprodInsert(order);
		
		
		//2.주문상세 생성 
		Integer orderId = order.getOrder_id(); // insert한 orderId값을 가져온다
		
		Order_DetailDTO orderDetailDTO = new Order_DetailDTO();
		
		int productPrice = Integer.parseInt(prodVO.getProductPrice()); //상품 가격
		
		orderDetailDTO.setOrder_num(prodVO.getOrder_num());
		orderDetailDTO.setOrder_product_price(productPrice);
		orderDetailDTO.setOrder_id(orderId);
		orderDetailDTO.setS_stock_id(prodVO.getS_stock_id());
		
		result = orderDetailDAO.orderDetailInsert(orderDetailDTO);
		
		//3.수량 업데이트
		seller_Prod_StockTestDAO.sellProdStockUpdate(prodVO);
		
		return result;
	}
	// 주문수정
	public int orderprodUpdate(OrderProdDTO orderprod) {
		return orderprodDAO.orderprodUpdate(orderprod);
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