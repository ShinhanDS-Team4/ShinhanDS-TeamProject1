package com.team4.shoppingmall.order_prod;

import java.util.List;
import java.util.Map;

import com.team4.shoppingmall.prod_option.Prod_OptionDTO; 

public interface OrderProdDAOInterface {
	
	// 주문상세
	public OrderProdDTO selectById(Integer order_id);
	
	// 주문목록
	public List<OrderProdDTO> selectAll();
	
	// 주문생성
	public int orderprodInsert(OrderProdDTO orderprod); 
	
	// 주문수정
	public int orderprodUpdate(OrderProdDTO orderprod);
	
	// orderlist.jsp에 출력할 판매상품 상세정보(브랜드명, 상품명, 옵션, 대여가격, 이미지URL)
	public Map<String, Object> selectById2(int order_id);

	// orderlist.jsp에서, 상세상품 옵션 출력시, 모든 옵션 가져오기
	public List<Prod_OptionDTO> selectOptions();

	// orderlist.jsp에서, 주문취소
	public int orderCancel(int orderId);

	// orderlist.jsp에서, 주문환불
	public int orderRefund(int orderId);

	public int updateOrderPrice(OrderProdDTO orderprod);
	
}
