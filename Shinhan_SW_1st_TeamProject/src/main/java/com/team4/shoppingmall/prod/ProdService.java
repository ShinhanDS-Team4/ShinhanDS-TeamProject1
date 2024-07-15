package com.team4.shoppingmall.prod;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProdService {
	
	@Autowired
	ProdDAOInterface prodDAO;
	
	public ProdDTO selectByProdId(String prod_id) {
		return prodDAO.selectByProdId(prod_id);
	}
	
	public List<ProdDTO> selectByMemberId(String member_id) {
		return prodDAO.selectByMemberId(member_id);
	}
	
	public List<ProdDTO> selectAll() {
		return prodDAO.selectAll();
	}
	
	public int prodInsert(ProdDTO prod) {
		return prodDAO.prodInsert(prod);
	}
	
	public int prodUpdate(ProdDTO prod) {
		return prodDAO.prodUpdate(prod);
	}
	
	public int prodDelete(Integer rental_code) {
		return prodDAO.prodDelete(rental_code);
	}

	public List<Map<String, Object>> selectAll2() {
		return prodDAO.selectAll2(); 
	}

	public List<Map<String, Object>> selectByCategory(int categoryId) {
		return prodDAO.selectByCategory(categoryId); 
	}
	
	public int prodModify(ProdDTO prod) {
		return prodDAO.prodModify(prod);
	}
	
	public List<SellerProdDTO> sellerByProd(String member_id) {
		return prodDAO.sellerByProd(member_id);
	}
	
	public List<Map<String, Object>> sellerProdRank() {
		return prodDAO.sellerProdRank();
	}
	
	public List<SellerProdDTO> allProd() {
		return prodDAO.allProd();
	}
	
	public List<SellerProdDTO> searchSellerByProd(String searchType) {
		return prodDAO.searchSellerByProd(searchType);
	}
}