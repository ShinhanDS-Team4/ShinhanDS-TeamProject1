package com.team4.shoppingmall.prod_optionTest;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Prod_OptionTestService {
	
	@Autowired
	Prod_OptionTestDAOInterface prod_optionDAO;
	
	//옵션명과 옵션값을 함께 조회
	public  List<Object> selectAllOptionsByProdId(String prod_id){
		return prod_optionDAO.selectAllOptionsByProdId(prod_id);
	};
	
	public Prod_OptionTestDTO selectByOptionId(Integer opt_id) {
		return prod_optionDAO.selectByOptionId(opt_id);
	}

	public List<Prod_OptionTestDTO> selectByProdId(Integer prod_id) {
		return prod_optionDAO.selectByProdId(prod_id);
	}
	
	public List<Prod_OptionTestDTO> selectAll() {
		return prod_optionDAO.selectAll();
	}
	
	public int memberInsert(Prod_OptionTestDTO prod_option) {
		return prod_optionDAO.prod_optionInsert(prod_option);
	}
	
	public int memberUpdate(Prod_OptionTestDTO prod_option) {
		return prod_optionDAO.prod_optionUpdate(prod_option);
	}
	
	public int memberDelete(Integer opt_id) {
		return prod_optionDAO.prod_optionDelete(opt_id);
	}
}