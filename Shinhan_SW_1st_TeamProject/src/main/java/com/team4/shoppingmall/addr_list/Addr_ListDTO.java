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
	int addrNum;
    String memberId;
    String zipcode;
    String mainAddress;
    String detailAddress;
    Boolean isMasterAddr; //е╦ют Boolean
    String subAddress;
	
}