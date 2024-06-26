package com.team4.shoppingmall.seller_prod_stock;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Seller_Prod_StockDAOMybatis implements Seller_Prod_StockDAOInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.seller_prod_stock.";
	
	@Override
	public Seller_Prod_StockDTO selectByStockId(String s_stock_id) {
		return sqlSession.selectOne(namespace+"selectByStockId", s_stock_id);
	}

	@Override
	public List<Seller_Prod_StockDTO> selectByProdId(String prod_id) {
		return sqlSession.selectList(namespace+"selectByProdId", prod_id);
	}
	
	@Override
	public Integer findMaxStockNumber(String prod_id) {
		return sqlSession.selectOne(namespace+"findMaxStockNumber", prod_id);
	}
	
	@Override
	public List<Seller_Prod_StockListDTO> findSellStockList(String member_id){
		
		
		return sqlSession.selectList(namespace+"findSellStockList", member_id);
	}

	@Override
	public List<Seller_Prod_StockDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

	@Override
	public int seller_prod_stockInsert(Seller_Prod_StockDTO seller_prod_stock) {
		return sqlSession.insert(namespace+"seller_prod_stockInsert", seller_prod_stock);
	}

	@Override
	public int seller_prod_stockUpdate(Seller_Prod_StockDTO seller_prod_stock) {
		return sqlSession.update(namespace+"seller_prod_stockUpdate", seller_prod_stock);
	}

	@Override
	public int seller_prod_stockDelete(String s_stock_id) {
		return sqlSession.delete(namespace+"seller_prod_stockDelete", s_stock_id);
	}

	
}
