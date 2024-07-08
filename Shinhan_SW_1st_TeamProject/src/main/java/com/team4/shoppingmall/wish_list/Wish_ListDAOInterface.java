package com.team4.shoppingmall.wish_list;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface Wish_ListDAOInterface {
	
	public Wish_ListDTO selectByMemberIdAndProdId(String member_id, Integer prod_id);
	
	public List<Wish_ListDTO> selectByMemberId(String member_id);

	public List<Wish_ListDTO> selectByProdId(Integer prod_id);
	
	public List<Wish_ListDTO> selectAll();
	
//	public List<MemberDTO> selectByCondition();
	
	public int wish_listInsert(Wish_ListDTO wish_list);
	
	public int wish_listUpdate(Wish_ListDTO wish_list);
	
	public int wish_listDelete1(String member_id, Integer prod_id);

	public int wish_listDelete(Wish_ListDTO wishDelete);
}
