package com.team4.shoppingmall;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team4.shoppingmall.addr_list.AddrService;
import com.team4.shoppingmall.addr_list.Addr_ListDTO;
import com.team4.shoppingmall.cart.CartDTO;
import com.team4.shoppingmall.prod.ProdService;
import com.team4.shoppingmall.prod_optionTest.Prod_OptionTestService;
import com.team4.shoppingmall.seller_prod_stockTest.Seller_Prod_StockTestDTO;
import com.team4.shoppingmall.seller_prod_stockTest.Seller_Prod_StockTestService;

@Controller
@RequestMapping("/customer")
public class CustomerControllerJH {
	
	@Autowired
	AddrService addrService; //회원 주소 
	

	/*마이페이지 메인*/
	@GetMapping("/myPage.do")
	public String myPage() {
		//1.나의 주문 목록 불러오기 (목록은 1개만 보인다) 
		
		//2.나의 대여 목록 불러오기
		
		return "customer/myPage";
	}

	//나의 주문 리스트
	@GetMapping("/orderlist")
	public String orderlist() {
		
		return "customer/orderlist";
	}
	
	//나의 대여 리스트
	@GetMapping("/rentlist")
	public String rentlist() {
		//대여 목록 조회
		
		return "customer/rentlist";
	}

	
	/* 회원정보수정 */
	//step1
	@GetMapping("/myInfoUpdate.do")
	public String myInfoUpdate(Model model) {
		
		//배송지 목록 조회 테스트 중
		List<Addr_ListDTO> addrlist = addrService.selectAll();
		model.addAttribute("addrlist", addrlist);
		
		System.out.println("--나의 배송지 조회" + addrlist);
		
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
		
		//로그인 회원 비밀번호 체크(session에서 읽을 예정)
        String member_id = "testid"; //pw = 1111
        
		if(password.equals("aaa")) {
			return "customer/myInfoUpdate_step3";
		}else {
			System.out.println("마이페이지 회원 비밀번호 확인 실패");
			return "redirect:customer/myInfoUpdate_step2";
		}
		
	}
	
	//step3 - 수정할 회원 정보 입력창	
	@PostMapping("/myInfoUpdateForm.do")
	public String myInfoUpdateForm() {
		System.out.println("배송지 조회");
		
		return "customer/myPage";
	}
	
	
	/* 회원 탈퇴 */
	@GetMapping("/memberDelete.do")
	public String memberDelete() {
		
		return "customer/memberDelete";
	}
	//비밀번호 체크 후 회원 탈퇴
	@GetMapping("/memberDeletePwCheck.do")
	public String memberDeletePwCheck(@RequestParam("password") String password) {
		//로그인 회원 비밀번호 체크
		if(password.equals("aaa")) {
			return "customer/myPage";
		}else {
			System.out.println("회월 탈퇴 실패");
			return "redirect:customer/memberDelete";
		}
		
	}
	

}
