package com.team4.shoppingmall.rent_prod_stock;

import java.util.List;

public interface RentProdStockDAOInterface {

	// 대여상품상세
	public RentProdStockDTO selectById(String r_stock_id);

	public int findMaxStockNumber(String prod_id);
	
	public List<RentProdStockListDTO> findRentStockList(String member_id);
	
	// 대여상품목록
	public List<RentProdStockDTO> selectAll();

	// 대여상품등록
	public int rentProdInsert(RentProdStockDTO rentprod);

	// 대여상품수정
	public int rentProdUpdate(String r_stock_id);

	// 대여상품삭제
	public int rentProdDelete(String r_stock_id);

	

}
