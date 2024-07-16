package com.team4.shoppingmall.rent_detail;

import java.util.List;
import java.util.Map;

public interface RentDetailDAOInterface {
	
	//대여주문상품 브랜드,이름
	public List<Map<String,String>> getRentOrderProdBrand(int rental_code);
		
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
	
	// �뿩�� ����
	public int rentDetailDelete(int rentdetail_id);

	// �뿩ID�� �뿩�� ���
	public List<RentDetailDTO> selectByRental_code(int rental_code);

	public int rentDetailDelByRentCode(Integer rental_code);

	public int findMaxRentDetailID();

	public int rentDetailforCartInsert(RentDetailDTO rentdetail);
	
}