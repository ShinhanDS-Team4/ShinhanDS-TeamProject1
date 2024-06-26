package com.team4.shoppingmall.rent_prod_stock;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team4.shoppingmall.coupon.CouponDTO;

@Repository
public class RentProdStockDAOMybatis implements RentProdStockDAOInterface {

	@Autowired
	SqlSession sqlSession;

	String namespace = "com.saren.rent_prod_stock.";

	// 대여상품상세
	@Override
	public RentProdStockDTO selectById(String r_stock_id) {
		return sqlSession.selectOne(namespace + "selectById", r_stock_id);
	}
	
	@Override
	public Integer findMaxStockNumber(String prod_id) {
		return sqlSession.selectOne(namespace+"findMaxStockNumber",prod_id);
	}
	
	@Override
	public List<RentProdStockListDTO> findRentStockList(String member_id) {
		System.out.println("mybatis 정상 수행됨");
		return sqlSession.selectList(namespace+"findRentStockList", member_id);
	}

	// 대여상품목록
	@Override
	public List<RentProdStockDTO> selectAll() {
		return sqlSession.selectList(namespace + "selectById");
	}

	// 대여상품등록
	@Override
	public int rentProdInsert(RentProdStockDTO rentprod) {
		return sqlSession.insert(namespace + "rentProdInsert", rentprod);
	}

	// 대여상품수정
	@Override
	public int rentProdUpdate(RentProdStockDTO rentprod) {
		return sqlSession.update(namespace + "rentProdUpdate", rentprod);
	}

	// 대여상품삭제
	@Override
	public int rentProdDelete(String r_stock_id) {
		return sqlSession.delete(namespace + "selectById", r_stock_id);
	}

}
