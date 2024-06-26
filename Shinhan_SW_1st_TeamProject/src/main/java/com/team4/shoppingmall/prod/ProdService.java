package com.team4.shoppingmall.prod;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProdService {
	
	@Autowired
	ProdDAOInterface prodDAO;
	
	public ProdDTO selectByProdId(Integer prod_id) {
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
}