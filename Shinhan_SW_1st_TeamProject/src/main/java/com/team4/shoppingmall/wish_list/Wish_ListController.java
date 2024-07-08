package com.team4.shoppingmall.wish_list;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/wish")
public class Wish_ListController {
	
	@Autowired
	Wish_ListService wish_listService;
	
	
	@GetMapping("wishSelectAll")
	public String wishSelectAll(Model model) {
		List<Wish_ListDTO> wishList = wish_listService.selectAll();
		model.addAttribute(wishList);
		return "wish/wishSelectAll";
	}
		
	@PostMapping("wishInsert")
	@ResponseBody
	public String wishInsert(Wish_ListDTO wishInsert) {
		int result = wish_listService.wish_listInsert(wishInsert);
		System.out.println(result + "건 추가");
		return "wish/wishInsert";
	}
		
	@PostMapping("wishDeletet")
	public String wishDelete(Wish_ListDTO wishDelete) {
		int result = wish_listService.wish_listDelete(wishDelete);
		System.out.println(result + "건 삭제");
		return "wish/wishDeletet";
	}
	
}
