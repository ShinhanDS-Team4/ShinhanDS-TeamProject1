package com.team4.shoppingmall.rent_detail;

import java.util.List;

public interface RentDetailDAOInterface {
	
	// 대여상세 상세
	public RentDetailDTO selectById(Integer rentdetail_id);
	
	// 대여상세 목록
	public List<RentDetailDTO> selectAll();
	
	public List<RentDetailDTO> selectBySellerID(String member_id);
	
	// 대여상세 생성
	public int rentDetailInsert(RentDetailDTO rentdetail);
	
	// 대여상세 수정
	public int rentDetailUpdate(RentDetailDTO rentdetail);

	public int rentDetailStatusUpdate(RentDetailDTO rentdetail);
	
	// 대여상세 삭제
	public int rentDetailDelete(int rentdetail_id);
	
}
