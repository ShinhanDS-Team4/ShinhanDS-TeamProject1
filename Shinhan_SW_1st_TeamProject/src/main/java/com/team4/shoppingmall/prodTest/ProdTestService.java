package com.team4.shoppingmall.prodTest;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProdTestService {
	
	@Autowired
	ProdDAOTestInterface prodDAO;
	
	//상품 상세 정보 조회
	public Map<String,Object> selectProdDetailInfoByProdId(String prod_id) {
		return prodDAO.selectProdDetailInfoByProdId(prod_id);
	}
	
	public ProdTestDTO selectByProdId(String prod_id) {
		return prodDAO.selectByProdId(prod_id);
	}
	
	public List<ProdTestDTO> selectByMemberId(String member_id) {
		return prodDAO.selectByMemberId(member_id);
	}
	
	public List<ProdTestDTO> selectAll() {
		return prodDAO.selectAll();
	}
	
	public int prodInsert(ProdTestDTO prod) {
		return prodDAO.prodInsert(prod);
	}
	
	public int prodUpdate(ProdTestDTO prod) {
		return prodDAO.prodUpdate(prod);
	}
	
	public int prodDelete(Integer prod_id) {
		return prodDAO.prodDelete(prod_id);
	}
}