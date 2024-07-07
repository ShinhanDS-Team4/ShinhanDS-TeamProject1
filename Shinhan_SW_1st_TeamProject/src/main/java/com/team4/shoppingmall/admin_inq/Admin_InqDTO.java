package com.team4.shoppingmall.admin_inq;

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
public class Admin_InqDTO {
	Integer admin_inq_id;
	String admin_inq_title;
	String admin_inq_content;
	Date admin_inq_date;
	String admin_reply;
	String member_id;
	Integer member_type;
}