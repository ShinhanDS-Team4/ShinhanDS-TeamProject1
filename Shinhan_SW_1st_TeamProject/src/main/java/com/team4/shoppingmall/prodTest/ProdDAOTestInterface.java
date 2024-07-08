package com.team4.shoppingmall.prodTest;

import java.util.List;
import java.util.Map;

import com.team4.shoppingmall.prod.ProdDTO;

public interface ProdDAOTestInterface {
	
	//��ǰ �� ���� ��ȸ
	public Map<String,Object> selectProdDetailInfoByProdId(String prod_id);
	
	public ProdTestDTO selectByProdId(String prod_id);
	
	public List<ProdTestDTO> selectByMemberId(String member_id);
	
	public List<ProdTestDTO> selectAll();
	
	public int prodInsert(ProdTestDTO prod);
	
	public int prodUpdate(ProdTestDTO prod);
	
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
	
}