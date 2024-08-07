package com.team4.shoppingmall.seller_prod_stockTest;

import java.util.List;
import java.util.Map;

import com.team4.shoppingmall.prod.ProductNewVO;

public interface Seller_Prod_StockTestDAOInterface {
	
	//높은 판매량 상품 16개 출력
	public List<Map<String,Object>> selectBestProducts();
	
	//상품ID로 옵션별 판매 상품 재고 조회
	public List<Seller_Prod_StockTestDTO> selectSpsOptionByProdId(String prod_id);
	
	//주문 생성시 재고수 업데이트
	//public int sellProdStockUpdate(Seller_Prod_StockTestDTO seller_prod_stock);
	public int sellProdStockUpdate(ProductNewVO prodVO);
	
	public Seller_Prod_StockTestDTO selectByStockId(String stock_id);

	public List<Seller_Prod_StockTestDTO> selectByProdId(String prod_id);
	
	public List<Seller_Prod_StockTestDTO> selectAll();
	
//	public List<MemberDTO> selectByCondition();
	
	public int seller_prod_stockInsert(Seller_Prod_StockTestDTO seller_prod_stock);
	
	public int seller_prod_stockUpdate(Seller_Prod_StockTestDTO seller_prod_stock);
	
	public int seller_prod_stockDelete(String stock_id);
}