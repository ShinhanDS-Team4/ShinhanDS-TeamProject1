package com.team4.shoppingmall.member;

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
public class MemberCustomerDTO {

	String member_id;
	String member_pw;
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
	
	Integer point;
	String member_level;
	Integer accum_amount;
	
	Integer addr_num;    
    String zipcode;
    String main_address;
    String detail_address;
    String is_master_addr;
    String sub_address;
    
    String coupon_id;
    String coupon_name;
    Integer discount_rate;
    Integer quantity;
    String coupon_state;
    
}
