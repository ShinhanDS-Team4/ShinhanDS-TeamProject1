package com.team4.shoppingmall.rent;

import java.util.List;

public interface RentDAOInterface {
	
	//대여재고에 있는 상품의 대여ID 찾기
	
	// 대여상세
	public RentDTO selectById(Integer rental_code);
	
	// 대여목록
	public List<RentDTO> selectAll();
	
	// 대여하기 
	public int rentInsert(RentDTO rent);
	
	// 대여상태 수정
	public int rentUpdate(Integer rental_code);
	
}
