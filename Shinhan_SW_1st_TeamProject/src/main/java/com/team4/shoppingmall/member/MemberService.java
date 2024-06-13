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
}