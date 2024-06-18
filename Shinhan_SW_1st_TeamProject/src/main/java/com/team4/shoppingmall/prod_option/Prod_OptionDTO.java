package com.team4.shoppingmall.prod_option;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Prod_OptionDTO {
	Integer opt_id;
	String opt_name;
	String opt_value;
	Integer prod_id;
	String email;
}