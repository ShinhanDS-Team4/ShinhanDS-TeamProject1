package com.team4.shoppingmall.seller_prod_stock;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Seller_Prod_StockService {
	
	@Autowired
	Seller_Prod_StockDAOInterface seller_prod_stockDAO;
	
	public Seller_Prod_StockDTO selectByStockId(Integer stock_id) {
		return seller_prod_stockDAO.selectByStockId(stock_id);
	}

	public List<Seller_Prod_StockDTO> selectByProdId(Integer prod_id) {
		return seller_prod_stockDAO.selectByProdId(prod_id);
	}
	
	public List<Seller_Prod_StockDTO> selectAll() {
		return seller_prod_stockDAO.selectAll();
	}
	
	public int seller_prod_stockInsert(Seller_Prod_StockDTO seller_prod_stock) {
		return seller_prod_stockDAO.seller_prod_stockInsert(seller_prod_stock);
	}
	
	public int seller_prod_stockUpdate(Seller_Prod_StockDTO seller_prod_stock) {
		return seller_prod_stockDAO.seller_prod_stockUpdate(seller_prod_stock);
	}
	
	public int seller_prod_stockDelete(Integer stock_id) {
		return seller_prod_stockDAO.seller_prod_stockDelete(stock_id);
	}
}