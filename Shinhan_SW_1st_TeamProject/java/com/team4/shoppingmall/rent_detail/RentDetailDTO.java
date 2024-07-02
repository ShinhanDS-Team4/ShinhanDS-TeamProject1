package com.team4.shoppingmall.rent_detail; 

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
@NoArgsConstructor
@AllArgsConstructor
public class RentDetailDTO {
	Integer rentdetail_id;
	Integer rent_product_price;
	Integer rent_num;
	Integer stock_id;
	Integer rental_code;
}