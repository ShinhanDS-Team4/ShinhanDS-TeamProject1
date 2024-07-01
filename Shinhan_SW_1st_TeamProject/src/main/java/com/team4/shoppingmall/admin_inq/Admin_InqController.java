package com.team4.shoppingmall.admin_inq;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team4.shoppingmall.member.MemberDTO;
import com.team4.shoppingmall.member.MemberService;
import com.team4.shoppingmall.notice.NoticeDTO;
import com.team4.shoppingmall.notice.NoticeService;

@Controller
@RequestMapping("/adminqna")
public class Admin_InqController {
	
	@Autowired
	MemberService memberService;
	@Autowired
	Admin_InqService admin_inqService;

	
	//나의 문의페이지 이동
	@GetMapping("/myqna.do")
	public String myqna(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberDTO mem = (MemberDTO)session.getAttribute("member");
		//나중에 필터링 하겠지만 우선은 임시방편으로 분기점 만들어놓음
		if(mem == null) {
			return "redirect:/member_test/login.do";
		}
		String id = mem.getMember_id();
		System.out.println(mem);//로그인 한 세션이 불러와지는지 테스트용
		
		List<Admin_InqDTO> adminInq = admin_inqService.selectByMemberId(id);
		model.addAttribute("adminInq", adminInq);
		return "board/qa_board";
	}
	
	//나의 문의 적기
	@GetMapping("/writeqna.do")
	public String writeqna() {
		return "board/admin_InqQPopup";
	}
	
	@PostMapping("/writeqna.do")
	public String writeqnapost(
			@RequestParam("member_id") String mid,
			@RequestParam("admin_inq_title") String title,
			@RequestParam("admin_inq_content") String content
			) {
		// 업로드 날짜
		// 오늘 날짜를 LocalDate로 가져옴
		LocalDate localDate = LocalDate.now();

		// LocalDate를 java.sql.Date로 변환
		Date sqlDate = Date.valueOf(localDate);

		// 문의ID 생성
		Integer qid = 12305;
		
		Admin_InqDTO adminInq = new Admin_InqDTO();
		adminInq.setAdmin_inq_id(qid);
		adminInq.setAdmin_inq_title(title);
		adminInq.setAdmin_inq_content(content);
		adminInq.setAdmin_inq_date(sqlDate);
		adminInq.setMember_id(mid);
		
		int result = admin_inqService.admin_inqInsert(adminInq);
		System.out.println(result);
		return "redirect:writeqna.do";
	}
	
	@GetMapping("/updateqna.do")
	public String updateqna(Integer admin_inq_id, Model model) {
		Admin_InqDTO adminInq = admin_inqService.selectByInqId(admin_inq_id);
		System.out.println(adminInq);
		model.addAttribute("adminInq", adminInq);
		return "board/admin_InqQPopupCheck";
	}
	


}
