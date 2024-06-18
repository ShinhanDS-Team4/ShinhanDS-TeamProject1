package com.team4.shoppingmall.rent_detail;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RentDetailService {
	
	@Autowired
	RentDetailDAOInterface rentDetailDAO;
	
	// 대여상세 상세
	public RentDetailDTO selectById(Integer rentdetail_id) {
		return rentDetailDAO.selectById(rentdetail_id);
	}

	// 대여상세 목록
	public List<RentDetailDTO> selectAll() {
		return rentDetailDAO.selectAll();
	}

	// 대여상세 생성
	public int rentDetailInsert(RentDetailDTO rentdetail) {
		return rentDetailDAO.rentDetailInsert(rentdetail);
	}
	
	// 대여상세 수정 
	public int rentDetailUpdate(RentDetailDTO rentdetail) {
		return rentDetailDAO.rentDetailUpdate(rentdetail);
	}

}