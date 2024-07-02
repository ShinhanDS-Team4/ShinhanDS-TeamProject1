package com.team4.shoppingmall.admin;

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

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService aService;
	
	Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@GetMapping("admin_page")
	public String productlist() {
		return "admin/admin_page";
	}
	
	@GetMapping("admin_seller_list")
	public String adminsellerlist() {
		return "admin/admin_seller_list";
	}
	
	@GetMapping("admin_seller_register")
	public String adminsellerregister() {
		return "admin/admin_seller_register";
	}
	
	@GetMapping("admin_faq")
	public String adminsellerfaq() {
		return "admin/admin_faq";
	}
	@GetMapping("admin_login")
	public void adminlogindispaly() {
		logger.debug("login요청(debug)");
		logger.info("login요청(info)");
		logger.warn("login요청(warn)");
		logger.error("login요청(error)");	
	}
	
	@GetMapping("admin_logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:admin_login";		
	}
	
	@PostMapping("admin_login")
	public String loginCheck(@RequestParam("admin_id") String admin_id, @RequestParam("admin_pw") String admin_pw, HttpSession session, HttpServletRequest request) {
		AdminDTO aDto = aService.loginChk(admin_id,admin_pw);
		System.out.println(aDto);
		if(aDto == null) {
			session.setAttribute("loginResult", "존재하지 않는 ID입니다.");
			return "redirect:admin_login";
		} else if(!aDto.getAdmin_pw().equals(admin_pw)) {
			session.setAttribute("loginResult", "존재하지 않는 PW입니다.");
			return "redirect:admin_login";
		} else {
			session.setAttribute("loginResult", "login성공");
			session.setAttribute("aDto", aDto);
			
			String lastRequest = (String)session.getAttribute("lastRequest");
			System.out.println(lastRequest);
			String goPage;
			if(lastRequest == null || lastRequest.endsWith("admin_findid") || lastRequest.endsWith("admin_findpw")) {
				goPage = "admin_page";
			} else {
				int length = request.getContextPath().length();
				goPage = lastRequest.substring(length);
				String queryString = (String)session.getAttribute("queryString");
				if(queryString != null) goPage = goPage + "?" + queryString;
			}
			return "redirect:" + goPage;
		}
	}
	
	@GetMapping("admin_findid")
	public String findIdForm() {
		return "admin/admin_findid";		
	}
	
	@PostMapping("admin_findid")
	public String findId(@RequestParam("admin_email") String admin_email, @RequestParam("admin_name") String admin_name, Model model) {
		String admin_id = aService.findById(admin_email, admin_name);
		
		if(admin_id == null) {
            model.addAttribute("findIdResult", "해당하는 이메일과 이름에 해당하는 ID가 없습니다.");
        } else {
            model.addAttribute("findIdResult", "해당 아이디는: " + admin_id + " 입니다.");
        }
		return "admin/admin_findid_result";
	}
	
	@GetMapping("admin_findpw")
	public String findPwForm() {
		return "admin/admin_findpw";		
	}
	
	@PostMapping("admin_findpw")
	public String findPw(@RequestParam("admin_id") String admin_id, @RequestParam("admin_name") String admin_name, @RequestParam("admin_phone") String admin_phone, Model model) {
		String admin_pw = aService.findByPw(admin_id, admin_name, admin_phone);
		
		if(admin_pw == null) {
            model.addAttribute("findPwResult", "해당 정보에 해당하는 아이디, 이름, 연락처가 없습니다.");
        } else {
            model.addAttribute("findPwResult", "요청하신 비밀번호는: " + admin_pw + " 입니다.");
        }
		
		return "admin/admin_findpw_result";
	}
}