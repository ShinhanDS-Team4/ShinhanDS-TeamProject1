package com.team4.shoppingmall.cart;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.team4.shoppingmall.prod.ProductNewVO;

@Service
public class CartService {
	
	@Autowired
	CartDAOInterface cartDAO;
	
	//선택한 옵션 상품의 재고ID 조회
	public String searchStockId(HashMap<String, String> map, String prod_id) {
		return cartDAO.searchStockId(map, prod_id);
	}
	
	//장바구니에 같은 상품이 존재하는지 조회
	public CartDTO selectCartBySellstock(CartDTO cartDTO) {
		return cartDAO.selectCartBySellStock(cartDTO);
	}

	//장바구니 상품 수량 업데이트
	public int updateCartBySellstock(CartDTO cart) {
		return cartDAO.updateCartBySellStock(cart);
	}
	public List<CartDTO> selectSellStockByMemberId(String member_id) {
		return cartDAO.selectSellStockByMemberId(member_id);
	}
	
	public List<CartDTO> selectRentStockByMemberId(String member_id) {
		return cartDAO.selectRentStockByMemberId(member_id);
	}
	
	public List<CartDTO> selectAllStockByMemberId(String member_id) {
		return cartDAO.selectAllStockByMemberId(member_id);
	}
	
	public CartDTO selectByCartId(Integer cart_id) {
		return cartDAO.selectByCartId(cart_id);
	}
	
	public List<CartDTO> selectAll() {
		return cartDAO.selectAll();
	}
	
	public int cartInsert(CartDTO cart) {
		return cartDAO.cartInsert(cart);
	}
	
	public int cartUpdate(CartDTO cart) {
		return cartDAO.cartUpdate(cart);
	}
	
	public int cartDelete(Integer cart_id) {
		return cartDAO.cartDelete(cart_id);
	}
	//판매상품 장바구니 insert문
	@Transactional
	public int cartInsert(ProductNewVO prodVO, String member_id, int cart_amount) {
	
		CartDTO cartDTO = new CartDTO();
		cartDTO.setMember_id(member_id);
		cartDTO.setS_stock_id(prodVO.getS_stock_id());
		//cartDTO.setCart_amount(prodVO.getOrder_num()); 
		cartDTO.setCart_amount(cart_amount); 
		
		//재고 있는지 조회
		CartDTO isExistsSellCart = cartDAO.selectCartBySellStock(cartDTO);
		
		if(isExistsSellCart != null){
			
			cartDTO.setCart_id(isExistsSellCart.getCart_id());
			//중복 상품의 수량 + 업데이트
			int updateResult = cartDAO.updateCartBySellStock(cartDTO);
			return updateResult;
			
		}else {
			
			int result = cartDAO.cartInsert(cartDTO);
			return result;
		}
	}
	//대여상품 장바구니 insert문
	public int cartRentProductInsert(ProductNewVO prodVO, String member_id) {
		
		CartDTO cartDTO = new CartDTO();
		cartDTO.setMember_id(member_id);
		cartDTO.setS_stock_id(prodVO.getS_stock_id());
		cartDTO.setCart_amount(prodVO.getRent_num());//����
		
		//재고 있는지 조회
		CartDTO isExistsRentCart = cartDAO.selectCartByRentStock(cartDTO);
		
		if(isExistsRentCart != null){
			
			cartDTO.setCart_id(isExistsRentCart.getCart_id());
			//중복 상품의 수량 + 업데이트
			int updateResult = cartDAO.updateCartByRentStock(cartDTO);
			return updateResult;
			
		}else {
			int result = cartDAO.cartRentProductInsert(cartDTO);
			return result;
		}
	}
	
}