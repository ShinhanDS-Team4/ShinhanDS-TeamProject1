package com.team4.shoppingmall.buyer_inq;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Buyer_InqDetailDTO {
	Integer buyer_inq_id;
	String member_id;
	String member_name;
	String phone;
	String buyer_inq_title;
	String buyer_inq_content;
	String buyer_reply;
}
