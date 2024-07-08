package com.team4.shoppingmall.rent;

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
public class RentSelectDTO {
	String prod_name;
	String brand;
	Integer opt_id1;
	Integer opt_id2;
	Integer opt_id3;
	Integer opt_id4;
	Integer opt_id5;
	Integer rent_product_price;
	String img_id;
	String rent_state;
	Integer rentdetail_id;
	String prod_id;
	Integer rent_num;
}