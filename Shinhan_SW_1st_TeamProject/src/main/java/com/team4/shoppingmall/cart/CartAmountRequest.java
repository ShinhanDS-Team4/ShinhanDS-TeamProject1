package com.team4.shoppingmall.cart;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class CartAmountRequest {
	private Integer cart_id;
    private Integer cart_amount;
}
