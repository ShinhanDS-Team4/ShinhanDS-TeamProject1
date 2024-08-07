package com.team4.shoppingmall.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team4.shoppingmall.customer.CustomerDAOInterface;
import com.team4.shoppingmall.customer.CustomerDTO;
import com.team4.shoppingmall.prod.SellerProdDTO;

@Service
public class MemberService {
	
	@Autowired
	MemberDAOInterface memberDAO;
	@Autowired
	CustomerDAOInterface customerDAO;
	
	//구매자 회원 정보 수정
	public int myInfoUpdate(MemberDTO member) {
		return memberDAO.myInfoUpdate(member);
	};
	//로그인 회원 정보 수정용 비밀번호 체크
	public MemberDTO memberCheckByPw(MemberDTO member) {
		return memberDAO.memberCheckByPw(member);
	}
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
	
	public int memberBuyerInsert(MemberDTO member) {	
		CustomerDTO customer = new CustomerDTO();
		customer.setMember_id(member.getMember_id());
		customer.setMember_level("FAMILY");
		customer.setPoint(0);
		customer.setAccum_amount(0);
		return memberDAO.memberInsert(member) + customerDAO.customerInsert(customer);
	}
	
	public int memberSellerInsert(MemberDTO member) {
		return memberDAO.memberInsert(member);
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
	
	public int memberUpdateAccess(MemberDTO member) {
		return memberDAO.memberUpdateAccess(member);
	} 
  
	public MemberDTO memberCheckByPw2(MemberDTO member) {
		return memberDAO.memberCheckByPw2(member); 
	}  
	
	public int seller_authority_access_deny(String member_id, String seller_authority) {
		return memberDAO.seller_authority_access_deny(member_id, seller_authority);
	} 

	public List<MemberDTO> selectBySeller_access(String searchSeller) {
		return memberDAO.selectBySeller_access(searchSeller);
	}
	
	public List<MemberCustomerDTO> selectByAllCustomer() {
		return memberDAO.selectByAllCustomer();
	}
	
	public List<MemberCustomerDTO> searchByCustomer(String searchCustomer) {
		return memberDAO.searchByCustomer(searchCustomer);
	}
	
	public MemberCustomerDTO customerByInfo(String member_id) {
		return memberDAO.customerByInfo(member_id);
	}
}