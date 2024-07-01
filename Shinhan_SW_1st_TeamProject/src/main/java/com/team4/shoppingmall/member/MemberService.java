package com.team4.shoppingmall.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {
	
	@Autowired
	MemberDAOInterface memberDAO;
	
	public MemberDTO selectById(String member_id) {
		return memberDAO.selectById(member_id);
	}
	
	public MemberDTO findId(String member_name, String phone) {
		return memberDAO.findId(member_name, phone);
	}
	
	public List<MemberDTO> selectAll() {
		return memberDAO.selectAll();
	}
	
	public int memberInsert(MemberDTO member) {
		return memberDAO.memberInsert(member);
	}
	
	public int memberUpdate(MemberDTO member) {
		return memberDAO.memberUpdate(member);
	}
	
	public int memberDelete(String member_id) {
		return memberDAO.memberDelete(member_id);
	}
	

	public List<MemberDTO> selectBySeller() {
		return memberDAO.selectBySeller();
	}
	
	public List<MemberDTO> selectByCustomer() {
		return memberDAO.selectByCustomer();
	}

	public List<MemberDTO> selectBySeller_authority() {
		return memberDAO.selectBySeller_authority();
	}
	
	public MemberDTO selectBySeller_info(String member_id) {
		return memberDAO.selectBySeller_info(member_id);
	}
	
	public List<MemberDTO> searchMembers(String searchType, String keyword) {
        return memberDAO.searchMembers(searchType, keyword);
    }
	 
	public int seller_Monthly_IncreaseRate() {
		return memberDAO.seller_Monthly_IncreaseRate();
	}
	public int customer_Monthly_IncreaseRate() {
		return memberDAO.customer_Monthly_IncreaseRate();
	}
	
	public Double sellerMonthlyIncreaseRate() {
        return memberDAO.sellerMonthlyIncreaseRate();
    }
	
	public Double customerMonthlyIncreaseRate() {
		return memberDAO.customerMonthlyIncreaseRate();		
	}

	public MemberDTO loginChk(String member_id) {
		return memberDAO.loginChk(member_id);
	}

	public int updatePassword(MemberDTO member) {
		return memberDAO.updatePassword(member);
		
	}

}