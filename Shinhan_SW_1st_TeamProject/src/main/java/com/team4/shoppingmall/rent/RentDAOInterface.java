package com.team4.shoppingmall.rent;

import java.util.List;
import java.util.Map;

import com.team4.shoppingmall.rent_prod_stock.RentProdStockDTO;

public interface RentDAOInterface {
	
	//대여재고에 있는 상품의 대여ID 찾기
	public int searchRentId();
	// 대여상세
	public RentDTO selectById(Integer rental_code);
	
	// 대여목록
	public List<RentDTO> selectAll();
	
	// 대여하기 
	public int rentInsert(RentDTO rent);
	
	
	// 대여상태 수정
	public int rentUpdate(Integer rental_code);

	// rentlist.jsp에 출력할 대여상품 상세정보(브랜드명, 상품명, 옵션, 대여가격, 이미지URL)
	public Map<String, Object> selectById2(int rental_code);

	// rentlist.jsp에서, 상세상품 옵션 출력시, 모든 옵션 가져오기
	public List<RentProdStockDTO> selectOptions();

	// rentlist.jsp에서, 취소
	public int cancelRent(int rentalCode);

	// rentlist.jsp에서, 반납
	public int returnRent(int rentalCode);

	public int updateRent(RentDTO rent);
	
}
