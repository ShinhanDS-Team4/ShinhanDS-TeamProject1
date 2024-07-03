package com.team4.shoppingmall.addr_list;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Addr_ListDTO {
	int addr_num;			//주소ID
	String member_id;		//회원ID
	String zipcode;			//우편번호
	String main_address;	//도로명 주소
	String detail_address;	//상세주소
	Boolean is_master_addr;	//대표주소 여부
	String sub_address;		//참고주소
	
}