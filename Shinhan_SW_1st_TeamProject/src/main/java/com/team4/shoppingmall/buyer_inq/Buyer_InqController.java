package com.team4.shoppingmall.buyer_inq;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

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

@Controller
@RequestMapping("/qna")
public class Buyer_InqController {
	
	@Autowired
	Buyer_InqService buyer_inqService;
	@Autowired
	MemberService memberService;
	
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
		
		List<Buyer_InqDTO> buyerInq = buyer_inqService.selectByMemberId(id);
		model.addAttribute("buyerInq" , buyerInq);
		return "board/qa_board";
	}
	
	//나의 문의 적기
	@GetMapping("/writeqna.do")
	public String writeqna() {
		return "board/buyer_InqQPopup";
	}
	
	@PostMapping("/writeqna.do")
	public String writeqnapost(
			@RequestParam("member_id") String mid,
			@RequestParam("seller_inq_title") String title,
			@RequestParam("seller_inq_content") String content,
			@RequestParam("prod_id") String prod_id
			) {
		// 업로드 날짜
		// 오늘 날짜를 LocalDate로 가져옴
		LocalDate localDate = LocalDate.now();

		// LocalDate를 java.sql.Date로 변환
		Date sqlDate = Date.valueOf(localDate);

		// 문의ID 생성
		Integer qid = 12305;
		
		Buyer_InqDTO buyerInq = new Buyer_InqDTO();
		buyerInq.setBuyer_inq_id(qid);
		buyerInq.setBuyer_inq_title(title);
		buyerInq.setBuyer_inq_content(content);
		buyerInq.setBuyer_inq_date(sqlDate);
		buyerInq.setMember_id(mid);
		buyerInq.setProd_id(prod_id);
		//null값 처리하는 것부터 다음에 하기.
		
		int result = buyer_inqService.buyer_inqInsert(buyerInq);
		System.out.println(result);
		return "redirect:writeqna.do";
	}
}
