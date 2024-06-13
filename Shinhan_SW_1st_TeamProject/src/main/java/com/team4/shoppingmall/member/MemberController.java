package com.team4.shoppingmall.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member_test")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@GetMapping("/member_test.do")
	public void detailTest(Model model, String member_id) {
		model.addAttribute("memberVO", memberService.selectById(member_id));
	}
	
	@GetMapping("/member_button.do")
	public void defaultpage() {
		
	}
}
