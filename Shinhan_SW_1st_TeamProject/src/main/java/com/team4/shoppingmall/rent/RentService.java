package com.team4.shoppingmall.rent;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}