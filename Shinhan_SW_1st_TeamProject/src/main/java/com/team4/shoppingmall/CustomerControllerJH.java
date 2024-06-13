package com.team4.shoppingmall;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/customer")
public class CustomerControllerJH {
	
	/*헤더 메뉴 - 상품 목록 조회 */
	@GetMapping("/productlist")
	public String productlist() {
		
		return "customer/productlist";
	}
	
	/*마이페이지 메인*/
	@GetMapping("/myPage.do")
	public String myPage() {
		//1.나의 주문 목록 불러오기
		
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
	public String myInfoUpdate() {
		
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
		if(password.equals("aaa")) {
			return "customer/myInfoUpdate_step3";
		}else {
			System.out.println("마이페이지 회원 비밀번호 확인 실패");
			return "redirect:customer/myInfoUpdate_step2";
		}
		
	}
	
	//step3 - 수정할 회원 정보 입력창	
//	@PostMapping("/myInfoUpdateForm.do")
//	public String myInfoUpdateForm() {
//
//		return "";
//	}
	
	/* 회원 탈퇴 */
	@GetMapping("/memberDelete.do")
	public String memberDelete() {
		
		return "customer/memberDelete";
	}
	//비밀번호 체크 후 회원 탈퇴
	@GetMapping("/memberDeletePwCheck.do")
	public String memberDeletePwCheck(@RequestParam("password") String password) {
		if(password.equals("aaa")) {
			//System.out.println(password);
			return "customer/myPage";
		}else {
			System.out.println("회월 탈퇴 실패");
			return "redirect:customer/memberDelete";
		}
		
	}
	
}
