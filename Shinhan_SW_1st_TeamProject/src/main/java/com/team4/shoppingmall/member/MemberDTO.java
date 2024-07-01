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
	String email;
	String phone;
	String brand;
	Date birth_date;
	Date last_access;
	Integer member_type;
	String gender;
	String seller_authority;
	Date create_date;
}