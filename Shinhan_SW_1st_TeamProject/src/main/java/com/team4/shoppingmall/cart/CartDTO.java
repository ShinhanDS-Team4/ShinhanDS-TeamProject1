package com.team4.shoppingmall.cart;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CartDTO {
	Integer cart_id;
	String member_id;
	String s_stock_id;
	String r_stock_id;  //대여재고ID 추가
	Integer cart_amount;
	String product_type; //타입 
}