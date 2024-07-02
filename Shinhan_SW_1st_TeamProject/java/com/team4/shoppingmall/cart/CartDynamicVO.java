package com.team4.shoppingmall.cart;

import java.util.Map;

//cartMapper.xml => select문 id="searchStockId"에 사용.
public class CartDynamicVO { 
	//동적인 값
	String prod_id;
	Map<String, String> mapData; //키:값 => 옵션명(예:size):옵션값(예:black)
}
