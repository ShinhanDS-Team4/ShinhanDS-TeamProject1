package com.team4.shoppingmall.order_detail;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter@Setter
public class OrderUpdateReqDTO {
    List<Integer> orderDetailIds;
    String status;
}
