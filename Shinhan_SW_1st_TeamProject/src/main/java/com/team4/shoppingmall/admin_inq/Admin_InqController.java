package com.team4.shoppingmall.admin_inq;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team4.shoppingmall.member.MemberDTO;
import com.team4.shoppingmall.member.MemberService;

@Controller
@RequestMapping("/adminqna")
public class Admin_InqController {
	
	@Autowired
	MemberService memberService;
	@Autowired
	Admin_InqService admin_inqService;

	
	//나의 문의 페이지
	@GetMapping("/myqna.do")
	public String myqna(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberDTO mem = (MemberDTO)session.getAttribute("member");
		//로그인이 되지 않았을 경우 login.do로 이동. 지금은 필요 없는데 혹시나 버그 터질 일 대비해 저장함(7/9 이후 삭제하기!)
		if(mem == null) {
			return "redirect:/member_test/login.do";
		}
		String id = mem.getMember_id();
		System.out.println(mem);//�α��� �� ������ �ҷ��������� �׽�Ʈ��
		
		List<Admin_InqDTO> adminInq = admin_inqService.selectByMemberId(id);
		model.addAttribute("adminInq", adminInq);
		return "board/qa_board";
	}
	
	//���� ���� ����
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
		
		// 현재날짜로 반환
		LocalDate localDate = LocalDate.now();

		Date sqlDate = Date.valueOf(localDate);

		
		//Integer qid = 12305;
		
		Admin_InqDTO adminInq = new Admin_InqDTO();
		//adminInq.setAdmin_inq_id(qid);
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
	
	@PostMapping(value = "/updateqna.do", produces = MediaType.TEXT_HTML_VALUE + ";charset=UTF-8")
	@ResponseBody
	public String updateqna(
			@RequestParam("admin_inq_id") Integer id,
			@RequestParam("admin_inq_title") String title,
			@RequestParam("admin_inq_content") String content
			) {
        Admin_InqDTO adminInq = new Admin_InqDTO();
        adminInq.setAdmin_inq_id(id);
        adminInq.setAdmin_inq_title(title);
        adminInq.setAdmin_inq_content(content);
        
        int result = admin_inqService.admin_inqUpdate(adminInq);
        System.out.println(result);
        return "<script type='text/javascript'>alert('수정이 완료되었습니다.'); window.opener.location.reload(); window.close();</script>";
    }
	
	@GetMapping("/admin_reply.do")
	public String replyqna(Integer admin_inq_id, Model model) {
		Admin_InqDTO adminInq = admin_inqService.selectByInqId(admin_inq_id);
		System.out.println(adminInq);
		model.addAttribute("adminInq", adminInq);
		return "board/admin_InqQReplyPopup";
	}


}
