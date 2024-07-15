package com.team4.shoppingmall.order_prod;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OrderProdDTO {
	Integer order_id;
	Date order_date;
	String member_id;
	Integer addr_num;
	Integer total_price;
}