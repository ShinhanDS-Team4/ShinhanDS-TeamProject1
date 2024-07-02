package com.team4.shoppingmall;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team4.shoppingmall.addr_list.Addr_ListDTO;
import com.team4.shoppingmall.addr_list.Addr_ListService;
import com.team4.shoppingmall.member.MemberDTO;
import com.team4.shoppingmall.member.MemberService;

@Controller
@RequestMapping("/customer")
public class CustomerControllerJH {
	
	//@Autowired
	Addr_ListService addrService; 
	
	@Autowired
	Addr_ListService addrService; //회원 주소 
  
  @Autowired
	MemberService memberService;

	
	/*留덉씠�럹�씠吏� 硫붿씤*/
	@GetMapping("/myPage.do")
	public String myPage(HttpSession session, Model model) {
		
		//MemberDTO member =  session.getAttribute("member");
		//String member_id = member.getMember_id();
		String member_id = "testid";
		
		//1.회원정보 조회
		MemberDTO member = memberService.selectById(member_id);
		model.addAttribute("member", member);
		
		//2.주문 내역
		
		
		//3.대여 내역
		
		
		return "customer/myPage";
	}

	//�굹�쓽 二쇰Ц 由ъ뒪�듃
	@GetMapping("/orderlist")
	public String orderlist() {
		
		return "customer/orderlist";
	}
	
	//�굹�쓽 ���뿬 由ъ뒪�듃
	@GetMapping("/rentlist")
	public String rentlist() {
		//���뿬 紐⑸줉 議고쉶
		
		return "customer/rentlist";
	}

	
	/* �쉶�썝�젙蹂댁닔�젙 */
	//step1
	@GetMapping("/myInfoUpdate.do")
	public String myInfoUpdate(Model model) {
		
		//諛곗넚吏� 紐⑸줉 議고쉶 �뀒�뒪�듃 以�
		List<Addr_ListDTO> addrlist = addrService.selectAll();
		model.addAttribute("addrlist", addrlist);
		
		System.out.println("--�굹�쓽 諛곗넚吏� 議고쉶" + addrlist);
		
		return "customer/myInfoUpdate";
	}
	
	//step2 - 鍮꾨�踰덊샇 �솗�씤 李�
	@GetMapping("/myInfoUpdatePw.do")
	public String myInfoUpdatePw() {
		
		return "customer/myInfoUpdate_step2";
	}
	
	
	//鍮꾨�踰덊샇 泥댄겕 �썑 �떎�쓬 �뒪�뀦(step3)
	@GetMapping("/myInfoUpdatePwCheck.do")
	public String myInfoUpdatePwCheck(@RequestParam("password") String password) {
		
		//濡쒓렇�씤 �쉶�썝 鍮꾨�踰덊샇 泥댄겕(session�뿉�꽌 �씫�쓣 �삁�젙)
        String member_id = "testid"; //pw = 1111
        
		if(password.equals("aaa")) {
			return "customer/myInfoUpdate_step3";
		}else {
			System.out.println("留덉씠�럹�씠吏� �쉶�썝 鍮꾨�踰덊샇 �솗�씤 �떎�뙣");
			return "redirect:customer/myInfoUpdate_step2";
		}
		
	}
	
	//step3 - �닔�젙�븷 �쉶�썝 �젙蹂� �엯�젰李�	
	@PostMapping("/myInfoUpdateForm.do")
	public String myInfoUpdateForm() {
		System.out.println("諛곗넚吏� 議고쉶");
		
		return "customer/myPage";
	}
	
	
	/* �쉶�썝 �깉�눜 */
	@GetMapping("/memberDelete.do")
	public String memberDelete() {
		
		return "customer/memberDelete";
	}
	//鍮꾨�踰덊샇 泥댄겕 �썑 �쉶�썝 �깉�눜
	@GetMapping("/memberDeletePwCheck.do")
	public String memberDeletePwCheck(@RequestParam("password") String password) {
		//濡쒓렇�씤 �쉶�썝 鍮꾨�踰덊샇 泥댄겕
		if(password.equals("aaa")) {
			return "customer/myPage";
		}else {
			System.out.println("�쉶�썡 �깉�눜 �떎�뙣");
			return "redirect:customer/memberDelete";
		}
		
	}
	
}
