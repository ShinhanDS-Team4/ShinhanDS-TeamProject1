package com.team4.shoppingmall.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.team4.shoppingmall.prod.ProductNewVO;

@Service
public class CartService {
	
	@Autowired
	CartDAOInterface cartDAO;
	
	//해당 장바구니ID의 상품정보 조회
	public Map<String, Object> sellCartProdByCart_id(String member_id, Integer cart_id){
		 return cartDAO.sellCartProdByCart_id(member_id, cart_id);
	}
	
	//대여 장바구니 담은 개수
	public int countRentCartList(String member_id) {
		return cartDAO.countRentCartList(member_id);
	};
	//판매상품 장바구니 담은 개수
	public int countSellCartList(String member_id) {
		return cartDAO.countSellCartList(member_id);
	};
	
	//판매 장바구니 상품 정보 조회
	public List<Map<String,Object>> selectSellCartProdInfo(String member_id) {
		return cartDAO.selectSellCartProdInfo(member_id);
	};
	
	//대여 장바구니 상품 정보 조회
	public List<Map<String,Object>> selectRentCartProdInfo(String member_id) {
		return cartDAO.selectRentCartProdInfo(member_id);
	};
	//선택한 옵션 상품의 재고ID 조회
	public String searchStockId(HashMap<String, String> map, String prod_id) {
		return cartDAO.searchStockId(map, prod_id);
	}
	
	//장바구니에 같은 상품이 존재하는지 조회
	public CartDTO selectCartBySellstock(CartDTO cartDTO) {
		return cartDAO.selectCartBySellStock(cartDTO);
	}

	//장바구니 상품 수량 업데이트
	public int updateCartBySellStock(CartDTO cart) {
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
		
		//같은 재고 있는지 조회
		CartDTO isExistsSellCart = cartDAO.selectCartBySellStock(cartDTO);
		
		if(isExistsSellCart != null){
			
			cartDTO.setCart_id(isExistsSellCart.getCart_id());
			//중복 상품의 수량 + 업데이트
			int updateResult = cartDAO.updateCartBySellStock(cartDTO);
			return updateResult;
			
		}else {
			
			int result = cartDAO.cartInsert(cartDTO);
			
			//insert된 장바구니 ID 저장
			int cart_id = cartDTO.getCart_id();
			
			return cart_id;
		}
	}
	//대여상품 장바구니 insert문
	public int cartRentProductInsert(ProductNewVO prodVO, String member_id) {
		
		CartDTO cartDTO = new CartDTO();
		cartDTO.setMember_id(member_id);
		cartDTO.setR_stock_id(prodVO.getR_stock_id());  //대여재고ID
		//cartDTO.setS_stock_id(prodVO.getS_stock_id());
		cartDTO.setCart_amount(prodVO.getRent_num());
		
		//같은 대여상품 재고 있는지 조회 - 수정
		CartDTO isExistsRentCart = cartDAO.selectCartByRentStock(cartDTO);
		
		if(isExistsRentCart != null){
			
			cartDTO.setCart_id(isExistsRentCart.getCart_id());
			//중복 상품의 수량 + 업데이트
			int updateResult = cartDAO.updateCartByRentStock(cartDTO);
			return updateResult;
			
		}else {
			int result = cartDAO.cartRentProductInsert(cartDTO);
			//장바구니id(대여)
			int rentCartId = cartDTO.getCart_id();
			
			return rentCartId;
		}
	}

	
}