package com.team4.shoppingmall.addr_list;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Addr_ListController {
	
	@Autowired
	AddrService addrService;
	
	/* 배송지 */
	//나의 배송지 조회
	@GetMapping("/customer/myAddrSelectAll")
	public String myAddrSelectAll(Model model, HttpServletRequest request) {
		
		//1-로그인 회원 정보
		//List<MemberDTO> memberlist = MemberService.selectAll();
		//model.addAttribute("memberlist", memberlist);
		
		//2-주소 목록
		//List<Addr_ListDTO> addrlist = addrService.selectByMember_Id(member_id);
		//model.addAttribute("addrlist", addrlist);
		
		//System.out.println("--나의 배송지 조회" + addrlist);
		
		//return "redirect:customer/myInfoUpdate";
		
		return null;
	}
	
	//배송지 추가
	@GetMapping("/customer/myAddrInsert")
	public String myAddrInsert() {
		
		System.out.println("주소 주가");
		
		return "redirect:customer/myInfoUpdate";
	}
	
	//배송지 삭제
	@GetMapping("/customer/myAddrDelete")
	public String myAddrDelete() {
		
		
		return "redirect:customer/myInfoUpdate";
	}
	
	//배송지 수정
	@GetMapping("/customer/myAddrUpdate")
	public String myAddrUpdate() {
		
		System.out.println("주소 수정");
		
		return "redirect:customer/myInfoUpdate";
	}
	
}
