package com.team4.shoppingmall.wish_list;

import java.util.List;

import javax.servlet.http.HttpSession;

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
	
	public int wish_listInsert(Wish_ListDTO wish_list) {
		return wish_listDAO.wish_listInsert(wish_list);
	}
	
	public int wish_listUpdate(Wish_ListDTO wish_list) {
		return wish_listDAO.wish_listUpdate(wish_list);
	}
	
//	public int wish_listDelete1(String member_id, Integer prod_id) {
//		return wish_listDAO.wish_listDelete1(member_id, prod_id);
//	}

	public int wish_listDelete(Wish_ListDTO wishDelete) {
		return wish_listDAO.wish_listDelete(wishDelete);		
	}

	public List<Wish_ListDTO> selectAll(String memberId) {
		return wish_listDAO.selectAll(memberId);
	}
	
	public int selectWish(String customerId, String prod_id) {
		return wish_listDAO.selectWish(customerId, prod_id);
	}	
	
	public int selectDelete(String customerId, String prod_id) {
		return wish_listDAO.selectDelete(customerId, prod_id);
	}
	public int wishAllDelete(String customerId) {
		return wish_listDAO.wishAllDelete(customerId);
	}
}