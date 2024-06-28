package com.team4.shoppingmall.rent;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.team4.shoppingmall.rent_detail.RentDetailDAOInterface;
import com.team4.shoppingmall.rent_detail.RentDetailDTO;
import com.team4.shoppingmall.util.DateUtil;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RentService {

	final RentDAOInterface rentDAO;
	final RentDetailDAOInterface rentDetailDAO;

	public int searchRentId() {
		return rentDAO.searchRentId();
	}

	// 대여상세
	public RentDTO selectById(Integer rental_code) {
		return rentDAO.selectById(rental_code);
	}

	// 대여목록
	public List<RentDTO> selectAll() {
		return rentDAO.selectAll();
	}

	// 대여하기 (대여insert, 대여ID 찾기, 대여상세 insert) ->세 기능 중 하나라도 실패하면 rollback
	@Transactional
	public int rentInsert(String member_id, HashMap<String, String> map, Map<String, String> rentProductStockCheck) {

		RentDTO rent = new RentDTO();

		rent.setRent_start_date(DateUtil.getSQLDate(map.get("rent_start_date")));
		rent.setRent_end_date(DateUtil.getSQLDate(map.get("rent_end_date")));
		rent.setMember_id(member_id);
		rent.setTotal_rent_price(Integer.parseInt(map.get("total_amount"))); //총 대여가격
		
		int result = rentDAO.rentInsert(rent);
		System.out.println("rentInsert result = " + result);
		int rentId = rentDAO.searchRentId();
		
		// 3.옵션에 해당하는 상품의 대여재고ID(r_stock_id) 구하고 대여상세 생성
		String rentStockId = rentProductStockCheck.get("R_STOCK_ID");

		RentDetailDTO rentDetailDTO = new RentDetailDTO();

		//대여가격을 넣기 (총 대여가격 말고) - 수정중
		//int rentPrice = Integer.parseInt(map.get("total_amount")); 
		//int rentNum = Integer.parseInt(map.get("rent_prod_quantity"));
		//int detailPrice = rentPrice / rentNum;   //null
		
		//rentDetailDTO.setRent_product_price(detailPrice); //대여 가격 30,000들어가야하는데 null
		
		rentDetailDTO.setR_stock_id(rentStockId); // 대여재고id
		rentDetailDTO.setRent_num(Integer.parseInt(map.get("rent_prod_quantity"))); // 대여 주문 수량
		
		
		rentDetailDTO.setRental_code(rentId); // 대여id 
		result = rentDetailDAO.rentDetailInsert(rentDetailDTO);
		System.out.println("rentDetailInsert result = " + result);

		return result;
	}

	// 대여상태 수정
	public int rentUpdate(Integer rental_code) {
		return rentDAO.rentUpdate(rental_code);
	}

}