package com.team4.shoppingmall.order_detail;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Order_DetailDTO {
	int orderdetail_id;   	 	//二쇰Ц�긽�꽭踰덊샇
	int order_product_price;	//�긽�뭹媛�寃�
	int order_num;				//二쇰Ц�닔�웾
	int order_id;				//二쇰ЦID
	String s_stock_id;			//�옱怨쟅D (�닔�젙)
	String order_state; 		//二쇰Ц�긽�깭 (�닔�젙)
}
