package com.team4.shoppingmall.rent;

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
public class RentDTO {
	Integer rental_code;
	Date rent_start_date;
	Date rent_end_date; 
	String member_id;
	Integer total_rent_price;
}