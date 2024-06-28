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
public class MemberDTO {
	String member_id;
	String member_pw;
	String member_name;
	String member_email;
	String member_phone;
	String member_brand;
	Date member_birth_date;
	Date member_last_access;
	Integer member_type;
	String member_gender;
	String member_seller_authority;
	Date member_seller_create_date;
}