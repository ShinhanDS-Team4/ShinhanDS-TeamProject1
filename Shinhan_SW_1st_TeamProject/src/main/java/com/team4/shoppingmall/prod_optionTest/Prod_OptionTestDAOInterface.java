package com.team4.shoppingmall.prod_optionTest;

import java.util.List;
import java.util.Map;

public interface Prod_OptionTestDAOInterface {
	
	//옵션명과 옵션값을 함께 조회
	public List<Object> selectAllOptionsByProdId(String prod_id);

	public Prod_OptionTestDTO selectByOptionId(Integer opt_id);
	
	public List<Prod_OptionTestDTO> selectByProdId(Integer prod_id);
	
	public List<Prod_OptionTestDTO> selectAll();
	
//	public List<MemberDTO> selectByCondition();
	
	public int prod_optionInsert(Prod_OptionTestDTO prod_option);
	
	public int prod_optionUpdate(Prod_OptionTestDTO prod_option);
	
	public int prod_optionDelete(Integer opt_id);
}
