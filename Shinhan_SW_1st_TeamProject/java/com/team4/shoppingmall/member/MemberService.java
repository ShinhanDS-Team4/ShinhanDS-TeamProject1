package com.team4.shoppingmall.member;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team4.shoppingmall.customer.CustomerDAOInterface;
import com.team4.shoppingmall.customer.CustomerDTO;

@Service
public class MemberService {
	
	@Autowired
	MemberDAOInterface memberDAO;
	@Autowired
	CustomerDAOInterface customerDAO;
	
	public MemberDTO selectById(String member_id) {
		return memberDAO.selectById(member_id);
	}
	
	public MemberDTO findId(String member_name, String phone) {
		return memberDAO.findId(member_name, phone);
	}
	
	public List<MemberDTO> selectAll() {
		return memberDAO.selectAll();
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
	
	public int memberUpdate(MemberDTO member) {
		return memberDAO.memberUpdate(member);
	}
	
	public int memberUpdateAccess(MemberDTO member) {
		return memberDAO.memberUpdateAccess(member);
	}
	
	public int memberDelete(String member_id) {
		return memberDAO.memberDelete(member_id);
	}
	
	public MemberDTO loginChk(String member_id) {
		return memberDAO.loginChk(member_id);
	}

	public int updatePassword(MemberDTO member) {
		return memberDAO.updatePassword(member);
		
	}
	
}