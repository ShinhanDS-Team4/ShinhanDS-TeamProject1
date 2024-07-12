package com.team4.shoppingmall.order_detail;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetailVO {
	//사용 x
   List<Order_DetailDTO> orderDetails;
 
}