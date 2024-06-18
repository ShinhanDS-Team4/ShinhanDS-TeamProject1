package com.team4.shoppingmall.prod;

import java.util.List;

public interface ProdDAOInterface {
	public ProdDTO selectByProdId(Integer prod_id);
	
	public List<ProdDTO> selectByMemberId(String member_id);
	
	public List<ProdDTO> selectAll();
	
	public int prodInsert(ProdDTO prod);
	
	public int prodUpdate(ProdDTO prod);
	
	public int prodDelete(Integer prod_id);
}
