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
	public RentProdStockDTO selectById(Integer stock_id) {
		return rentProdStockDAO.selectById(stock_id);
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
	public int rentProdUpdate(Integer stock_id) {
		return rentProdStockDAO.rentProdUpdate(stock_id);
 	}

	// 대여상품삭제 
	public int rentProdDelete(Integer stock_id) {
		return rentProdStockDAO.rentProdDelete(stock_id);
 	}

}