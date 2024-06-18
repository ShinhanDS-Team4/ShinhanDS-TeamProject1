package com.team4.shoppingmall.wish_list;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Wish_ListService {
	
	@Autowired
	Wish_ListDAOInterface wish_listDAO;
	
	public Wish_ListDTO selectByMemberIdAndProdId(String member_id, Integer prod_id) {
		return wish_listDAO.selectByMemberIdAndProdId(member_id, prod_id);
	}
	
	public List<Wish_ListDTO> selectByMemberId(String member_id) {
		return wish_listDAO.selectByMemberId(member_id);
	}
	
	public List<Wish_ListDTO> selectByProdId(Integer prod_id) {
		return wish_listDAO.selectByProdId(prod_id);
	}
	
	public List<Wish_ListDTO> selectAll() {
		return wish_listDAO.selectAll();
	}
	
	public int wish_listInsert(Wish_ListDTO wish_list) {
		return wish_listDAO.wish_listInsert(wish_list);
	}
	
	public int wish_listUpdate(Wish_ListDTO wish_list) {
		return wish_listDAO.wish_listUpdate(wish_list);
	}
	
	public int wish_listDelete(String member_id, Integer prod_id) {
		return wish_listDAO.wish_listDelete(member_id, prod_id);
	}
}