package com.team4.shoppingmall.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CartDAOMybatis implements CartDAOInterface {

	@Autowired
	SqlSession sqlSession;

	String namespace = "com.saren.cart.";

	//선택한 옵션 상품의 재고ID 조회
	public String searchStockId(HashMap<String, String> map,String prod_id) {
		//옵션명과 옵션명을 Map으로 저장
		System.out.println("map: "+ map);
		CartDynamicVO datas = new CartDynamicVO();
		datas.prod_id = prod_id;
		datas.mapData = map;
		
		return sqlSession.selectOne(namespace + "searchStockId", datas);
	}
	
	//장바구니(구매상품)에 같은 상품이 존재하는지 조회
	public CartDTO  selectCartBySellStock(CartDTO cart) {
		return sqlSession.selectOne(namespace + "selectCartBySellStock", cart);
	}
	//장바구니(구매상품) 수량 업데이트
	public int updateCartBySellStock(CartDTO cart) {
		return sqlSession.update(namespace + "updateCartBySellStock", cart);
	};
	
	//장바구니(대여상품) 조회
	public CartDTO selectCartByRentStock(CartDTO cart) {
		return sqlSession.selectOne(namespace + "selectCartByRentStock", cart);
	};
	//장바구니(대여상품) 생성
	public int cartRentProductInsert(CartDTO cart) {
		return sqlSession.insert(namespace + "cartRentProductInsert", cart);
	};
	// 장바구니(대여상품) 수량 업데이트
	public int updateCartByRentStock(CartDTO cart) {
		return sqlSession.update(namespace + "updateCartByRentStock", cart);
	};
	@Override
	public List<CartDTO> selectSellStockByMemberId(String member_id) {
		return sqlSession.selectList(namespace + "selectSellStockByMemberId", member_id);
	}

	@Override
	public List<CartDTO> selectRentStockByMemberId(String member_id) {
		return sqlSession.selectList(namespace + "selectRentStockByMemberId", member_id);
	}
	
	@Override
	public List<CartDTO> selectAllStockByMemberId(String member_id) {
		return sqlSession.selectList(namespace + "selectAllStockByMemberId", member_id);
	}

	@Override
	public CartDTO selectByCartId(Integer cart_id) {
		return sqlSession.selectOne(namespace + "selectByCartId", cart_id);
	}

	@Override
	public List<CartDTO> selectAll() {
		return sqlSession.selectList(namespace + "selectAll");
	}
	//장바구니(구매상품) 생성
	@Override
	public int cartInsert(CartDTO cart) {
		return sqlSession.insert(namespace + "cartInsert", cart);
	}

	@Override
	public int cartUpdate(CartDTO cart) {
		return sqlSession.update(namespace + "cartUpdate", cart);
	}

	@Override
	public int cartDelete(Integer cart_id) {
		return sqlSession.delete(namespace + "cartDelete", cart_id);
	}
	
	


}
