package com.team4.shoppingmall.member;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team4.shoppingmall.addr_list.Addr_ListDTO;
import com.team4.shoppingmall.addr_list.Addr_ListService;

@Controller
@RequestMapping("/member_test")
public class MemberController {

    @Autowired
    MemberService memberService;
    @Autowired
    private GmailService gmailService;
    @Autowired
    Addr_ListService addrService;
    
    private Map<String, String> emailVerificationCodes = new HashMap<>();

    
	@GetMapping("/member_test.do")
	public void detailTest(Model model, String member_id) {
		model.addAttribute("memberVO", memberService.selectById(member_id));
	}

	@GetMapping("/member_button.do")
	public void defaultpage() {

	}
	//로그인페이지
	@GetMapping("/login.do")
	public String loginstart() {
		return "user/login";
	}
	
	@PostMapping("/login.do")
	public String login(@RequestParam("member_id") String member_id, @RequestParam("member_pw") String member_pw, HttpSession session, HttpServletRequest request) {
		MemberDTO member = memberService.selectById(member_id);
		System.out.println(member);
		String N = "N";
		if(member == null) {
			session.setAttribute("loginResult", "존재하지 않는 ID");
			return "redirect:login.do";
		}else if(!member.getMember_pw().equals(member_pw)) {
			session.setAttribute("loginResult", "password 오류");
			return "redirect:login.do";
		}else if(member.seller_authority.equals(N)){
			session.setAttribute("loginResult", "관리자의 승인이 필요한 계정입니다.");
			return "redirect:login.do";
		}else {
			session.setAttribute("member", member);
			String lastRequest = (String)session.getAttribute("lastRequest");
			String goPage;
			if(lastRequest==null) {
				//첨부터 로그인창으로 들어갔다면 로그인 후 메인페이지로 이동
				goPage = "../";
			}else {
				int length = request.getContextPath().length();
				goPage = lastRequest.substring(length);
				String queryString = (String)session.getAttribute("queryString");
				if(queryString!=null) goPage = goPage+"?"+queryString;//테스트용인가?
				System.out.println("goPage =>" + goPage);
			}
			LocalDate localDate = LocalDate.now();
			Date sqlDate = Date.valueOf(localDate);
			//최종 접속일을 현재 일자로 수정
			member.setLast_access(sqlDate);
			memberService.memberUpdateAccess(member);
			
			return "redirect:" + goPage;
		}
	}
	
    //로그아웃 기능
    @GetMapping("/logout.do")
    public String logout(HttpSession session) {
        session.removeAttribute("member"); 
        return "redirect:/"; 
    }
	
	//회원가입 기능
	@GetMapping("/signup")
	public String signup() {
		return "user/signup";
	}
	
	@PostMapping("/signup")
	public String sendSignup(MemberDTO member, Addr_ListDTO addr, Model model) {
		System.out.println(member);
		System.out.println(addr);
		LocalDate localDate = LocalDate.now();
		Date sqlDate = Date.valueOf(localDate);
		member.setCreate_date(sqlDate);

		if(member.member_type == 1) {
			System.out.println(member.getMember_id());
			memberService.memberBuyerInsert(member);
		}else {
			memberService.memberSellerInsert(member);
		}
		addr.setIs_master_addr("Y");
		addrService.addressInsert(addr);

		return "redirect:login.do";
	}
	
	//ID 찾기
	@GetMapping("/findid")
	public String findid() {
		return "user/findid";
	}
	
	@PostMapping("/findid")
	@ResponseBody
	public MemberDTO findidresult(@RequestParam("name") String name, @RequestParam("phone") String phone, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
		MemberDTO member = memberService.findId(name, phone);
		System.out.println(member);
		if(!member.member_name.equals(name)) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "error.");
		}
		return member;
	}
	
	//비번 찾기
	@GetMapping("/findpassword")
	public String findpassword() {
		return "user/findpassword";
	}
	
	@PostMapping("/findpassword")
	@ResponseBody
	public MemberDTO findpasswordresult(@RequestParam("userId") String userId) {
		MemberDTO member = memberService.selectById(userId);
		System.out.println(member);
		return member;
	}

	//이메일 확인
    @GetMapping("/verify")
    public String showVerificationForm() {
        return "verify";
    }

    @PostMapping("/verify")
    public String sendVerificationCode(@RequestParam("name") String name,
                                       @RequestParam("email") String email, Model model) {
        String code = generateVerificationCode();
        try {
            gmailService.sendEmail(email, "Verification Code", "Your verification code is " + code);
            model.addAttribute("name", name);
            model.addAttribute("email", email);
            model.addAttribute("verificationCode", code);
            return "confirm";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
    
    @GetMapping("/verifypassword")
    public String verifypassword(@RequestParam("userId") String userId, Model model) {

    	MemberDTO member = memberService.selectById(userId);
    	
    	//이메일 인증
    	String code = generateVerificationCode();
        gmailService.sendEmail(member.email, "Verification Code", "Your verification code is " + code);
    	System.out.println(userId);
    	System.out.println(member.email);
    	System.out.println(code);
        
        // model�� userId�� �߰��Ͽ� view�� �����մϴ�.
        model.addAttribute("userId", userId);
        model.addAttribute("email", member.email);
        model.addAttribute("verificationCode", code);
        
        
        return "user/findpassword_check";
    }
    
    @PostMapping("/resetpassword")
    @ResponseBody
    public boolean resetPassword(@RequestParam("userId") String userId, @RequestParam("newPassword") String newPassword) {
        try {
        	MemberDTO member = memberService.selectById(userId);
        	member.member_pw = newPassword;
            memberService.updatePassword(member);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @PostMapping("/sendEmailVerification")
    @ResponseBody
    public Map<String, Object> sendEmailVerification(@RequestParam("email") String email) {
        Map<String, Object> response = new HashMap<>();
        try {
            String code = generateVerificationCode();
            gmailService.sendEmail(email, "Email Verification", "Your verification code is " + code);
            emailVerificationCodes.put(email, code);
            response.put("success", true);
            response.put("verificationCode", code);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
        }
        return response;
    }
    
    //랜덤코드 발급
    private String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000);
        return String.valueOf(code);
    }

	@GetMapping("/phone_check.do")
	public void check() {

	}
}
