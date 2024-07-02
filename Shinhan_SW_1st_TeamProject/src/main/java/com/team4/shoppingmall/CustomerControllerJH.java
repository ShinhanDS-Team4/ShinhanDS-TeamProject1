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
import com.team4.shoppingmall.member.MemberDTO;
import com.team4.shoppingmall.member.MemberService;
import com.team4.shoppingmall.order_prod.OrderProdDTO;
import com.team4.shoppingmall.order_prod.OrderProdService;
import com.team4.shoppingmall.prod_option.Prod_OptionDTO;
import com.team4.shoppingmall.prod_option.Prod_OptionService;

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
		
		// 나의 모든 주문 정보 가져오기
	    //List<OrderProdDTO> myAllOrders = orderProdService.orderProductById(member_id);
		List<Map<String,Object>> myAllOrders = orderProdService.orderProductById(member_id);
	    model.addAttribute("myAllOrders", myAllOrders);
	    System.out.println("전체 주문 목록: " + myAllOrders);

	    
	    //String prod_id = "";
	    //상품의 옵션 (opt_id에 해당하는 옵션명 화면에서 읽기)
	    //List<Prod_OptionDTO> prodOptionList = prod_OptionService.selectByProdId(prod_id);
	    //model.addAttribute("prodOptionList", prodOptionList);
	    

	 
	    
	    
		//3.대여 내역
		
		
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
		
		
		//로그인 한 회원의 주소 조회
		//List<Addr_ListDTO> addrlist = addrService.selectAll();
		//model.addAttribute("addrlist", addrlist);
		
		
		
		return "customer/myInfoUpdate";
	}
	
	//step2 - 비밀번호 확인 창
	@GetMapping("/myInfoUpdatePw.do")
	public String myInfoUpdatePw() {
		
		return "customer/myInfoUpdate_step2";
	}
	
	
	//비밀번호 체크 후 다음 스텝(step3)
	@GetMapping("/myInfoUpdatePwCheck.do")
	public String myInfoUpdatePwCheck(@RequestParam("password") String password) {
		
		//濡쒓렇�씤 �쉶�썝 鍮꾨�踰덊샇 泥댄겕(session�뿉�꽌 �씫�쓣 �삁�젙)
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
		
		return "customer/memberDelete.do";
	}
	//鍮꾨�踰덊샇 泥댄겕 �썑 �쉶�썝 �깉�눜
	@GetMapping("/memberDeletePwCheck.do")
	public String memberDeletePwCheck(@RequestParam("password") String password) {
		if(password.equals("aaa")) {
			return "customer/myPage";
		}else {
			return "redirect:customer/memberDelete.do";
		}
		
	}
	
}
