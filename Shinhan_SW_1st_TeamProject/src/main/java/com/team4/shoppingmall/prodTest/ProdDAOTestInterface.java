package com.team4.shoppingmall.prodTest;

import java.util.List;
import java.util.Map;

import com.team4.shoppingmall.prod.ProdDTO;

public interface ProdDAOTestInterface {
	

	public Map<String,Object> selectProdDetailInfoByProdId(String prod_id);
	
	public ProdDTO selectByProdId(String prod_id);
	
	public List<ProdDTO> selectByMemberId(String member_id);
	
	public List<ProdDTO> selectAll();
	
	public int prodInsert(ProdDTO prod);
	
	public int prodUpdate(ProdDTO prod);
	
	public int prodDelete(Integer prod_id);
	
	public List<ProdDTO> selectByCtgId(Integer category_id);
	
	public List<Map<String, Object>> selectAllProdByCurCtg(Map<String, Integer> currentCtg);
	
	public List<Map<String, Object>> selectProdByLwstCtgId(Map<String, Integer> currentCtg);
	
	public int selectAllProdNumsByCurCtg(Integer category_id);
	
	public int selectProdNumsByLwstCtgId(Integer category_id);
	
	public List<String> selectBrndsByCtgId(Map<String, Integer> currentCtg);
	
	public Integer selectBrndsNumsByCtgId(Map<String, Integer> currentCtg);
	
	public List<Map<String, Object>> searchByBrndAndPrc(Map<String, Object> schInfo);
	
	public Integer searchNumsByBrndAndPrc(Map<String, Object> schInfo);
	
	public List<ProdDTO> selectAllByCtgWhenRcmd(Integer category_id);
	
}