package com.team4.shoppingmall;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team4.shoppingmall.cart.CartDTO;
import com.team4.shoppingmall.cart.CartService;
import com.team4.shoppingmall.customer.CustomerService;
import com.team4.shoppingmall.member.MemberDTO;
import com.team4.shoppingmall.member.MemberService;
import com.team4.shoppingmall.order_prod.OrderProdService;
import com.team4.shoppingmall.prod_image.Prod_ImageService;
import com.team4.shoppingmall.prod_option.Prod_OptionService;
import com.team4.shoppingmall.rent.RentService;

@Controller
@RequestMapping("/customer")
public class CoordinationController {
	
	@Autowired
	CartService cartService;

	@Autowired
	MemberService memberService;

	@Autowired
	OrderProdService orderProdService;

	@Autowired
	Prod_OptionService prod_OptionService;

	@Autowired
	RentService rentService;

	@Autowired
	CustomerService customerService;
	
	@Autowired
	Prod_ImageService imageService;

	@GetMapping("/coordination.do")
	public String coordinationPage(HttpSession session, Model model) {
		//session
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		String member_id = member.getMember_id();
		
		
		//판매 장바구니 상품 정보 모두 조회
		List<Map<String,Object>> cartProdInfo = cartService.selectSellCartProdInfo(member_id);
		model.addAttribute("cartProdInfo", cartProdInfo);
		//대여 장바구니 상품 정보 모두 조회
		List<Map<String,Object>> cartRentProdInfo = cartService.selectRentCartProdInfo(member_id);
		//System.out.println("cartRentProdInfo=" + cartRentProdInfo);	
		
        
		return "customer/coordination";
	}
}