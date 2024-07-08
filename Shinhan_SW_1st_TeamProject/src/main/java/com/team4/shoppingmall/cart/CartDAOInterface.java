package com.team4.shoppingmall.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface CartDAOInterface {
	
	//대여 장바구니 담은 개수
	public int countRentCartList(String member_id);
	//판매상품 장바구니 담은 개수
	public int countSellCartList(String member_id);
	
	//판매 장바구니 상품 정보 조회
	public List<Map<String,Object>> selectSellCartProdInfo(String member_id);
	
	//대여 장바구니 상품 정보 조회
	public List<Map<String,Object>> selectRentCartProdInfo(String member_id);

	//선택한 옵션 상품의 재고ID 조회
	public String searchStockId(HashMap<String, String> map, String prod_id);

	//장바구니에 같은 상품이 존재하는지 조회
//	public CartDTO selectCartBySellstock(Map<String, String> map);
	public CartDTO selectCartBySellStock(CartDTO cart);
	
	//장바구니(구매상품) 수량 업데이트
	public int updateCartBySellStock(CartDTO cart);
	
	//장바구니(대여상품) 조회
	public CartDTO selectCartByRentStock(CartDTO cart);
	
	//장바구니(대여상품) 생성
	public int cartRentProductInsert(CartDTO cart);
	
	// 장바구니(대여상품) 수량 업데이트
	public int updateCartByRentStock(CartDTO cart);
	
	public List<CartDTO> selectSellStockByMemberId(String member_id);
	
	public List<CartDTO> selectRentStockByMemberId(String member_id);
	
	public List<CartDTO> selectAllStockByMemberId(String member_id);
	
	public CartDTO selectByCartId(Integer cart_id);
	
	public List<CartDTO> selectAll();
	
//	public List<MemberDTO> selectByCondition();
	
	//장바구니(구매상품) 생성
	public int cartInsert(CartDTO cart);
	
	public int cartUpdate(CartDTO cart);
	
	public int cartDelete(Integer cart_id);


	
	
}