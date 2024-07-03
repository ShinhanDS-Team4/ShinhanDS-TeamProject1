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
	
	//���� ���������� �̵�
	@GetMapping("/myqna.do")
	public String myqna(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberDTO mem = (MemberDTO)session.getAttribute("member");
		//���߿� ���͸� �ϰ����� �켱�� �ӽù������� �б��� ��������
		if(mem == null) {
			return "redirect:/member_test/login.do";
		}
		String id = mem.getMember_id();
		System.out.println(mem);//�α��� �� ������ �ҷ��������� �׽�Ʈ��
		
		List<Buyer_InqDTO> buyerInq = buyer_inqService.selectByMemberId(id);
		model.addAttribute("buyerInq" , buyerInq);
		return "board/qa_board";
	}
	
	//���� ���� ����
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
		// ���ε� ��¥
		// ���� ��¥�� LocalDate�� ������
		LocalDate localDate = LocalDate.now();

		// LocalDate�� java.sql.Date�� ��ȯ
		Date sqlDate = Date.valueOf(localDate);

		// ����ID ����
		Integer qid = 12305;
		
		Buyer_InqDTO buyerInq = new Buyer_InqDTO();
		buyerInq.setBuyer_inq_id(qid);
		buyerInq.setBuyer_inq_title(title);
		buyerInq.setBuyer_inq_content(content);
		buyerInq.setBuyer_inq_date(sqlDate);
		buyerInq.setMember_id(mid);
		buyerInq.setProd_id(prod_id);
		//null�� ó���ϴ� �ͺ��� ������ �ϱ�.
		
		int result = buyer_inqService.buyer_inqInsert(buyerInq);
		System.out.println(result);
		return "redirect:writeqna.do";
	}
}
