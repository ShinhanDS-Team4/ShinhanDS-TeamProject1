package com.team4.shoppingmall;

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

import com.team4.shoppingmall.addr_list.Addr_ListDTO;
import com.team4.shoppingmall.addr_list.Addr_ListService;
import com.team4.shoppingmall.buyer_inq.Buyer_InqDTO;
import com.team4.shoppingmall.buyer_inq.Buyer_InqService;
import com.team4.shoppingmall.customer.CustomerDTO;
import com.team4.shoppingmall.customer.CustomerService;
import com.team4.shoppingmall.member.MemberDTO;
import com.team4.shoppingmall.member.MemberService;
import com.team4.shoppingmall.order_prod.OrderProdService;
import com.team4.shoppingmall.prod_option.Prod_OptionService;
import com.team4.shoppingmall.rent.RentService;

@Controller
@RequestMapping("/customer")
public class CustomerControllerJH {

	@Autowired
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

	/* 마이페이지 메인 */
	@GetMapping("/myPage.do")
	public String myPage(HttpSession session, Model model) {

		
		//1.회원정보 조회
		MemberDTO member =  (MemberDTO) session.getAttribute("member");

		String member_id = member.getMember_id();

		
		//2.나의 주문 내역 (결제 완료된 주문)
	    //List<OrderProdDTO> myAllOrders = orderProdService.orderProductById(member_id);
		List<Map<String,Object>> myAllOrders = orderProdService.orderProductById(member_id);
	    model.addAttribute("myAllOrders", myAllOrders);
	    model.addAttribute("orderCount", myAllOrders.size());
	    System.out.println("전체 주문 목록: " + myAllOrders);
	    
		//3.나의 대여 내역 (대여신청완료된 주문)
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
	   

		return "customer/myPage";
	}

	// 나의 주문 페이지
	// @GetMapping("/orderlist.do")
	public String orderlist() {

		return "customer/orderlist.do";
	}

	// 나의 대여 페이지
	// @GetMapping("/rentlist.do")
	public String rentlist() {

		return "customer/rentlist.do";
	}

	/* 회원정보수정 */
	// 배송지 추가
	@PostMapping("/myAddrInsert.do")
	@ResponseBody
	public int myAddrInsert(Model model, HttpSession session, @RequestBody Map<String, String> addressData) {

		System.out.println(addressData);

		MemberDTO member =  (MemberDTO) session.getAttribute("member");
		String member_id = member.getMember_id();
		
        // 주소 처리 로직

		String zipcode = addressData.get("zipcode");
		String main_address = addressData.get("main_address");
		String detail_address = addressData.get("detail_address");
		String is_master_addr = addressData.get("is_master_addr");
		String sub_address = addressData.get("sub_address");

		System.out.println(is_master_addr); // 'Y'
		// 대표주소가 존재하는 경우
		// 배송지 목록에서 Y인 기존 모든 주소목록은 N으로 업데이트 한 후 insert진행
		// 서비스에서 트랜잭션널 처리
		Addr_ListDTO addr_list = new Addr_ListDTO();
		addr_list.setMember_id(member_id);
		addr_list.setZipcode(zipcode);
		addr_list.setMain_address(main_address);
		addr_list.setDetail_address(detail_address);
		addr_list.setIs_master_addr(is_master_addr);
		addr_list.setSub_address(sub_address);

		int result = addrService.addressInsert(addr_list);

		System.out.println(result);

		return result;

	}

	// 배송지 삭제
	@ResponseBody
	@PostMapping("/myAddrDelete.do")

	public int myAddrDelete( HttpSession session, 
							 Model model,
							 @RequestBody Map<String, String> addrData) {
		
		MemberDTO member =  (MemberDTO) session.getAttribute("member");
		String member_id = member.getMember_id();
		
		String addr_numstr = addrData.get("addr_num");
		int addr_num = Integer.parseInt(addr_numstr);
        System.out.println(addr_num);

		// 1.삭제 완료
		int result = addrService.addressDelete(addr_num);		
		
		return result ;
		
	}
	
	//대표 주소지로 업데이트
	@ResponseBody
	@PostMapping("/masterAddrUpdate.do")
	public int masterAddrUpdate( HttpSession session, 
							 Model model,
							 @RequestBody Map<String, String> addrData) {
				
		String addr_numstr = addrData.get("addr_num");
		int addr_num = Integer.parseInt(addr_numstr);
		System.out.println(addr_num);

		//기존에 Y인 주소는 N으로 업데이트
		//클릭한 addr_num의 주소 Y로 업데이트
		//서비스에서 트랜잭션널 처리
		int result = addrService.updateMasterAddrToY(addr_num);
		
	
		return result ;
	
	}

	// step1 회원정보 수정 페이지
	@GetMapping("/myInfoUpdate.do")
	public String myInfoUpdate(HttpSession session, Model model) {
 
		MemberDTO member =  (MemberDTO) session.getAttribute("member");
		String member_id = member.getMember_id();
		
		//나의 배송지 목록
		List<Map<String,Object>> addrlist = addrService.selectByMember_Id2(member_id);

		model.addAttribute("addrlist", addrlist);

		System.out.println(addrlist);

		return "customer/myInfoUpdate";
	}

	//step2 - 비밀번호 확인 창
	//jsp페이지 로드
	@GetMapping("/myInfoUpdateStep2.do")
	public String myInfoUpdatePwPage(HttpSession session, 
			 Model model){
		
		return "customer/myInfoUpdateStep2";  
	}

	// 비밀번호 체크
	@ResponseBody
	@PostMapping("/myInfoUpdatePwCheck.do")

	public int myInfoUpdatePw(HttpSession session, Model model,
							   @RequestBody Map<String,String> pwData ) 
	{
	
		MemberDTO member =  (MemberDTO) session.getAttribute("member");
		String member_id = member.getMember_id();
		//String member_id ="testid";
		
		String member_pw = pwData.get("password"); //입력 받은 pw
		//1.회원정보 조회
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setMember_id(member_id); 
		memberDTO.setMember_pw(member_pw); 
		
		MemberDTO result = memberService.memberCheckByPw(memberDTO);  
		//System.out.println(result==null?0:1);
		
		return result == null ? 0 :1 ;
	}
	
	//step3 - 정보 수정 입력창	
	@ResponseBody
	@PostMapping("/myInfoUpdateForm")
	public int myInfoUpdateForm(HttpSession session, Model model,
		 	@RequestBody Map<String,String> myInfoData) 
	{
		
		MemberDTO member =  (MemberDTO) session.getAttribute("member");
		String member_id = member.getMember_id();

		System.out.println("myInfoData: " + myInfoData);
		String member_pw = myInfoData.get("member_pw");
		String phone = myInfoData.get("phone");
		String email = myInfoData.get("email");
		
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setMember_id(member_id);
		memberDTO.setMember_pw(member_pw);
		memberDTO.setPhone(phone);
		memberDTO.setEmail(email);
		
		System.out.println(member_pw);
		
		//업데이트- 이름/비밀번호/휴대번호/이메일
		int result = memberService.myInfoUpdate(memberDTO);
		//업데이트 된 회원 정보 세션에 새로 저장

		session.setAttribute("member", member);

		return result;
	}


	/* 회원 탈퇴 */
	@GetMapping("/memberDelete.do")
	public String memberDelete() {

		return "customer/memberDelete";
	}

	@ResponseBody
	@GetMapping(value = "/memberDeletePwCheck.do", produces = "text/plain; charset=UTF-8")
	public String memberDeletePwCheck(@RequestParam("password") String password, HttpSession session) {

		// 세션의 사용자id와, 받아온 비밀번호 저장
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		System.out.println("세션에 저장된 member: " + member);
		member.setMember_pw(password); 
		System.out.println("세션의 id: " + session.getId());
		System.out.println("받아온 비밀번호: " + password);

		// 비밀번호 체크하기
		MemberDTO result = memberService.memberCheckByPw2(member); 
		System.out.println("비밀번호 맞는지: " + result);
 
		// 회원탈퇴
		if (result != null) { // result가 null이 아니면 비밀번호가 맞음
			// 실제 회원 탈퇴 로직 수행
			int deletionResult = memberService.memberDelete(member.getMember_id());
			if (deletionResult == 1) {
                session.invalidate(); // 세션 무효화 
				return "회원 탈퇴 완료"; 
			} else {
				return "회원 탈퇴 실패";
			}
		} else {
			return "패스워드를 다시 입력하세요";
		}
	}

}