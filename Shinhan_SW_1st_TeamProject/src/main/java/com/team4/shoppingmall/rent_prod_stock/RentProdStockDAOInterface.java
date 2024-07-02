package com.team4.shoppingmall.rent_prod_stock;

import java.util.List;
import java.util.Map;

public interface RentProdStockDAOInterface {
	
	//선택 옵션 상품의 대여 재고id 찾기
	public Map<String,String> selectRentStockByProdId(String prod_id, String optionString);

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

	public int rentStockUpdate(RentProdStockDTO rentprod);

	

	

}
