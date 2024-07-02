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
	int addr_num;
    String member_id;
    String zipcode;
    String main_address;
    String detail_address;
    String is_master_addr;
    String sub_address;
}