package com.team4.shoppingmall.member;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/member_test")
public class MemberController {

    @Autowired
    MemberService memberService;
    @Autowired
    private GmailService gmailService;

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
	public String login(@RequestParam("id") String member_id, @RequestParam("pw") String member_pw, HttpSession session, HttpServletRequest request) {
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
		return "redirect:../";
	}
	
	
	//회원가입
	@GetMapping("/signup.do")
	public String signup() {
		return "user/signup";
	}
	
	@PostMapping("/signup.do")
	public String sendSignup(MemberDTO member) {
		System.out.println(member);
		memberService.memberInsert(member);
		return "redirect:login.do";
	}

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

    private String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000);
        return String.valueOf(code);
    }

	@GetMapping("/phone_check.do")
	public void check() {

	}
}
