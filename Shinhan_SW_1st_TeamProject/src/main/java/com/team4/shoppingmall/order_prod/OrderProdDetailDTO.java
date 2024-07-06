package com.team4.shoppingmall.order_prod;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OrderProdDetailDTO {
	String prod_name;
	String brand;
	Integer opt_id1;
	Integer opt_id2;
	Integer opt_id3;
	Integer opt_id4;
	Integer opt_id5;
	Integer order_product_price;
	String img_id;
	String order_state;
	String orderdetail_id;
	String prod_id;
	String order_num;
}
