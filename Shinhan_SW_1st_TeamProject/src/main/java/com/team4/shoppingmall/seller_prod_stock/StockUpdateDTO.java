package com.team4.shoppingmall.seller_prod_stock;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter@Setter
public class StockUpdateDTO {
	List<String> sellStockIds;
    String status;
}
