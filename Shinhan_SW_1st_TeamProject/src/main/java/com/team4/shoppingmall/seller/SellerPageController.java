package com.team4.shoppingmall.seller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/seller")
public class SellerPageController {

	// 메인 화면 보여주기
	@RequestMapping("/MainPage.do")
	public String mainpage() {
		return "seller/sellerMain";
	}


	// 판매&대여 상품 페이지 보여주기
	@GetMapping("/PrdList.do")
	public String prdList() {
		return "/seller/sellerPrdList";
	}

	// 판매&배송 페이지 보여주기
	@GetMapping("/DeliveryList.do")
	public String deliveryList() {
		return "/seller/sellerDelivery";
	}

	// 문의 목록 페이지 보여주기
	@GetMapping("/Q&AList.do")
	public String qaList() {
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
	public String answerCustomer() {
		return "/seller/seller_CustomerQAPopUp";
	}

	// 관리자문의 조회 팝업
	@GetMapping("/answerAdmin.do")
	public String answerAdmin() {
		return "/seller/seller_AdminAPopUp";
	}

	// 관리자문의 등록 팝업
	@GetMapping("/addAdminQA.do")
	public String addAdminQA() {
		return "/seller/seller_AdminQAPopUp";
	}

}