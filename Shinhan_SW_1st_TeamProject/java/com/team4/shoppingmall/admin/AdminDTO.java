package com.team4.shoppingmall.admin;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString

public class AdminDTO {
	private Integer admin_no;
	private String admin_id;
	private String admin_pw;
	private String admin_email;
	private String admin_name;
	private String admin_phone;
}
