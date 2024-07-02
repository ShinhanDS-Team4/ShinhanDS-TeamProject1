package com.team4.shoppingmall.seller_prod_stockTest;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Seller_Prod_StockTestDAOMybatis implements Seller_Prod_StockTestDAOInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.seller_prod_stock.";
	
	//상품ID로 옵션별 판매 상품 재고 조회
	@Override
	public List<Seller_Prod_StockTestDTO> selectSpsOptionByProdId(String prod_id){
		return sqlSession.selectList(namespace+"selectSpsOptionByProdId", prod_id);
	}
	
	@Override
	public Seller_Prod_StockTestDTO selectByStockId(String stock_id) {
		return sqlSession.selectOne(namespace+"selectByStockId", stock_id);
	}

	@Override
	public List<Seller_Prod_StockTestDTO> selectByProdId(String prod_id) {
		return sqlSession.selectList(namespace+"selectByProdId", prod_id);
	}

	@Override
	public List<Seller_Prod_StockTestDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

	@Override
	public int seller_prod_stockInsert(Seller_Prod_StockTestDTO seller_prod_stock) {
		return sqlSession.insert(namespace+"seller_prod_stockInsert", seller_prod_stock);
	}

	@Override
	public int seller_prod_stockUpdate(Seller_Prod_StockTestDTO seller_prod_stock) {
		return sqlSession.update(namespace+"seller_prod_stockUpdate", seller_prod_stock);
	}

	@Override
	public int seller_prod_stockDelete(String stock_id) {
		return sqlSession.delete(namespace+"seller_prod_stockDelete", stock_id);
	}
}
