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
	
//	// 이전주소 확인
//	@PostMapping("/saveLastRequest")
//	public void saveLastRequest(HttpSession session, @RequestParam("lastRequest") String lastRequest) {
//		session.setAttribute("lastRequest", lastRequest);
//	}
	
	// 로그인 페이지
	@GetMapping("/login.do")
	public String loginstart(HttpSession session) {
        String lastRequest = (String) session.getAttribute("lastRequest");
        System.out.println("Last request!!!!!: " + lastRequest); // 디버깅용 로그
	    return "user/login";
	}

	@PostMapping("/login.do") 
	public String login(@RequestParam("member_id") String member_id, @RequestParam("member_pw") String member_pw, HttpSession session, HttpServletRequest request) {
	     
		MemberDTO member = memberService.selectById(member_id);
		
	    System.out.println(member);
	    String N = "N";
	    if (member == null) {
	        session.setAttribute("loginResult", "존재하지 않는 ID");
	        return "redirect:login.do";
	    } else if (!member.getMember_pw().equals(member_pw)) {
	        session.setAttribute("loginResult", "Password 불일치");
	        return "redirect:login.do";
	    } else if (member.seller_authority.equals(N)) {
	        session.setAttribute("loginResult", "관리자의 인가를 받지 않은 판매자입니다.");
	        return "redirect:login.do";
	    } else if (member.getMember_type() == 2) {
	        session.setAttribute("member", member);
	        LocalDate localDate = LocalDate.now();
	        Date sqlDate = Date.valueOf(localDate);
	        // 로그인 날짜를 현재 날짜로 지정
	        member.setLast_access(sqlDate);
	        memberService.memberUpdateAccess(member);
	        return "redirect:/seller/PrdList.do";
	    } else {
	        session.setAttribute("member", member);
	        String lastRequest = (String) session.getAttribute("lastRequest");
	        System.out.println("Last request: " + lastRequest); // 디버깅용 로그
	        String goPage;
	        if (lastRequest == null) {
	            LocalDate localDate = LocalDate.now();
	            Date sqlDate = Date.valueOf(localDate);
	            // 로그인 날짜를 현재 날짜로 지정
	            member.setLast_access(sqlDate);
	            memberService.memberUpdateAccess(member);
	            goPage = "../";
	        } else {
	            LocalDate localDate = LocalDate.now();
	            Date sqlDate = Date.valueOf(localDate);
	            // 로그인 날짜를 현재 날짜로 지정
	            member.setLast_access(sqlDate);
	            memberService.memberUpdateAccess(member);

	            String queryString = (String) session.getAttribute("queryString");
	            if (queryString != null) {
	                goPage = lastRequest + "?" + queryString;
	            } else {
	                goPage = lastRequest;
	            }
	            System.out.println("goPage =>" + goPage);
	        }
	      //  return "redirect:" + goPage;
	        return "redirect:/";
	    }
	}

	// 로그아웃 기능
	@GetMapping("/logout.do")
	public String logout(HttpSession session) {
	    session.removeAttribute("member");
	    return "redirect:/";
	}

	//�쉶�썝媛��엯 湲곕뒫
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
		addrService.addressInsert(addr, member.getMember_id());

		return "redirect:login.do";
	}
	
	//ID 李얘린
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
	
	//鍮꾨쾲 李얘린
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

	//�씠硫붿씪 �솗�씤
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
    	
    	//�씠硫붿씪 �씤利�
    	String code = generateVerificationCode();
        gmailService.sendEmail(member.email, "Verification Code", "Your verification code is " + code);
    	System.out.println(userId);
    	System.out.println(member.email);
    	System.out.println(code);
        
        // model占쏙옙 userId占쏙옙 占쌩곤옙占싹울옙 view占쏙옙 占쏙옙占쏙옙占쌌니댐옙.
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
    
    //�옖�뜡肄붾뱶 諛쒓툒
    private String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000);
        return String.valueOf(code);
    }

	@GetMapping("/phone_check.do")
	public void check() {

	}
}