package com.team4.shoppingmall.wish_list;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team4.shoppingmall.member.MemberDTO;
import com.team4.shoppingmall.member.MemberService;

@Controller
@RequestMapping("/wish")
public class Wish_ListController {
	
	@Autowired
	Wish_ListService wlService;
	@Autowired
	MemberService mService;
	
	@GetMapping("wishList.do")
	public String wishSelectAll(Model model, HttpSession session) {		
		MemberDTO mDto = (MemberDTO)session.getAttribute("customer");
		String customerId = mDto.getMember_id();
		
		model.addAttribute("wishItems", wlService.selectAll(customerId));
		return "wish/wish_list";
	}
	
	@PostMapping("wishInsert")
	@ResponseBody
	public String wishInsert(Wish_ListDTO wishInsert) {
		//int result = wish_listService.wish_listInsert(wishInsert);
		//System.out.println(result + "건 추가");
		return "wish/wishInsert";
	}
		
	@PostMapping("wishDeletet")
	public String wishDelete(Wish_ListDTO wishDelete) {
		//int result = wish_listService.wish_listDelete(wishDelete);
		//System.out.println(result + "건 삭제");
		return "wish/wishDeletet";
	}
	
}
