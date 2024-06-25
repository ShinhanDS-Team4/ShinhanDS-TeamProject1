package com.team4.shoppingmall.cart;

import java.util.HashMap;
import java.util.List;

public interface CartDAOInterface {
	
	//선택한 옵션 상품의 재고ID 조회
	public String searchStockId(HashMap<String, String> map, String prod_id);
	
	public List<CartDTO> selectSellStockByMemberId(String member_id);
	
	public List<CartDTO> selectRentStockByMemberId(String member_id);
	
	public List<CartDTO> selectAllStockByMemberId(String member_id);
	
	public CartDTO selectByCartId(Integer cart_id);
	
	public List<CartDTO> selectAll();
	
//	public List<MemberDTO> selectByCondition();
	
	public int cartInsert(CartDTO cart);
	
	public int cartUpdate(CartDTO cart);
	
	public int cartDelete(Integer cart_id);
	
	
}
