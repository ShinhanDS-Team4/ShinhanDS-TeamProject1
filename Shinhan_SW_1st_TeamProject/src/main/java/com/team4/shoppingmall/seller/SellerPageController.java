package com.team4.shoppingmall.seller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.team4.shoppingmall.admin_inq.Admin_InqDTO;
import com.team4.shoppingmall.admin_inq.Admin_InqService;
import com.team4.shoppingmall.buyer_inq.Buyer_InqDAOInterface;
import com.team4.shoppingmall.buyer_inq.Buyer_InqDTO;
import com.team4.shoppingmall.buyer_inq.Buyer_InqService;
import com.team4.shoppingmall.member.MemberService;

@Controller
@RequestMapping("/seller")
public class SellerPageController {

	@Autowired
	Buyer_InqService buyer_inqService;
	
	@Autowired
	Admin_InqService admin_inqService;
	
	@Autowired
	MemberService memberService;

	// 메인 화면 보여주기
	@GetMapping("/MainPage.do")
	public String mainpage(Model model, HttpServletRequest request) {

		// 이 쪽은 솔직히 아직도 잘 모르겠다...
		String result = "";
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			result = (String) flashMap.get("deptResult");
			System.out.println("result:" + result);
		}

		// 여기서 SQL문을 사용해 model로 데이터를 끌어옴
		// 여기에는 판매자가 판매하는 상품들의 판매량 데이터를 끌어오고, 데이터를 그래프화하여 표현
		// model.addAttribute(result, flashMap);
		return "seller/sellerMain";
	}

	// 판매&대여 상품 페이지 보여주기
	@GetMapping("/PrdList.do")
	public String prdList(Model model1, Model model2, HttpServletRequest request) {

		// 판매 상품 리스트
		// model1.addAttribute("stockSList", request);

		// 대열 상품 리스트
		// model2.addAttribute("stockRList", request);

		return "/seller/sellerPrdList";
	}

	// 판매&배송 페이지 보여주기
	@GetMapping("/DeliveryList.do")
	public String deliveryList(Model model, HttpServletRequest request) {

		// 판매&배송 리스트
		// model.addAttribute("deliveryList", request);

		return "/seller/sellerDelivery";
	}

	// 문의 목록 페이지 보여주기
	@GetMapping("/Q&AList.do")
	public String qaList(Model model1, Model model2, HttpServletRequest request) {
		String member_id = "573-50-00882";// 임시로 사용할 판매자ID(사업자등록번호)
		// 구매자의 문의 목록
		System.out.println(buyer_inqService.selectInqList(member_id));
		model1.addAttribute("buyerQAList", buyer_inqService.selectInqList(member_id));
		//System.out.println(model1);
		model2.addAttribute("adminQAList", admin_inqService.selectByMemberId(member_id));
		
		return "/seller/sellerQ&dAList";
	}

	// 상품 등록 페이지
	@GetMapping("/AddProduct.do")
	public String addProduct() {
		return "/seller/seller_addPrd";
	}

	// 상품 수정 페이지
	@GetMapping("/ModifyProduct.do")
	public String modifyProduct() {
		return "/seller/seller_modifyPrd";
	}

	// 구매자문의 답변 팝업
	@GetMapping("/answerCustomer.do")
	public String answerCustomer(Model model, @RequestParam("buyer_inq_id") Integer buyer_inq_id,
			HttpServletRequest request) {
		System.out.println(buyer_inq_id);
		System.out.println(buyer_inqService.selectByInqIdFORseller(buyer_inq_id));

		System.out.println(buyer_inqService.selectByInqIdFORseller(buyer_inq_id));
		
		model.addAttribute("bqa", buyer_inqService.selectByInqIdFORseller(buyer_inq_id));

		return "/seller/seller_CustomerQAPopUp";
	}

	// 구매자 문의에 답변
	@PostMapping("/answerCustomer.do")
	@ResponseBody
	public String answerCquestion(
			@RequestParam("buyer_inq_id") Integer buyerInqId,
			/*
			 * @RequestParam("member_id") String memberId,
			 * 
			 * @RequestParam("buyer_inq_title") String questionTitle,
			 * 
			 * @RequestParam("buyer_inq_content") String buyerInqContent,
			 */
			@RequestParam("buyer_reply") String buyerReply)
			throws UnsupportedEncodingException {
		

		String buyer_reply = URLDecoder.decode(buyerReply,"UTF-8");

		System.out.println(buyer_reply);
		
		
		// 업로드 날짜
		// 오늘 날짜를 LocalDate로 가져옴
		LocalDate localDate = LocalDate.now();

		// LocalDate를 java.sql.Date로 변환
		Date sqlDate = Date.valueOf(localDate);
		
		Buyer_InqDTO buyer_InqDTO = new Buyer_InqDTO();
		buyer_InqDTO.setBuyer_inq_id(buyerInqId);
		buyer_InqDTO.setBuyer_reply(buyer_reply);
		buyer_InqDTO.setBuyer_reply_date(sqlDate);
		
		System.out.println(buyer_InqDTO);
		
		int result = buyer_inqService.buyer_inqUpdate(buyer_InqDTO);
		System.out.println(result);
		return "Answer submitted successfully.";
	}

	// 관리자문의 조회 팝업
	@GetMapping("/answerAdmin.do")
	public String answerAdmin(Model model, @RequestParam("admin_inq_id") Integer admin_inq_id) {	
		model.addAttribute("aqa", admin_inqService.selectByInqId(admin_inq_id));
		return "/seller/seller_AdminAPopUp";
	}

	// 관리자문의 등록 팝업
	@GetMapping("/addAdminQA.do")
	public String addAdminQA(Model model){
		String member_id = "573-50-00882";// 임시로 사용할 판매자ID(사업자등록번호)
		System.out.println("조회 : "+ memberService.selectById(member_id));
		model.addAttribute("aqa", memberService.selectById(member_id));
		return "/seller/seller_AdminQPopUp";
	}

	// 관리자에게 문의 등록
	@PostMapping("/addAdminQA.do")
	@ResponseBody
	public String registerStoAquestion(
		@RequestParam("member_id") String mid,
		@RequestParam("admin_inq_title") String StoAqTitle,
		@RequestParam("admin_inq_content") String StoAq
		) throws UnsupportedEncodingException {

		String member_id=URLDecoder.decode(mid,"UTF-8");
		String admin_inq_title=URLDecoder.decode(StoAqTitle,"UTF-8");
		String admin_inq_content=URLDecoder.decode(StoAq,"UTF-8");
		
		// 업로드 날짜
		// 오늘 날짜를 LocalDate로 가져옴
		LocalDate localDate = LocalDate.now();

		// LocalDate를 java.sql.Date로 변환
		Date sqlDate = Date.valueOf(localDate);

		// 문의ID 생성
		Integer qid = 12305;

		// 이후에 SQL문으로 DB에 등록
		
		Admin_InqDTO admin_InqDTO = new Admin_InqDTO();
		admin_InqDTO.setAdmin_inq_id(qid);
		admin_InqDTO.setAdmin_inq_title(admin_inq_title);
		admin_InqDTO.setAdmin_inq_content(admin_inq_content);
		admin_InqDTO.setAdmin_inq_date(sqlDate);
		admin_InqDTO.setMember_id(member_id);
		
		int result = admin_inqService.admin_inqInsert(admin_InqDTO);
		System.out.println(result);
		return "Answer submitted successfully.";
	}

}