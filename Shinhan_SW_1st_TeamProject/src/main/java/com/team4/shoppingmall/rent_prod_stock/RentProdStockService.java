package com.team4.shoppingmall.rent_prod_stock;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RentProdStockService {

	@Autowired
	RentProdStockDAOInterface rentProdStockDAO;

	//선택 옵션 상품의 대여 재고id 찾기
	public RentProdStockDTO selectRentStockByProdId(String prod_id) {
		return rentProdStockDAO.selectRentStockByProdId(prod_id);
	};
	
	// 대여상품상세
	public RentProdStockDTO selectById(String r_stock_id) {
		return rentProdStockDAO.selectById(r_stock_id);
 	}
	
	public Integer findMaxStockNumber(String prod_id) {
		return rentProdStockDAO.findMaxStockNumber(prod_id);
	}
	
	public List<RentProdStockListDTO> findRentStockList(String member_id){
		System.out.println("service 정상 수행됨");
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