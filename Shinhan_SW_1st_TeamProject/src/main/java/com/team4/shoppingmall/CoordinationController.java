package com.team4.shoppingmall;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
		
        
		return "customer/coordination";
	}
	
	//id 리턴 시 리턴 타입 변경하기
	@GetMapping("/recommend.do")
    public String coordination2Page(HttpSession session, 
                                    Model model
                                    //,@RequestParam("cart_id") Integer cart_id
                                    ){

		
        // session
        MemberDTO member = (MemberDTO)session.getAttribute("member");
        String member_id = member.getMember_id();
        
         //cart_id 읽어오기 (테스트용)
        Integer cart_id = 4;

        // 1. cart_id에 해당하는 상품 이름과 img_id(이미지파일이름) 조회
        Map<String,Object> prodInfoByCartId = cartService.sellCartProdByCart_id(member_id, cart_id);
        model.addAttribute("prodInfoByCartId", prodInfoByCartId);
        System.out.println("prodInfoByCartId"+ prodInfoByCartId);

        return "customer/recommend"; 
    }
	
}