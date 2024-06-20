package com.team4.shoppingmall.seller;

import java.io.UnsupportedEncodingException;
import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/seller")
public class SellerQAController {

	//관리자에게 문의 등록
	@PostMapping("/registerStoAquestion")
	public void registerStoAquestion(
			@RequestParam("sellerID") String sellerID,
			@RequestParam("StoAquestionTitle") String StoAqTitle,
			@RequestParam("StoAquestion") String StoAq,
			RedirectAttributes redirectAttributes
			) throws UnsupportedEncodingException {
		
		//한글 깨짐 해결
		String sellerid = new String(sellerID.getBytes("8859_1"),"utf-8");
		String sToAqTitle = new String(StoAqTitle.getBytes("8859_1"),"utf-8");
		String sToAq = new String(StoAq.getBytes("8859_1"),"utf-8");

		//업로드 날짜
		Date registeredDate = new Date();
		
		//문의ID 생성
		
		//이후에 SQL문으로 DB에 등록
	}
	
	//구매자 문의에 답변
	@PostMapping("/answerCquestion")
	public void answerCquestion(
			@RequestParam("CtoSquestionID") int CtoSquestionID,
			@RequestParam("CtoSquestionTitle") String CtoSquestionTitle,
			@RequestParam("CtoSquestion") String CtoSquestion,
			@RequestParam("CtoSquestionAnswer") String CtoSquestionAnswer,
			RedirectAttributes redirectAttributes
			) throws UnsupportedEncodingException {
		//한글 깨짐 해결
		String cTosQtitle = new String(CtoSquestionTitle.getBytes("8859_1"),"utf-8");
		String cTosQ = new String(CtoSquestion.getBytes("8859_1"),"utf-8");
		String cTosQanswer = new String(CtoSquestionAnswer.getBytes("8859_1"),"utf-8");
		
		//이후에 SQL문으로 DB에 등록
		
	}
}
