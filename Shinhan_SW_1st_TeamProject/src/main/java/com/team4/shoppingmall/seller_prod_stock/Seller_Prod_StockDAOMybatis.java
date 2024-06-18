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
	public Seller_Prod_StockDTO selectByStockId(Integer stock_id) {
		return sqlSession.selectOne(namespace+"selectByStockId", stock_id);
	}

	@Override
	public List<Seller_Prod_StockDTO> selectByProdId(Integer prod_id) {
		return sqlSession.selectList(namespace+"selectByProdId", prod_id);
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
	public int seller_prod_stockDelete(Integer stock_id) {
		return sqlSession.delete(namespace+"seller_prod_stockDelete", stock_id);
	}
}
