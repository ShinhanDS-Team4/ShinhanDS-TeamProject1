package com.team4.shoppingmall.member;

import java.util.List;

public interface MemberDAOInterface {
	
	public MemberDTO selectById(String member_id);
	
	public List<MemberDTO> selectAll();
	
//	public List<MemberDTO> selectByCondition();
	
	public int memberInsert(MemberDTO member);
	
	public int memberUpdate(MemberDTO member);
	
	public int memberDelete(String member_id);
}
