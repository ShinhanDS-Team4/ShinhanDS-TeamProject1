package com.team4.shoppingmall.rent_prod_stock;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team4.shoppingmall.prod.ProductNewVO;

@Repository
public class RentProdStockDAOMybatis implements RentProdStockDAOInterface {

	@Autowired
	SqlSession sqlSession;

	String namespace = "com.saren.rent_prod_stock.";

<<<<<<< HEAD
=======
	
>>>>>>> main
	//선택 옵션 상품의 대여 재고id 찾기
	public Map<String,String> selectRentStockByProdId(String prod_id, String optionString) {
		Map<String, String> map = new HashMap<>();
		map.put("prod_id", prod_id);
		map.put("optionString", optionString);
		return sqlSession.selectOne(namespace + "selectRentStockByProdId", map);
	};
	
	//상품의 대여 재고id 조회
	public List<RentProdStockDTO> selectRentStockByProdId2(String prod_id){
		return sqlSession.selectList(namespace + "selectRentStockByProdId2", prod_id);
	};
<<<<<<< HEAD
=======
	
>>>>>>> main
	//대여 생성시 대여 수량 업데이트
	public int rentProdStockUpdate(ProductNewVO prodVO) {
		return sqlSession.update(namespace + "rentProdStockUpdate", prodVO);
	};
<<<<<<< HEAD
=======
	
>>>>>>> main
	//대여 상품 옵션별 재고 조회
	public List<RentProdStockDTO> selectRpsOptionByProdId(String prod_id){
		return sqlSession.selectList(namespace + "selectRpsOptionByProdId" , prod_id);
	};
<<<<<<< HEAD
=======
	
>>>>>>> main
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
		System.out.println("mybatis ���� �����");
		return sqlSession.selectList(namespace+"findRentStockList", member_id);
	}

<<<<<<< HEAD
=======
	// �뿩��ǰ���
>>>>>>> main
	@Override
	public List<RentProdStockDTO> selectAll() {
		return sqlSession.selectList(namespace + "selectById");
	}

<<<<<<< HEAD
=======
	// �뿩��ǰ���
>>>>>>> main
	@Override
	public int rentProdInsert(RentProdStockDTO rentprod) {
		return sqlSession.insert(namespace + "rentProdInsert", rentprod);
	}

<<<<<<< HEAD
=======
	// �뿩��ǰ����
>>>>>>> main
	@Override
	public int rentProdUpdate(RentProdStockDTO rentprod) {
		return sqlSession.update(namespace + "rentProdUpdate", rentprod);
	}
	
	// �뿩��ǰ������
	@Override
	public int rentStockUpdate(RentProdStockDTO rentprod) {
		return sqlSession.update(namespace + "rentStockUpdate", rentprod);
	}

<<<<<<< HEAD
=======
	// �뿩��ǰ����
>>>>>>> main
	@Override
	public int rentProdDelete(String r_stock_id) {
		return sqlSession.delete(namespace + "selectById", r_stock_id);
	}

}
