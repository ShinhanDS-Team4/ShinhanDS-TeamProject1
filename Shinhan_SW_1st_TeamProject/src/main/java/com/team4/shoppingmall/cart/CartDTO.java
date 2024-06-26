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
	Integer cart_amount;
}