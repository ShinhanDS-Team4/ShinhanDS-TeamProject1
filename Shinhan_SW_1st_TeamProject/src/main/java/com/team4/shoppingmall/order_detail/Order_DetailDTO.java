package com.team4.shoppingmall.order_detail;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Order_DetailDTO {
	int orderdetail_id;   	 	//주문상세번호
	int order_product_price;	//상품가격
	int order_num;				//주문수량
	int order_id;				//주문ID
	String s_stock_id;			//재고ID (수정)
	String order_state; 		//주문상태 (수정)
}
