package com.team4.shoppingmall.rent_prod_stock;

import java.util.List;
import java.util.Map;

import com.team4.shoppingmall.prod.ProductNewVO;
import com.team4.shoppingmall.seller_prod_stockTest.Seller_Prod_StockTestDTO;

public interface RentProdStockDAOInterface {
	
	//선택 옵션 상품의 대여 재고id 찾기
	public Map<String,String> selectRentStockByProdId(String prod_id, String optionString);

	//상품의 대여 재고id 조회
	public List<RentProdStockDTO> selectRentStockByProdId2(String prod_id);
	
	//대여 생성시 대여 수량 업데이트
	public int rentProdStockUpdate(ProductNewVO prodVO);
	
	//대여 상품 옵션별 재고 조회
	public List<RentProdStockDTO> selectRpsOptionByProdId(String prod_id);
	
	// 대여상품상세
	public RentProdStockDTO selectById(String r_stock_id);

	public Integer findMaxStockNumber(String prod_id);
	
	public List<RentProdStockListDTO> findRentStockList(String member_id);
	
	// 대여상품목록
	public List<RentProdStockDTO> selectAll();

	// 대여상품등록
	public int rentProdInsert(RentProdStockDTO rentprod);

	// 대여상품수정
	public int rentProdUpdate(RentProdStockDTO rentprod);

	// 대여상품삭제
	public int rentProdDelete(String r_stock_id);

	

	

}
