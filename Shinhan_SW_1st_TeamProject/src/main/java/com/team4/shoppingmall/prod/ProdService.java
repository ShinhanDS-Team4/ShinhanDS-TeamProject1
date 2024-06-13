package com.team4.shoppingmall.prod;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProdService {
	
	@Autowired
	ProdDAOInterface prodDAO;
	
	public ProdDTO selectById(Integer prod_id) {
		return prodDAO.selectById(prod_id);
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
	
	public int prodDelete(Integer prod_id) {
		return prodDAO.prodDelete(prod_id);
	}
}