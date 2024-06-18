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
	int addr_num;			//林家ID
	String member_id;		//雀盔ID
	String zipcode;			//快祈锅龋
	String main_address;	//档肺疙 林家
	String detail_address;	//惑技林家
	Boolean is_master_addr;	//措钎林家 咯何
	String sub_address;		//曼绊林家
	
}