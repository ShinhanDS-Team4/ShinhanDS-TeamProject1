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
	
<<<<<<< HEAD
	// ï¿½ë¿©ï¿½ï¿½
=======
	public int searchRentId() {
		return rentDAO.searchRentId();
	}

	// ´ë¿©»ó¼¼
>>>>>>> 7c7ed3140e9942e8a524a88889d41a0dbfdbc008
	public RentDTO selectById(Integer rental_code) {
		return rentDAO.selectById(rental_code);
	}

	// ï¿½ë¿©ï¿½ï¿½ï¿½
	public List<RentDTO> selectAll() {
		return rentDAO.selectAll();
	}
	
	@Transactional
	public int rentInsert2(ProductNewVO prodVO, String member_id) {
		
		RentDTO rent = new RentDTO();
		
		rent.setMember_id(member_id);
		rent.setRent_start_date(prodVO.getRent_start_date());
		rent.setRent_end_date(prodVO.getRent_end_date());
		//rent.setRental_code(); ½ÃÄö½º
		rent.setTotal_rent_price(prodVO.getTotal_rent_price());
		
		//2.´ë¿© »ý¼º
		int result = rentDAO.rentInsert(rent);
		
		//insertÇÑ ´ë¿©ID°ª °¡Á®¿À±â
		int rental_code = rent.getRental_code();
		
		
		//2.´ë¿©»ó¼¼ »ý¼º
		RentDetailDTO rentDetailDTO = new RentDetailDTO();

<<<<<<< HEAD
	// ï¿½ë¿©ï¿½Ï±ï¿½
	public int rentInsert(RentDTO rent) {
		return rentDAO.rentInsert(rent);
	}

	// ï¿½ë¿©ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½
=======
		rentDetailDTO.setR_stock_id(prodVO.getR_stock_id()); //´ë¿©Àç°íid
		rentDetailDTO.setRent_num(prodVO.getRent_num()); // ´ë¿© ¼ö
		rentDetailDTO.setRent_product_price(prodVO.getRent_product_price()); //´ë¿©°¡°Ý
		rentDetailDTO.setRental_code(rental_code); //´ë¿©id
		
		result = rentDetailDAO.rentDetailInsert(rentDetailDTO);
		
		//3.´ë¿© Àç°í ¼ö·® ¾÷µ¥ÀÌÆ®
		rentProdStockDAO.rentProdStockUpdate(prodVO);
		
		return result;
	};

	
	// ´ë¿©»óÅÂ ¼öÁ¤
>>>>>>> 7c7ed3140e9942e8a524a88889d41a0dbfdbc008
	public int rentUpdate(Integer rental_code) {
		return rentDAO.rentUpdate(rental_code);
	}

	// rentlist.jspï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ë¿©ï¿½ï¿½Ç° ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	public List<RentSelectDTO> selectById2(int rental_code) { 
		return rentDAO.selectById2(rental_code);
	}

	// rentlist.jspï¿½ï¿½ï¿½ï¿½, ï¿½ó¼¼»ï¿½Ç° ï¿½É¼ï¿½ ï¿½ï¿½Â½ï¿½, ï¿½ï¿½ï¿½ ï¿½É¼ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	public List<RentProdStockDTO> selectOptions() {
        return rentDAO.selectOptions();
	}

	// rentlist.jspï¿½ï¿½ï¿½ï¿½, ï¿½ï¿½ï¿½
	public int cancelRent(int rentalCode) {
        return rentDAO.cancelRent(rentalCode);
	}

	// rentlist.jspï¿½ï¿½ï¿½ï¿½, ï¿½Ý³ï¿½
	public int returnRent(int rentalCode) {
        return rentDAO.returnRent(rentalCode);
	}
	
	public int updateRent(RentDTO rent) {
		return rentDAO.updateRent(rent);
	}

}