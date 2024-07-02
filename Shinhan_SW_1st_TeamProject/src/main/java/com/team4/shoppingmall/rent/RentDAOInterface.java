package com.team4.shoppingmall.rent;

import java.util.List;
import java.util.Map;

import com.team4.shoppingmall.rent_prod_stock.RentProdStockDTO;

public interface RentDAOInterface {
	
	//대여 신청 완료된 대여 상품 목록
	public List<Map<String,Object>> rentProductById(String member_id);
	
	public int searchRentId();
	
	public RentDTO selectById(Integer rental_code);
	
	public List<RentDTO> selectAll();
	
	public int rentInsert(RentDTO rent);
	
	public int rentUpdate(Integer rental_code);

	// rentlist.jsp
	public Map<String, Object> selectById2(int rental_code);

	// rentlist.jsp
	public List<RentProdStockDTO> selectOptions();
	
}
