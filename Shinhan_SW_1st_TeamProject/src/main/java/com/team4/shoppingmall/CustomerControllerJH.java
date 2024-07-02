package com.team4.shoppingmall;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team4.shoppingmall.addr_list.Addr_ListService;
import com.team4.shoppingmall.buyer_inq.Buyer_InqDTO;
import com.team4.shoppingmall.buyer_inq.Buyer_InqService;
import com.team4.shoppingmall.customer.CustomerDTO;
import com.team4.shoppingmall.customer.CustomerService;
import com.team4.shoppingmall.member.MemberDTO;
import com.team4.shoppingmall.member.MemberService;
import com.team4.shoppingmall.order_prod.OrderProdDTO;
import com.team4.shoppingmall.order_prod.OrderProdService;
import com.team4.shoppingmall.prod_option.Prod_OptionDTO;
import com.team4.shoppingmall.prod_option.Prod_OptionService;
import com.team4.shoppingmall.rent.RentService;

@Controller
@RequestMapping("/customer")
public class CustomerControllerJH {
	
	//@Autowired
	Addr_ListService addrService; 
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	OrderProdService orderProdService;
	
	@Autowired
    Prod_OptionService prod_OptionService;
	
	@Autowired
    RentService rentService;
	
	@Autowired
	Buyer_InqService buyer_InqService;
	
	@Autowired
	CustomerService customerService;
	
	/*마이페이지 메인*/
	@GetMapping("/myPage.do")
	public String myPage(HttpSession session, Model model) {
		
		//MemberDTO member =  session.getAttribute("member");
		//String member_id = member.getMember_id();
		String member_id = "testid";

		//1.회원정보 조회
		MemberDTO member = memberService.selectById(member_id);
		model.addAttribute("member", member);
		
		//2.나의 주문 내역
	    //List<OrderProdDTO> myAllOrders = orderProdService.orderProductById(member_id);
		List<Map<String,Object>> myAllOrders = orderProdService.orderProductById(member_id);
	    model.addAttribute("myAllOrders", myAllOrders);
	    model.addAttribute("orderCount", myAllOrders.size());
	    System.out.println("전체 주문 목록: " + myAllOrders);
	    
		//3.나의 대여 내역
	    List<Map<String,Object>> myAllRentOrders = rentService.rentProductById(member_id);
	    model.addAttribute("myAllRentOrders", myAllRentOrders);
	    model.addAttribute("rentCount", myAllRentOrders.size());
	    System.out.println("전체 대여 목록: " + myAllRentOrders);
		
	    //4.나의 문의 내역
	    List<Buyer_InqDTO> myInqList =  buyer_InqService.selectByMemberId(member_id);
	    model.addAttribute("inqCount", myInqList.size());
	    
	    //5.포인트, 등급 조회
	    CustomerDTO customer =customerService.selectById(member_id);
	    model.addAttribute("myPoints", customer);
	   
	    System.out.println("myPoints--" + customer);
	 
	    
		return "customer/myPage";
	}

	//나의 주문 페이지
	//@GetMapping("/orderlist.do")
	public String orderlist() {
		
		return "customer/orderlist.do";
	}
	
	//나의 대여 페이지
	//@GetMapping("/rentlist.do")
	public String rentlist() {
		
		
		return "customer/rentlist.do";
	}

	
	/* 회원정보수정 */
	//step1
	@GetMapping("/myInfoUpdate.do")
	public String myInfoUpdate(Model model) {
		
		
		return "customer/myInfoUpdate";
	}
	
	//step2 - 비밀번호 확인 창
	@GetMapping("/myInfoUpdatePw.do")
	public String myInfoUpdatePw() {
		
		return "customer/myInfoUpdate_step2";
	}
	
	
	//비밀번호 체크 후 다음 스텝(step3)
	@GetMapping("/myInfoUpdatePwCheck.do")
	public String myInfoUpdatePwCheck(HttpSession session,
									  @RequestParam("password") String password) {
		
		//MemberDTO member =  session.getAttribute("member");
		//String member_id = member.getMember_id();
        String member_id = "testid"; //pw = 1111
        
		if(password.equals("aaa")) {
			return "customer/myInfoUpdate_step3";
		}else {
			return "redirect:customer/myInfoUpdate_step2";
		}
		
	}
	
	//step3 - 수정할 회원 정보 입력창	
	@PostMapping("/myInfoUpdateForm.do")
	public String myInfoUpdateForm() {
		
		return "customer/myPage";
	}
	
	
	/* 회원 탈퇴 */
	@GetMapping("/memberDelete.do")
	public String memberDelete() {
		
		return "customer/memberDelete";
	}

	@GetMapping("/memberDeletePwCheck.do")
	public String memberDeletePwCheck(@RequestParam("password") String password) {
		if(password.equals("aaa")) {
			return "customer/myPage";
		}else {
			return "redirect:customer/memberDelete.do";
		}
		
	}
	
}
