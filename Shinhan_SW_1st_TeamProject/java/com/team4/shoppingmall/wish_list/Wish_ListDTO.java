package com.team4.shoppingmall.wish_list;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Wish_ListDTO {
	String member_id;
	Integer prod_id;
	String email;
}