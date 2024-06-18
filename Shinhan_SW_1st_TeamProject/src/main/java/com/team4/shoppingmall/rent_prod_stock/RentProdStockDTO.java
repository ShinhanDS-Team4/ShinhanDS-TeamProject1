package com.team4.shoppingmall.rent_prod_stock;

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
public class RentProdStockDTO {
	Integer stock_id;
	Integer r_p_stock;
	Integer r_p_total;
	Integer prod_id;
	Integer opt_id1;
	Integer opt_id2;
	Integer opt_id3;
	Integer opt_id4;
	Integer opt_id5;
}