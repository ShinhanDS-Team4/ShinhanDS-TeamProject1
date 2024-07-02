package com.team4.shoppingmall.customerTest;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.google.gson.JsonObject;
import com.siot.IamportRestClient.exception.IamportResponseException;

@Controller
@RequestMapping("/customer")
public class CustomerController {

	@Autowired
	private PaymentService paymentService;

	// 상품결제페이지
	@GetMapping("/orderPay")
	public String orderPayPage() {
		return "customer/customerPay";
	}

	// 상품 결제 완료페이지
	@GetMapping("/orderSuccess")
	public String orderSuccessPage() {
		return "customer/customerOrderSuccess";
	}


	//결제 전 사전 검증을 위한 결제금액 사전등록
	@PostMapping("/preparePayment")
	@ResponseBody
	public String preparePayment(@RequestParam String merchantUid, @RequestParam int amount) {
		return paymentService.registerPaymentAmount(merchantUid, amount);
	}

	//결제 내용에 대한 검증
	@PostMapping("/verifyPayment")
	@ResponseBody
	public String verifyPayment(@RequestParam("imp_uid") String impUid,
                                @RequestParam("merchant_uid") String merchantUid) {
		return paymentService.verifyPayment(impUid, merchantUid);
	}

}
