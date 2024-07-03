package com.team4.shoppingmall.order_prod;

import java.util.List;
import java.util.Map;

import com.team4.shoppingmall.prod.ProductNewVO;
import com.team4.shoppingmall.prod_option.Prod_OptionDTO; 

public interface OrderProdDAOInterface {
	
	//결제 완료된 주문 상품 목록
	public List<Map<String,Object>> orderProductById(String member_id);
	
	//나의 주문 상품 정보 조회
	public List<OrderProdDetailDTO> selectById2(int order_id);
	
	//주문id 시퀀스 번호 찾기
	public int sequenceOrderId();
	
	public OrderProdDTO selectById(Integer order_id);
	
	public List<OrderProdDTO> selectAll();
	
	public int orderprodInsert(OrderProdDTO orderprod); 

	public int orderprodUpdate(OrderProdDTO orderprod);
	
	//public Map<String, Object> selectById2(int order_id);

	public List<Prod_OptionDTO> selectOptions();

	public int orderCancel(int orderId);

	public int orderRefund(int orderId);

	
	
}
