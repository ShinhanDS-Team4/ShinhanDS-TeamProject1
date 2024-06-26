package com.team4.shoppingmall.member;

import java.util.List;

public interface MemberDAOInterface {
	
	public MemberDTO selectById(String member_id);
	
	public MemberDTO findId(String member_name, String phone);
	
	public List<MemberDTO> selectAll();
	
	public List<MemberDTO> selectByCondition();
	
	public int memberInsert(MemberDTO member);
	
	public int memberUpdate(MemberDTO member);
	
	public int memberDelete(String member_id);

	public List<MemberDTO> selectBySeller();
  
	public List<MemberDTO> selectByCustomer();
	
	public List<MemberDTO> selectBySeller_authority();
	
	public MemberDTO selectBySeller_info(String member_id);
	
	public List<MemberDTO> searchMembers(String searchType, String keyword);
  
	public int seller_Monthly_IncreaseRate();
  
	public int customer_Monthly_IncreaseRate();
  
	public Double sellerMonthlyIncreaseRate();
  
	public Double customerMonthlyIncreaseRate();

	public MemberDTO loginChk(String member_id);

	public int updatePassword(MemberDTO member);
}

