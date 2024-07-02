package com.team4.shoppingmall.rent;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team4.shoppingmall.rent_prod_stock.RentProdStockDTO;

@Service
public class RentService {
	
	@Autowired
	RentDAOInterface rentDAO;
	
	// 대여상세
	public RentDTO selectById(Integer rental_code) {
		return rentDAO.selectById(rental_code);
	}

	// 대여목록
	public List<RentDTO> selectAll() {
		return rentDAO.selectAll();
	}

	// 대여하기
	public int rentInsert(RentDTO rent) {
		return rentDAO.rentInsert(rent);
	}

	// 대여상태 수정
	public int rentUpdate(Integer rental_code) {
		return rentDAO.rentUpdate(rental_code);
	}

	// rentlist.jsp에 출력할 대여상품 상세정보
	public Map<String, Object> selectById2(int rental_code) { 
		return rentDAO.selectById2(rental_code);
	}

	// rentlist.jsp에서, 상세상품 옵션 출력시, 모든 옵션 가져오기
	public List<RentProdStockDTO> selectOptions() {
        return rentDAO.selectOptions();
	}

	// rentlist.jsp에서, 취소
	public int cancelRent(int rentalCode) {
        return rentDAO.cancelRent(rentalCode);
	}

	// rentlist.jsp에서, 반납
	public int returnRent(int rentalCode) {
        return rentDAO.returnRent(rentalCode);
	}
	
	public int updateRent(RentDTO rent) {
		return rentDAO.updateRent(rent);
	}

}