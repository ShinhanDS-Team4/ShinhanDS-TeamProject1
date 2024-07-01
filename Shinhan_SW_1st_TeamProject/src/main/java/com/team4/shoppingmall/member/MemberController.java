package com.team4.shoppingmall.member;

import java.io.IOException;
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

@Controller
@RequestMapping("/member_test")
public class MemberController {

    @Autowired
    MemberService memberService;
    @Autowired
    private GmailService gmailService;
    
    private Map<String, String> emailVerificationCodes = new HashMap<>();

	@GetMapping("/member_test.do")
	public void detailTest(Model model, String member_id) {
		model.addAttribute("memberVO", memberService.selectById(member_id));
	}

	@GetMapping("/member_button.do")
	public void defaultpage() {

	}
	//로그인
	@GetMapping("/login.do")
	public String loginstart() {
		return "user/login";
	}
	
	@PostMapping("/login.do")
	public String login(@RequestParam("member_id") String member_id, @RequestParam("member_pw") String member_pw, HttpSession session, HttpServletRequest request) {
		MemberDTO member = memberService.loginChk(member_id);
		if(member == null) {
			session.setAttribute("loginResult", "존재하지 않는 ID");
			return "redirect:login.do";
		}else if(!member.getMember_pw().equals(member_pw)) {
			session.setAttribute("loginResult", "password 오류");
			return "redirect:login.do";
		}else {
			session.setAttribute("loginResult", "로그인 성공");
			session.setAttribute("member", member);
		}
		return "redirect:/customer/myPage.do";
	}
	
    // 로그아웃
    @GetMapping("/logout.do")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 무효화
        return "redirect:/"; // 로그아웃 후 메인 페이지로 리디렉션
    }
	
	//회원가입
	@GetMapping("/signup.do")
	public String signup() {
		return "user/signup";
	}
	
	@PostMapping("/signup.do")
	public String sendSignup(MemberDTO member, Model model) {
		System.out.println(member);
		if(member.getMember_type().equals(2)) {
			model.addAttribute("model", model);
			return "redirect:/";
			//임시로 이 위치로 뒀지만 관리자 확인페이지로 이동되어야 한다.
		}
		memberService.memberInsert(member);
		return "redirect:login.do";
	}
	
	//ID찾기
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
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 요청입니다.");
		}
		System.out.println("성공");
		return member;
	}
	
	//비번찾기
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

	//이메일 인증
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
        // userId를 사용하여 필요한 로직을 처리합니다.
        // 예를 들어, 데이터베이스에서 사용자 정보를 조회할 수 있습니다.
    	MemberDTO member = memberService.selectById(userId);
    	
    	//본인인증 확인문자 발송
    	String code = generateVerificationCode();
        gmailService.sendEmail(member.email, "Verification Code", "Your verification code is " + code);
    	System.out.println(userId);
    	System.out.println(member.email);
    	System.out.println(code);
        
        // model에 userId를 추가하여 view로 전달합니다.
        model.addAttribute("userId", userId);
        model.addAttribute("email", member.email);
        model.addAttribute("verificationCode", code);
        
        // 반환할 view 이름을 지정합니다.
        return "user/findpassword_check";
    }
    
    @PostMapping("/resetpassword")
    @ResponseBody
    public boolean resetPassword(@RequestParam("userId") String userId, @RequestParam("newPassword") String newPassword) {
        try {
        	MemberDTO member = memberService.selectById(userId);
        	member.member_pw = newPassword;
            memberService.updatePassword(member);
            System.out.println("비번변경 성공");
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
            response.put("verificationCode", code); // 디버깅 목적으로 반환
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
        }
        return response;
    }
    
    //인증번호를 받는 코드
    private String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000);
        return String.valueOf(code);
    }

	@GetMapping("/phone_check.do")
	public void check() {

	}
}
