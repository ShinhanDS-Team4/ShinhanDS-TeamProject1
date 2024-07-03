package com.team4.shoppingmall.rent;

import java.util.List;
import java.util.Map;

import com.team4.shoppingmall.rent_prod_stock.RentProdStockDTO;

public interface RentDAOInterface {
	
	//대여 신청 완료된 대여 상품 목록
	public List<Map<String,Object>> rentProductById(String member_id);
	
	public int searchRentId();
	
	// 대여상세
	public RentDTO selectById(Integer rental_code);
	
	// 대여목록
	public List<RentDTO> selectAll();
		
	// 대여하기
	public int rentInsert(RentDTO rent);
	
	// 대여상태 수정
	public int rentUpdate(Integer rental_code);

	// rentlist.jsp
	public Map<String, Object> selectById2(int rental_code);

	// rentlist.jsp
	public List<RentProdStockDTO> selectOptions();
	
}
