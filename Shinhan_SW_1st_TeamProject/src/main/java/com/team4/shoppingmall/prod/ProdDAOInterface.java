package com.team4.shoppingmall.prod;

import java.util.List;
import java.util.Map;

public interface ProdDAOInterface {
	public ProdDTO selectByProdId(String prod_id);
	
	public List<ProdDTO> selectByMemberId(String member_id);
	
	public List<ProdDTO> selectAll();
	
	public int prodInsert(ProdDTO prod);
	
	public int prodUpdate(ProdDTO prod);
	
	public int prodDelete(Integer prod_id);

	public int prodModify(ProdDTO prod);

	public List<Map<String, Object>> selectAll2();

	public List<Map<String, Object>> selectByCategory(int categoryId);
	
	public List<SellerProdDTO> sellerByProd(String member_id);
	
	public List<Map<String, Object>> sellerProdRank();
	
	public List<SellerProdDTO> allProd();
	
	public List<SellerProdDTO> searchSellerByProd(String searchType);
}