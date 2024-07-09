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
	

	// 대여상세
	public RentDTO selectById(Integer rental_code) {
		return rentDAO.selectById(rental_code);
	}


	// 대여목록
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
		
		return rental_code;

	};

	// 대여상태 수정
	public int rentUpdate(Integer rental_code) {
		return rentDAO.rentUpdate(rental_code);
	}


//	public Map<String, Object> selectById2(int rental_code) { 
//		return rentDAO.selectById2(rental_code);
//	}
//

	// rentlist.jsp�� ����� �뿩��ǰ ������
	public List<RentSelectDTO> selectById2(int rental_code) { 
		return rentDAO.selectById2(rental_code);
	}

	// rentlist.jsp����, �󼼻�ǰ �ɼ� ��½�, ��� �ɼ� ��������
	public List<RentProdStockDTO> selectOptions() {
        return rentDAO.selectOptions();
	}

	// rentlist.jsp����, ���
	public int cancelRent(int rentalCode) {
        return rentDAO.cancelRent(rentalCode);
	}

	// rentlist.jsp����, �ݳ�
	public int returnRent(int rentalCode) {
        return rentDAO.returnRent(rentalCode);
	}
	
	public int updateRent(RentDTO rent) {
		return rentDAO.updateRent(rent);
	}
	
	public int rentprodDelete(int rental_code) {
		return rentDAO.rentprodDelete(rental_code);
	}

	public List<SellerRentDTO> AllRent() {		
		return rentDAO.AllRent();
	}

	public List<SellerRentDTO> searchSellerByRent(String searchType) {		  
		return rentDAO.searchSellerByRent(searchType);
	}

	public List<SellerRentDTO> searchCustomerByRent(String searchKeyword) {
		return rentDAO.searchCustomerByRent(searchKeyword);
	}

	public List<RentDTO> selectByMemId(String member_id) {
		return rentDAO.selectByMemId(member_id);
	}

}