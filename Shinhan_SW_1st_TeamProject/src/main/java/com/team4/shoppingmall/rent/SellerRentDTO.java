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
public class SellerRentDTO {
	String member_id;
	String member_name;	
	String email;
	String phone;
	String brand;
	Date birth_date;
	Date last_access;
	Integer member_type;
	String gender;
	String seller_authority;
	Date create_date;
	
	String prod_id;
	String prod_name;
	String prod_desc;
	Integer prod_price;
	Date prod_added_date;
	
	Integer category_id;
	
	String img_id;	
	Integer img_type;
	
	Integer opt_id;
	String opt_name;
	String opt_value;
	
	Integer rental_code;
	Date rent_start_date;
	Date rent_end_date; 
	Integer total_rent_price;
		
	Integer rentdetail_id;
	Integer rent_product_price;
	Integer rent_num;
	String rent_state;
	
	String r_stock_id;
	Integer stock;
	Integer total;
	Integer opt_id1;
	Integer opt_id2;
	Integer opt_id3;
	Integer opt_id4;
	Integer opt_id5;
}
