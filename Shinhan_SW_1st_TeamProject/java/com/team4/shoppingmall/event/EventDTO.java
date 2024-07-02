package com.team4.shoppingmall.event;

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
public class EventDTO {
	Integer event_id;
	String event_title;
	String event_content;
	String event_img_url;
	Date event_date;
}