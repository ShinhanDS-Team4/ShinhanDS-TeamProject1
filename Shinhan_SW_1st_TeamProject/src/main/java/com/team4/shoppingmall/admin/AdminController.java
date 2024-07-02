package com.team4.shoppingmall.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team4.shoppingmall.customer.CustomerService;
import com.team4.shoppingmall.member.MemberDTO;
import com.team4.shoppingmall.member.MemberService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminService aService;
	@Autowired
	MemberService mService;
	@Autowired
	CustomerService cService;
	
	Logger logger = LoggerFactory.getLogger(AdminController.class);

	// 관리자 마이 페이지 수정
	@PostMapping("admin_mypage")
	public String adminmypageedit(AdminDTO aDto) {
		System.out.println(aDto);
		return "admin/admin_mypage";
	}

	// 관리자 마이 페이지
	@GetMapping("admin_mypage")
	public String adminmypage(Model model, HttpSession session) {
		AdminDTO aDto = (AdminDTO) session.getAttribute("aDto");
		model.addAttribute("admin_name", aDto.getAdmin_name());
		model.addAttribute("admin_email", aDto.getAdmin_email());
		model.addAttribute("admin_phone", aDto.getAdmin_phone());
		model.addAttribute("admin_pw", aDto.getAdmin_pw());
		return "admin/admin_mypage";
	}

	// 관리자 메인 페이지
	@GetMapping("admin_page")
	public String adminpage(Model model, HttpSession session) {
		AdminDTO aDto = (AdminDTO) session.getAttribute("aDto");
		List<MemberDTO> sellerDto = mService.selectBySeller();
		List<MemberDTO> customerDto = mService.selectByCustomer();
		
		model.addAttribute("admin_name", aDto.getAdmin_name());
		model.addAttribute("sellers", sellerDto);
		model.addAttribute("customers", customerDto);
		
		int seller_total = sellerDto.size();
		model.addAttribute("seller_total", seller_total);
		
		int customer_total = customerDto.size();
		model.addAttribute("customer_total", customer_total);
		
		Long totalMoneyAmount = cService.TotalMoneyAmount();
		System.out.println(totalMoneyAmount);		
		model.addAttribute("total_money_amount", totalMoneyAmount);
		
		int seller_monthly_increaseRate = mService.seller_Monthly_IncreaseRate();
		model.addAttribute("seller_monthly_increaseRate", seller_monthly_increaseRate);
		int customer_monthly_increaseRate = mService.customer_Monthly_IncreaseRate();
		model.addAttribute("customer_monthly_increaseRate", customer_monthly_increaseRate);
		
		Double seller_monthly_increase_rate = mService.sellerMonthlyIncreaseRate();
        model.addAttribute("seller_monthly_increase_rate", seller_monthly_increase_rate);		             

        Double customer_monthly_increase_rate = mService.customerMonthlyIncreaseRate();
        model.addAttribute("customer_monthly_increase_rate", customer_monthly_increase_rate);		             
        
		return "admin/admin_page";
	}

	// 판매자 목록 페이지
	@GetMapping("admin_seller_list")
	public String adminsellerlist(Model model) {
		List<MemberDTO> mDto = mService.selectBySeller_authority();
		model.addAttribute("sellers", mDto);
		return "admin/admin_seller_list";
	}

	// 판매자 상품 조회 페이지
	@GetMapping("admin_seller_prod")
	public String adminsellerdetail() {
		return "admin/admin_seller_prod";
	}

	// 판매자 허용/거부 페이지
	@GetMapping("admin_seller_register")
	public String adminsellerregister(Model model) {
		List<MemberDTO> mDto = mService.selectBySeller();
		model.addAttribute("sellers", mDto);
		return "admin/admin_seller_register";
	}

	// 판매자 정보 확인 페이지
	@GetMapping("admin_seller_info")
	public String adminsellerinfo(Model model, String member_id) {
		model.addAttribute("member_info", mService.selectById(member_id));
		return "admin/admin_seller_info";
	}

	// 판매자 정보 삭제 페이지
	@GetMapping("admin_seller_delete")
	public String delete(String member_id) {
		mService.memberDelete(member_id);
		return "redirect:admin_seller_list";
	}
	
	// 검색창
	@GetMapping("search_results")
	public @ResponseBody List<MemberDTO> searchResults( String searchType,  String keyword) {
		List<MemberDTO> members = mService.searchMembers(searchType, keyword);        
        return members;
    }

	// 관리자 문의 게시판
	@GetMapping("admin_faq")
	public String adminsellerfaq() {
		return "admin/admin_faq";
	}

	// 관리자 로그인 요청 에러확인
	@GetMapping("admin_login")
	public void adminlogindispaly() {
		logger.debug("로그인 요청(debug)");
		logger.info("로그인 요청(info)");
		logger.warn("로그인 요청(warn)");
		logger.error("로그인 요청(error)");
	}

	// 관리자 로그아웃
	@GetMapping("admin_logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:admin_login";
	}

	// 관리자 로그인
	@PostMapping("admin_login")
	public String loginCheck(@RequestParam("admin_id") String admin_id, @RequestParam("admin_pw") String admin_pw,
			HttpSession session, HttpServletRequest request) {
		System.out.println(admin_id);
		AdminDTO aDto = aService.loginChk(admin_id, admin_pw);
		System.out.println(aDto);
		if (aDto == null) {
			session.setAttribute("loginResult", "존재하지 않는 ID입니다.");
			return "redirect:admin_login";
		} else if (!aDto.getAdmin_pw().equals(admin_pw)) {
			session.setAttribute("loginResult", "잘못된 비밀번호입니다.");
			return "redirect:admin_login";
		} else {
			session.setAttribute("loginResult", "로그인 성공");
			session.setAttribute("aDto", aDto);

			return "redirect:admin_page";
		}
	}

	// 아이디 찾기
	@PostMapping("admin_findid")
	public @ResponseBody String findId(String admin_email, String admin_name, Model model) {
		System.out.println(admin_email);
		System.out.println(admin_name);
		String admin_id = aService.findById(admin_email, admin_name);
		String findIdResult = "";
		if (admin_id == null) {
			findIdResult= "0";
		} else {
			findIdResult = admin_id;
	    }
		return findIdResult;
	}

	// 비밀번호 찾기
	@PostMapping("admin_findpw")
    @ResponseBody
    public String findPw(String admin_id, String admin_name, String admin_phone) {	
		System.out.println(admin_id);
		System.out.println(admin_name);
		System.out.println(admin_phone);		
        String admin_pw = aService.findByPw(admin_id, admin_name, admin_phone);
        return admin_pw != null ? admin_pw : "0";
    }
	
	// 새 비밀번호로 변경
    @PostMapping("/admin_changepw")
    @ResponseBody
    public String changePw(String admin_id, String new_admin_pw) {
    	System.out.println(admin_id);
		System.out.println(new_admin_pw);
        boolean result = aService.updateByPw(admin_id, new_admin_pw);
        return result ? "1" : "0";
    }	
}