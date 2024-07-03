package com.team4.shoppingmall.seller_prod_stockTest;

import java.util.List;

public interface Seller_Prod_StockTestDAOInterface {
	
	//상품ID로 옵션별 판매 상품 재고 조회
	public List<Seller_Prod_StockTestDTO> selectSpsOptionByProdId(String prod_id);
	
	public Seller_Prod_StockTestDTO selectByStockId(String stock_id);

	public List<Seller_Prod_StockTestDTO> selectByProdId(String prod_id);
	
	public List<Seller_Prod_StockTestDTO> selectAll();
	
//	public List<MemberDTO> selectByCondition();
	
	public int seller_prod_stockInsert(Seller_Prod_StockTestDTO seller_prod_stock);
	
	public int seller_prod_stockUpdate(Seller_Prod_StockTestDTO seller_prod_stock);
	
	public int seller_prod_stockDelete(String stock_id);
}