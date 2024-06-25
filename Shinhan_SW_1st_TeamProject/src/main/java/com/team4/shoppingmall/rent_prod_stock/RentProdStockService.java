package com.team4.shoppingmall.rent_prod_stock;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RentProdStockService {

	@Autowired
	RentProdStockDAOInterface rentProdStockDAO;

	// 대여상품상세
	public RentProdStockDTO selectById(Integer stock_id) {
		return rentProdStockDAO.selectById(stock_id);
 	}
	
	public int findMaxStockNumber(String prod_id) {
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
	public int rentProdUpdate(Integer stock_id) {
		return rentProdStockDAO.rentProdUpdate(stock_id);
 	}

	// 대여상품삭제 
	public int rentProdDelete(Integer stock_id) {
		return rentProdStockDAO.rentProdDelete(stock_id);
 	}

}