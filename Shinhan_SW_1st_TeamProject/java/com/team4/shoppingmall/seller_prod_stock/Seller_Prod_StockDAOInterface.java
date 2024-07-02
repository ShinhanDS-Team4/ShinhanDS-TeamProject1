package com.team4.shoppingmall.seller_prod_stock;

import java.util.List;

public interface Seller_Prod_StockDAOInterface {
	
	public Seller_Prod_StockDTO selectByStockId(String s_stock_id);

	public List<Seller_Prod_StockDTO> selectByProdId(String prod_id);
	
	public Integer findMaxStockNumber(String prod_id);
	
	public List<Seller_Prod_StockListDTO> findSellStockList(String member_id);
	
	public List<Seller_Prod_StockDTO> selectAll();
	
//	public List<MemberDTO> selectByCondition();
	
	public int seller_prod_stockInsert(Seller_Prod_StockDTO seller_prod_stock);
	
	public int seller_prod_stockUpdate(Seller_Prod_StockDTO seller_prod_stock);
	
	public int seller_prod_stockDelete(String s_stock_id);

	
}
