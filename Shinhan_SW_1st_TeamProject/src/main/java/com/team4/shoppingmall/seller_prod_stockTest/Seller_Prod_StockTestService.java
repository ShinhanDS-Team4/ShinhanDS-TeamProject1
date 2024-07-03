package com.team4.shoppingmall.seller_prod_stockTest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Seller_Prod_StockTestService {
	
	@Autowired
	Seller_Prod_StockTestDAOInterface seller_prod_stockDAO;
	
	//상품ID로 옵션별 판매 상품 재고 조회
	public List<Seller_Prod_StockTestDTO> selectSpsOptionByProdId(String prod_id){
		return seller_prod_stockDAO.selectSpsOptionByProdId(prod_id);
	}
	
	public Seller_Prod_StockTestDTO selectByStockId(String stock_id) {
		return seller_prod_stockDAO.selectByStockId(stock_id);
	}

	public List<Seller_Prod_StockTestDTO> selectByProdId(String prod_id) {
		return seller_prod_stockDAO.selectByProdId(prod_id);
	}
	
	public List<Seller_Prod_StockTestDTO> selectAll() {
		return seller_prod_stockDAO.selectAll();
	}
	
	public int seller_prod_stockInsert(Seller_Prod_StockTestDTO seller_prod_stock) {
		return seller_prod_stockDAO.seller_prod_stockInsert(seller_prod_stock);
	}
	
	public int seller_prod_stockUpdate(Seller_Prod_StockTestDTO seller_prod_stock) {
		return seller_prod_stockDAO.seller_prod_stockUpdate(seller_prod_stock);
	}
	
	public int seller_prod_stockDelete(String stock_id) {
		return seller_prod_stockDAO.seller_prod_stockDelete(stock_id);
	}
}