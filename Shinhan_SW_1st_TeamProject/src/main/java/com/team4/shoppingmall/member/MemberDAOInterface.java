package com.team4.shoppingmall.member;

import java.util.List;

import org.springframework.ui.Model;

public interface MemberDAOInterface {

	//구매자 회원 정보 수정
	public int myInfoUpdate(MemberDTO member);
	//로그인 회원 정보 수정용 비밀번호 체크
	public MemberDTO memberCheckByPw(MemberDTO member);
	
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
	
	public int memberUpdateAccess(MemberDTO member);
	 
	public MemberDTO memberCheckByPw2(MemberDTO member); 
  
	public int seller_authority_access_deny(String member_id, String seller_authority);
	
	public List<MemberCustomerDTO> selectByAllCustomer();
	
	public List<MemberCustomerDTO> searchByCustomer(String searchCustomer);
	
	public MemberCustomerDTO customerByInfo(String member_id); 

}

