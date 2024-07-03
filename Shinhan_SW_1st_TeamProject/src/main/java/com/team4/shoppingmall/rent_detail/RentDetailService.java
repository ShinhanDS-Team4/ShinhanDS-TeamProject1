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
	
	// �뿩 ID�� �뿩�� ���
	public List<RentDetailDTO> selectByRental_code(int rental_code){
		return rentDetailDAO.selectByRental_code(rental_code);
	}
	
	//판매자의 대여 상세 목록 가져오기
	public List<RentDetailDTO> selectBySellerID(String member_id){
		return rentDetailDAO.selectBySellerID(member_id);
	}

	// 대여상세 생성
	public int rentDetailInsert(RentDetailDTO rentdetail) {
		return rentDetailDAO.rentDetailInsert(rentdetail);
	}
	
	// 대여상세 수정 
	public int rentDetailUpdate(RentDetailDTO rentdetail) {
		return rentDetailDAO.rentDetailUpdate(rentdetail);
	}
	
	public int rentDetailStatusUpdate(RentDetailDTO rentdetail) {
		return rentDetailDAO.rentDetailStatusUpdate(rentdetail);
	}
	
	public int rentDetailDelete(Integer rentdetail_id) {
		return rentDetailDAO.rentDetailDelete(rentdetail_id);
	}
	
	public int rentDetailDelByRentCode(Integer rental_code) {
		return rentDetailDAO.rentDetailDelByRentCode(rental_code);
	}

}