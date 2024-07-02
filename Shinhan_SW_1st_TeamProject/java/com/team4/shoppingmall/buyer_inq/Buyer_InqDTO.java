package com.team4.shoppingmall.buyer_inq;

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
public class Buyer_InqDTO {
	Integer buyer_inq_id;
	String buyer_inq_title;
	String buyer_inq_content;
	Date buyer_inq_date;
	String buyer_reply;
	String member_id;
	String prod_id;
	Date buyer_reply_date;
	String email;
}