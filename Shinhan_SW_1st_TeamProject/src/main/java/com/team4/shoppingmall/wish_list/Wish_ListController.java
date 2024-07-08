package com.team4.shoppingmall.wish_list;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
		MemberDTO mDto = (MemberDTO)session.getAttribute("member");
		if (mDto == null) {
	        return "redirect:/member_test/login.do"; // 로그인 페이지로 리디렉션
	    }
		System.out.println(mDto);
		
		String customerId = mDto.getMember_id();
		System.out.println(customerId);
		
		model.addAttribute("wishItems", wlService.selectAll(customerId));
		return "wish/wish_list";
	}
	
	@PostMapping("wishInsert.do")
	@ResponseBody
	public String wishInsert(String prod_id, HttpSession session) {
		MemberDTO mDto = (MemberDTO)session.getAttribute("member");
		String customerId = mDto.getMember_id();
		
		System.out.println(prod_id);
		int result = wlService.selectWish(customerId, prod_id);
		System.out.println(result + "건 추가");		
		return "wish/wishInsert.do"; // 추후 상품 페이지로 이동시켜야 함
	}
		
	@PostMapping("wishDeletet.do")	
	public String wishDelete(@RequestParam("ids") List<String> prod_ids, HttpSession session) {
		MemberDTO mDto = (MemberDTO)session.getAttribute("member");
		String customerId = mDto.getMember_id();
		
		for (String prod_id : prod_ids) {
	        System.out.println(prod_id);
	        int result = wlService.selectDelete(customerId, prod_id);
	        System.out.println(result + "건 삭제");
	    }
		
		return "redirect:wish/wishList.do";
	}
}
