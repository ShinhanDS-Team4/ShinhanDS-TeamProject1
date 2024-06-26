package com.team4.shoppingmall.seller_prod_stock;

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
public class Seller_Prod_StockListDTO {
	String s_stock_id;
	Integer prod_price;
	Date prod_added_date;
	Integer stock;
}
