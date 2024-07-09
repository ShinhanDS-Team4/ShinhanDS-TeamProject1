package com.team4.shoppingmall.admin;

import java.sql.Date;
import java.util.List;
import java.util.Map;

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

import com.team4.shoppingmall.admin_inq.Admin_InqDTO;
import com.team4.shoppingmall.admin_inq.Admin_InqService;
import com.team4.shoppingmall.customer.CustomerService;
import com.team4.shoppingmall.event.EventDTO;
import com.team4.shoppingmall.event.EventService;
import com.team4.shoppingmall.member.MemberCustomerDTO;
import com.team4.shoppingmall.member.MemberDTO;
import com.team4.shoppingmall.member.MemberService;
import com.team4.shoppingmall.notice.NoticeDTO;
import com.team4.shoppingmall.notice.NoticeService;
import com.team4.shoppingmall.order_detail.Order_DetailService;
import com.team4.shoppingmall.prod.ProdService;
import com.team4.shoppingmall.prod.SellerProdDTO;
import com.team4.shoppingmall.rent.RentService;
import com.team4.shoppingmall.rent.SellerRentDTO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService aService;
	@Autowired
	MemberService mService;
	@Autowired
	CustomerService cService;
	@Autowired
	Order_DetailService odService;
	@Autowired
	NoticeService nService;
	@Autowired
	ProdService pService;
	@Autowired
	EventService evService;
	@Autowired
	Admin_InqService aiService;
	@Autowired
	RentService rService;
	
	Logger logger = LoggerFactory.getLogger(AdminController.class);

	// 관리자 부분
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
			findIdResult = "0";
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

	// 관리자 마이 페이지 수정
	@PostMapping("admin_mypage_edit")
	public String adminmypageedit(Model model, HttpSession session, AdminDTO aDto) {
		int result = aService.adminmypageedit(aDto);
		System.out.println(result);
		session.setAttribute("aDto", aDto);
		return "redirect:admin_mypage";
	}

	// 관리자 마이 페이지
	@GetMapping("admin_mypage")
	public String adminmypage(Model model, HttpSession session) {
		AdminDTO aDto = (AdminDTO) session.getAttribute("aDto");

		model.addAttribute("admin_id", aDto.getAdmin_id());
		model.addAttribute("admin_name", aDto.getAdmin_name());
		model.addAttribute("admin_email", aDto.getAdmin_email());
		model.addAttribute("admin_phone", aDto.getAdmin_phone());
		model.addAttribute("admin_pw", aDto.getAdmin_pw());
		return "admin/admin_mypage";
	}

	// 관리자 메인 페이지
	@GetMapping("admin_page")
	public String adminpage(Model model, HttpSession session, HttpServletRequest request) {
		AdminDTO aDto = (AdminDTO) session.getAttribute("aDto");		
		List<MemberDTO> sellerDto = mService.selectBySeller_authority();
		List<MemberDTO> customerDto = mService.selectByCustomer();
		
		model.addAttribute("admin_name", aDto.getAdmin_name());
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

		String yymm = new Date(new java.util.Date().getTime()).toString().substring(0, 7);
		System.out.println(yymm);
		
		model.addAttribute("dailyVisitorDataSeller", aService.dailyVisitorDataSeller(yymm));
		model.addAttribute("dailyVisitorDataCustomer", aService.dailyVisitorDataCustomer(yymm));
		model.addAttribute("dailyRevenueChart", aService.dailyRevenueChart(yymm));		

		int seller_monthly_increaseRate = mService.seller_Monthly_IncreaseRate();
		model.addAttribute("seller_monthly_increaseRate", seller_monthly_increaseRate);
		int customer_monthly_increaseRate = mService.customer_Monthly_IncreaseRate();
		model.addAttribute("customer_monthly_increaseRate", customer_monthly_increaseRate);
		
		Double seller_monthly_increase_rate = mService.sellerMonthlyIncreaseRate();
		model.addAttribute("seller_monthly_increase_rate", seller_monthly_increase_rate);
		Double customer_monthly_increase_rate = mService.customerMonthlyIncreaseRate();
		model.addAttribute("customer_monthly_increase_rate", customer_monthly_increase_rate);

		List<Map<String, Object>> topProdList = pService.sellerProdRank();
		System.out.println(topProdList);
		model.addAttribute("topProducts", topProdList);

		return "admin/admin_page";
	}

	// 판매자 부분	
	// 판매자 목록 페이지		
	@GetMapping("admin_seller_list")
	public String adminsellerlist(Model model) {
		List<MemberDTO> mDto = mService.selectBySeller_authority();
		model.addAttribute("sellers", mDto);
		return "admin/admin_seller_list";
	}

	// 판매자 검색		
	@GetMapping("search_seller")
	public String searchseller(Model model, String searchSeller) {
		List<MemberDTO> sellerList = mService.selectBySeller_access(searchSeller);
		System.out.println(sellerList);
		model.addAttribute("sellers", sellerList);
		return "admin/admin_seller_list_searchresult";
	}
		
	// 판매자 상품 조회 페이지
	@GetMapping("admin_seller_prod")
	public String adminsellerdetail(Model model, String member_id) {
		List<SellerProdDTO> allProdList = pService.allProd();
		System.out.println(allProdList);
		model.addAttribute("products", allProdList);

		if (member_id != null && !member_id.isEmpty()) {
	        model.addAttribute("searchType", member_id);
	        return "search_seller_product_brand";
	    }
		return "admin/admin_seller_prod";
	}

	// 판매 상품 또는 브랜드 검색
	@GetMapping("search_seller_product_brand")
	public String searchsellerproductbrand(Model model, String searchType) {
		List<SellerProdDTO> productList = pService.searchSellerByProd(searchType);
		System.out.println(productList);
		model.addAttribute("products", productList);
		return "admin/admin_seller_prod_searchresult";
	}

	// 판매자 대여 조회 페이지
	@GetMapping("admin_seller_rent")
	public String adminsellerrent(Model model, String member_id) {
		List<SellerRentDTO> allRentList = rService.AllRent();
		System.out.println(allRentList);
		model.addAttribute("rents", allRentList);
		return "admin/admin_seller_rent";
	}
	
	// 판매자 대여 상품 검색
	@GetMapping("admin_seller_rent_search")
	public String adminSellerRentSearch(Model model, String searchType) {
		List<SellerRentDTO> rentList = rService.searchSellerByRent(searchType);
		System.out.println(rentList);
		model.addAttribute("rents", rentList);
		return "admin/admin_seller_rent_search_result";
	}
	
	// 판매자 허용/거부 페이지	
	@GetMapping("admin_seller_register")
	public String adminsellerregister(Model model) {
		List<MemberDTO> mDto = mService.selectBySeller();
		model.addAttribute("sellers", mDto);
		return "admin/admin_seller_register";
	}

	// 판매자 허용/거부 업데이트
	@PostMapping("update_seller_register")
	public @ResponseBody String sellerauthorityaccessdeny(String member_id, String seller_authority) {
		int seller_authority_result = mService.seller_authority_access_deny(member_id, seller_authority);
		System.out.println(seller_authority_result);
		if (seller_authority_result > 0) {
			System.out.println("success");
			return "success";
		}
		return "failed";
	}

	// 판매자 정보 확인 페이지
	@GetMapping("admin_seller_info")
	public String adminsellerinfo(Model model, String member_id) {
		model.addAttribute("member_info", mService.selectById(member_id));
		return "admin/admin_seller_info";
	}

	// 판매자 정보 삭제 페이지
	@GetMapping("admin_seller_delete")
	public String delete(String member_id, String returnUrl) {
		mService.memberDelete(member_id);
		if (returnUrl.equals("adminPage")) {
			return "redirect:admin_page";
		}
		return "redirect:admin_seller_list";
	}

	// 판매자 상품 삭제
	@GetMapping("admin_prod_delete")
	public String proddelete(String prod_id) {
		return "admin/admin_prod_list";
	}

	
	// 고객 부분
	// 고객 목록 조회
	@GetMapping("admin_customer_list")
	public String admincustomerlist(Model model) {
		List<MemberCustomerDTO> mDto = mService.selectByAllCustomer();
		model.addAttribute("customers", mDto);
		return "admin/admin_customer_list";
	}
	
	// 고객 검색		
	@GetMapping("search_customer")
	public String searchcustomer(Model model, String searchCustomer) {
		List<MemberCustomerDTO> customerList = mService.searchByCustomer(searchCustomer);
		System.out.println(customerList);
		model.addAttribute("customers", customerList);
		return "admin/admin_customer_list_searchresult";
	}
	
	// 고객 주문 목록
	@GetMapping("admin_customer_orderlist")
	public String admincustomerorderlist() {
		return "admin/admin_customer_orderlist";
	}
	
	//고객 주문 조회
	@GetMapping("admin_customer_search_orderlist")
	public @ResponseBody List<Map<String, Object>> admincustomersearchorderlist(Model model, String searchKeyword) {
		List<Map<String, Object>> orderDetailList = odService.searchCustomerOrderList(searchKeyword);
		System.out.println(orderDetailList);		
		//model.addAttribute("orderList", orderDetailList);
		return orderDetailList;
	}
	
	// 고객 대여 목록
	@GetMapping("admin_customer_rentlist")
	public String admincustomerrentlist() {
		return "admin/admin_customer_rentlist";
	}
	
	// 고객 대여 조회
	@GetMapping("admin_customer_search_rentlist")
	public @ResponseBody List<SellerRentDTO> admincustomersearchrentlist(Model model, String searchKeyword) {
		System.out.println(searchKeyword);
		List<SellerRentDTO> rentList = rService.searchCustomerByRent(searchKeyword);
		System.out.println(rentList);		
		return rentList;
	}
	
	
	// 고객 정보 조회
	@GetMapping("admin_customer_info")
	public String admincustomerinfo(Model model, String member_id) {		
		model.addAttribute("customer_info", mService.customerByInfo(member_id));
		return "admin/admin_customer_info";
	}
		
	// 관리자 문의 게시판		
	@GetMapping("admin_faq_list")
	public String adminfaqlist(Model model) {
		List<Admin_InqDTO> allSeller = aiService.selectBySellerAll();						
		model.addAttribute("Seller", allSeller);		
		return "admin/admin_faq_list";
	}
	
	// 관리자 문의 검색
	@GetMapping("admin_faq_search")
	public String adminFaqSearch(Model model, @RequestParam String searchQuery, @RequestParam String boardType) {
	    List<Admin_InqDTO> searchFaq = aiService.searchFaq(searchQuery, boardType);	    
	    model.addAttribute("inquiries", searchFaq);	    
	    return "admin/admin_faq_search_result";
	}

	// 관리자 문의 상세
	@GetMapping("admin_faq_detail")
	@ResponseBody
	public Admin_InqDTO adminFaqDetail(@RequestParam Integer admin_inq_id) {
	    return aiService.selectByInqId(admin_inq_id);
	}

	// 관리자 문의 등록
	@PostMapping("admin_faq_insert")
	@ResponseBody
	public String adminFaqReply(Admin_InqDTO reply_update) {
		int result = aiService.admin_replyUpdate(reply_update);	    
	    System.out.println(result);
	    return "admin/admin_faq_insert";
	}
    
	@PostMapping("admin_faq_reply_update")
	@ResponseBody
	public String adminFaqUpdate(Admin_InqDTO reply_update) {
		int result = aiService.admin_replyUpdate(reply_update);
		System.out.println(result);
		return "admin/admin_faq_reply_update";
	}
	
	@PostMapping("admin_faq_reply_delete")
	@ResponseBody
	public String adminFaqDelete(@RequestParam Integer admin_inq_id) {
		int result = aiService.admin_reply_delete(admin_inq_id);
		System.out.println(result);
		return "admin/admin_faq_reply_delete";
	}
	
	// 관리자 공지 게시판
	@GetMapping("admin_notice_list")
	public String adminnoticelist(Model model) {
		model.addAttribute("notices", nService.selectAll());
		return "admin/admin_notice_list";
	}
	
	@GetMapping("admin_notice_search")
	public String adminnoticesearch(Model model, String search_notice) {
		System.out.println(search_notice);
		List<NoticeDTO> notices = nService.noticeBysearch(search_notice);
		System.out.println(notices);
		model.addAttribute("notices", notices);
		return "admin/admin_notice_search_result";
	}
	
	@GetMapping("admin_notice_detail")
	@ResponseBody
	public NoticeDTO adminnoticeselect(Model model, Integer not_id) {		
		return nService.selectById(not_id);
	}
	
	@GetMapping("admin_notice_create")
	public String adminnoticecreate(NoticeDTO nDTO) {				
		return "admin/admin_notice_insert";
	}
	
	@PostMapping("admin_notice_insert")
	@ResponseBody
	public String adminnoticeinsert(NoticeDTO nDTO) {
		int insert = nService.noticeInsert(nDTO);
	    System.out.println(insert+"성공");
	    return "admin/admin_event_insert";		
	}
	
	@PostMapping("admin_notice_update")
	@ResponseBody
	public String adminnoticeupdate(NoticeDTO nDTO) {
		int result = nService.noticeUpdate(nDTO);
		System.out.println(result+"수정 완료");		
		return "admin/admin_notice_update";
	}
	
	@PostMapping("admin_notice_delete")
	@ResponseBody
	public String adminnoticedelete(Integer not_id) {
		int result = nService.noticeDelete(not_id);
		System.out.println(result+"삭제 완료");
		return "admin/admin_notice_delete";
	}		
	
	// 관리자 이벤트 게시판
	@GetMapping("admin_event_list")
	public String admineventlist(Model model) {
		model.addAttribute("events", evService.selectAll());
		return "admin/admin_event_list";
	}
	
	@GetMapping("admin_event_search")
	public String admineventsearch(Model model, String searchEvent) {
		List<EventDTO> eDto = evService.selectBySearch(searchEvent);
		System.out.println(eDto);
		model.addAttribute("events", eDto);
		return "admin/admin_event_search_result";
	}
	
	@GetMapping("admin_event_detail")
	@ResponseBody
	public EventDTO admineventselect(Model model, @RequestParam Integer event_id) {
		return evService.selectById(event_id);
	}
	@GetMapping("admin_event_create")
	public String admineventcreate(EventDTO evDto) {
		return "admin/admin_event_insert";
	}
	
	@PostMapping("admin_event_insert")
	@ResponseBody
	public String admineventinsert(EventDTO evDto) {
		int result = evService.eventInsert(evDto);
		System.out.println(result+"성공");
		return "admin/admin_event_insert";
	}
	
	@PostMapping("admin_event_update")
	@ResponseBody
	public String admineventupdate(EventDTO evDto) {
		int result = evService.eventUpdate(evDto);
		System.out.println(result+"수정 완료");
		return "admin/admin_event_update";
	}
	
	@PostMapping("admin_event_delete")
	@ResponseBody
	public String admineventdelete(Integer event_id) {
		int result = evService.eventDelete(event_id);
		System.out.println(result + "삭제 완료");
		return "admin/admin_event_delete";
	}	
	
	// 아직 해야할 부분
	// 검색창
	@GetMapping("search_results")
	public @ResponseBody List<MemberDTO> searchResults(String searchType, String keyword) {
		List<MemberDTO> members = mService.searchMembers(searchType, keyword);
		return members;
	}
}