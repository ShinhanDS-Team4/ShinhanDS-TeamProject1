package com.team4.shoppingmall.customer;

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
public class CustomerDTO { 
	String member_id;
	Integer point;
	String member_level;
	Integer accum_account;
}