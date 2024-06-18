package com.team4.shoppingmall.notice;

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
public class NoticeDTO {
	Integer not_id;
	String not_title;
	String not_content;
	Date not_date;
}