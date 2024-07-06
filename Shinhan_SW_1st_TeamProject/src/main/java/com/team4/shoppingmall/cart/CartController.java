package com.team4.shoppingmall.cart;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team4.shoppingmall.member.MemberDTO;

@Controller
@RequestMapping("/cart")
public class CartController {
	
	@Autowired
	CartService cartService;
	
	
	@GetMapping("/cart.do")
	public String cartPage(HttpSession session, Model model) {
		
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		String member_id = member.getMember_id();
				
		//1.구매 상품 장바구니
		List<CartDTO> sellStockCartList = cartService.selectSellStockByMemberId(member_id);
		model.addAttribute("sellStockCartList", sellStockCartList);
		System.out.println("sellStockCartList=" + sellStockCartList);
		//2.대여 상품 장바구니
		List<CartDTO> rentStockCartList =cartService.selectRentStockByMemberId(member_id);
		model.addAttribute("rentStockCartList", rentStockCartList);
		System.out.println("rentStockCartList=" + rentStockCartList);
		
		//장바구니 상품 정보 모두 조회
		List<Map<String,Object>> cartProdInfoList = cartService.selectCartProdInfo(member_id);
		model.addAttribute("cartProdInfoList", cartProdInfoList);
		
		//총 가격 계산하기 (수량*price)
		
		return "cart/cart";
	}
	
}
