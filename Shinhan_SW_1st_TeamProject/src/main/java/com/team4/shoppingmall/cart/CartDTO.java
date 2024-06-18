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
	Integer sellstock_id;
	Integer rentstock_id;
	Integer cart_amount;
}