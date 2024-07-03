package com.team4.shoppingmall.rent_prod_stock;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team4.shoppingmall.prod.ProductNewVO;

@Service
public class RentProdStockService {

	@Autowired
	RentProdStockDAOInterface rentProdStockDAO;

	//선택 옵션 상품의 대여 재고id 찾기
	public Map<String,String> selectRentStockByProdId(String prod_id, String optionString) {
		return rentProdStockDAO.selectRentStockByProdId(prod_id, optionString);
	};
	//상품의 대여 재고id 조회
	public List<RentProdStockDTO> selectRentStockByProdId2(String prod_id){
		return rentProdStockDAO.selectRentStockByProdId2(prod_id);
	}
	//대여 생성시 대여 수량 업데이트
	public int rentProdStockUpdate(ProductNewVO prodVO) {
		return rentProdStockDAO.rentProdStockUpdate(prodVO);
	};
	
	//대여 상품 옵션별 재고 조회
	public List<RentProdStockDTO> selectRpsOptionByProdId(String prod_id){
		return rentProdStockDAO.selectRpsOptionByProdId(prod_id);
	};
	
	// 대여상품상세
	public RentProdStockDTO selectById(String r_stock_id) {
		return rentProdStockDAO.selectById(r_stock_id);
 	}
	
	public Integer findMaxStockNumber(String prod_id) {
		return rentProdStockDAO.findMaxStockNumber(prod_id);
	}
	
	public List<RentProdStockListDTO> findRentStockList(String member_id){
		System.out.println("service ���� �����");
		return rentProdStockDAO.findRentStockList(member_id);
	}

	// 대여상품목록 
	public List<RentProdStockDTO> selectAll() {
		return rentProdStockDAO.selectAll();	
 	}

	// 대여상품등록 
	public int rentProdInsert(RentProdStockDTO rentprod) {
		return rentProdStockDAO.rentProdInsert(rentprod);	
 	}

	// 대여상품수정 
	public int rentProdUpdate(RentProdStockDTO rentprod) {
		return rentProdStockDAO.rentProdUpdate(rentprod);
 	}

	// 대여상품삭제 
	public int rentProdDelete(String r_stock_id) {
		return rentProdStockDAO.rentProdDelete(r_stock_id);
 	}

}