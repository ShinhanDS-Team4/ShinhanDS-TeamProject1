package com.team4.shoppingmall.prod_option;

import java.util.List;

public interface Prod_OptionDAOInterface {
	
	public Prod_OptionDTO selectByOptionId(Integer opt_id);
	
	public List<Prod_OptionDTO> selectByProdId(Integer prod_id);
	
	public int findMaxOptId();
	
	public List<Prod_OptionDTO> selectAll();
	
//	public List<MemberDTO> selectByCondition();
	
	public int prod_optionInsert(Prod_OptionDTO prod_option);
	
	public int prod_optionUpdate(Prod_OptionDTO prod_option);
	
	public int prod_optionDelete(Integer opt_id);
}
