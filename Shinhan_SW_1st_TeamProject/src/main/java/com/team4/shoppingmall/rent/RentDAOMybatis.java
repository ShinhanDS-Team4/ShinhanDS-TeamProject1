package com.team4.shoppingmall.rent;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team4.shoppingmall.rent_prod_stock.RentProdStockDTO;

@Repository
public class RentDAOMybatis implements RentDAOInterface {

	@Autowired
	SqlSession sqlSession;

	String namespace = "com.saren.rent.";

	// 대여상세
	@Override
	public RentDTO selectById(Integer rental_code) {
		return sqlSession.selectOne(namespace+"selectById", rental_code);
	}

	// 대여목록
	@Override
	public List<RentDTO> selectAll() {
		return sqlSession.selectList(namespace + "selectAll");
	}

	// 대여하기
	@Override
	public int rentInsert(RentDTO rent) {
		return sqlSession.insert(namespace+"rentInsert", rent);
	} 

	// 대여상태 수정
	@Override
	public int rentUpdate(Integer rental_code) {
		return sqlSession.update(namespace+"rentUpdate", rental_code);
	} 

	// rentlist.jsp에 출력할 상품명, 브랜드, 옵션, 상품가격, 이미지URL
	@Override
	public Map<String, Object> selectById2(int rental_code) {
		return sqlSession.selectOne(namespace+"selectById2", rental_code); 
	}
	
	// rentlist.jsp에서, 상세상품 옵션 출력시, 모든 옵션 가져오기
	@Override
	public List<RentProdStockDTO> selectOptions() {
		return sqlSession.selectList(namespace+"selectOptions"); 

    }


}
