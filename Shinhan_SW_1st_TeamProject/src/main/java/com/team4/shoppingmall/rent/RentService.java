package com.team4.shoppingmall.rent;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.team4.shoppingmall.prod.ProductNewVO;
import com.team4.shoppingmall.rent_detail.RentDetailDAOInterface;
import com.team4.shoppingmall.rent_detail.RentDetailDTO;
import com.team4.shoppingmall.rent_prod_stock.RentProdStockDAOInterface;
import com.team4.shoppingmall.rent_prod_stock.RentProdStockDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RentService {

	final RentDAOInterface rentDAO;
	final RentDetailDAOInterface rentDetailDAO;
	
	@Autowired
	RentProdStockDAOInterface rentProdStockDAO;
	
	//대여 신청 완료된 대여 상품 목록
	public List<Map<String,Object>> rentProductById(String member_id){
		return rentDAO.rentProductById(member_id);
	};
	
	public int searchRentId() {
		return rentDAO.searchRentId();
	}
	
	public RentDTO selectById(Integer rental_code) {
		return rentDAO.selectById(rental_code);
	}

	
	public List<RentDTO> selectAll() {
		return rentDAO.selectAll();
	}
	
	@Transactional
	public int rentInsert2(ProductNewVO prodVO, String member_id) {
		
		RentDTO rent = new RentDTO();
		
		rent.setMember_id(member_id);
		rent.setRent_start_date(prodVO.getRent_start_date());
		rent.setRent_end_date(prodVO.getRent_end_date());
		rent.setTotal_rent_price(prodVO.getTotal_rent_price());
		
		//2.
		int result = rentDAO.rentInsert(rent);
		
		//insert된 id 저장
		int rental_code = rent.getRental_code();
		
		
		RentDetailDTO rentDetailDTO = new RentDetailDTO();

		rentDetailDTO.setR_stock_id(prodVO.getR_stock_id()); 
		rentDetailDTO.setRent_num(prodVO.getRent_num()); 
		rentDetailDTO.setRent_product_price(prodVO.getRent_product_price()); 
		rentDetailDTO.setRental_code(rental_code);
		//3.
		result = rentDetailDAO.rentDetailInsert(rentDetailDTO);
		
		rentProdStockDAO.rentProdStockUpdate(prodVO);
		
		return result;
	};

	
	public int rentUpdate(Integer rental_code) {
		return rentDAO.rentUpdate(rental_code);
	}

	public Map<String, Object> selectById2(int rental_code) { 
		return rentDAO.selectById2(rental_code);
	}

	public List<RentProdStockDTO> selectOptions() {
        return rentDAO.selectOptions();
	}

}