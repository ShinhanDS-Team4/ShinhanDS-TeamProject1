package com.team4.shoppingmall.prod_option;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Prod_OptionService {
	
	@Autowired
	Prod_OptionDAOInterface prod_optionDAO;
	
	public Prod_OptionDTO selectByOptionId(Integer opt_id) {
		return prod_optionDAO.selectByOptionId(opt_id);
	}

	public List<Prod_OptionDTO> selectByProdId(Integer prod_id) {
		return prod_optionDAO.selectByProdId(prod_id);
	}
	
	public int findMaxOptId(String prod_id) {
		return prod_optionDAO.findMaxOptId(prod_id);
	}
	
	public List<Prod_OptionDTO> selectAll() {
		return prod_optionDAO.selectAll();
	}
	
	public int optionInsert(Prod_OptionDTO prod_option) {
		return prod_optionDAO.prod_optionInsert(prod_option);
	}
	
	public int optionUpdate(Prod_OptionDTO prod_option) {
		return prod_optionDAO.prod_optionUpdate(prod_option);
	}
	
	public int optionDelete(Integer opt_id) {
		return prod_optionDAO.prod_optionDelete(opt_id);
	}
}