package com.team4.shoppingmall.prodTest;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team4.shoppingmall.prod.ProdDTO;

@Service
public class ProdTestService{
	
	@Autowired
	ProdDAOTestInterface prodDAO;
	
	public Map<String,Object> selectProdDetailInfoByProdId(String prod_id) {
		return prodDAO.selectProdDetailInfoByProdId(prod_id);
	}
	
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
	
	public int prodDelete(Integer prod_id) {
		return prodDAO.prodDelete(prod_id);
	}
	
	public List<ProdDTO> selectByCtgId(Integer category_id) {
		return prodDAO.selectByCtgId(category_id);
	}
	
	public List<Map<String, Object>> selectAllProdByCurCtg(Map<String, Integer> currentCtg) {
		return prodDAO.selectAllProdByCurCtg(currentCtg);
	}
	
	public List<Map<String, Object>> selectProdByLwstCtgId(Map<String, Integer> currentCtg) {
		return prodDAO.selectProdByLwstCtgId(currentCtg);
	}
	
	public int selectAllProdNumsByCurCtg(Integer category_id) {
		return prodDAO.selectAllProdNumsByCurCtg(category_id);
	}
	
	public int selectProdNumsByLwstCtgId(Integer category_id) {
		return prodDAO.selectProdNumsByLwstCtgId(category_id);
	}
	
	public List<String> selectBrndsByCtgId(Map<String, Integer> currentCtg) {
		return prodDAO.selectBrndsByCtgId(currentCtg);
	}
	
	public Integer selectBrndsNumsByCtgId(Map<String, Integer> currentCtg) {
		return prodDAO.selectBrndsNumsByCtgId(currentCtg);
	}
	
	public List<Map<String, Object>> searchByBrndAndPrc(Map<String, Object> schInfo) {
		return prodDAO.searchByBrndAndPrc(schInfo);
	}
	
	public Integer searchNumsByBrndAndPrc(Map<String, Object> schInfo) {
		return prodDAO.searchNumsByBrndAndPrc(schInfo);
	}
	
	public List<ProdDTO> selectAllByCtgWhenRcmd(Integer category_id) {
		return prodDAO.selectAllByCtgWhenRcmd(category_id);
	}
}