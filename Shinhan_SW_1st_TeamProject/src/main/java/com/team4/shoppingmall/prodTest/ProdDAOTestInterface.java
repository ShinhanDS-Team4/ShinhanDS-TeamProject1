package com.team4.shoppingmall.prodTest;

import java.util.List;
import java.util.Map;

public interface ProdDAOTestInterface {
	

	public Map<String,Object> selectProdDetailInfoByProdId(String prod_id);
	
	public ProdTestDTO selectByProdId(String prod_id);
	
	public List<ProdTestDTO> selectByMemberId(String member_id);
	
	public List<ProdTestDTO> selectAll();
	
	public int prodInsert(ProdTestDTO prod);
	
	public int prodUpdate(ProdTestDTO prod);
	
	public int prodDelete(Integer prod_id);
}