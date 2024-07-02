package com.team4.shoppingmall.prod;

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
public class ProductNewVO {//상세페이지에서 json으로 받는 값 저장
	//판매
	String s_stock_id;
	int order_num;
	String productPrice;
	String prod_id;
	int stock; 
	
	//대여
	String r_stock_id;
	int rent_num;
	Date rent_start_date;
	Date rent_end_date;
	int rent_product_price;
	int total_rent_price;
}
