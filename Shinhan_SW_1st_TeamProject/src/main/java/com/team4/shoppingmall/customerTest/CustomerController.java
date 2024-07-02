package com.team4.shoppingmall.customerTest;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.google.gson.JsonObject;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.team4.shoppingmall.addr_list.Addr_ListController;
import com.team4.shoppingmall.addr_list.Addr_ListDTO;
import com.team4.shoppingmall.addr_list.Addr_ListService;
import com.team4.shoppingmall.coupon.CouponDTO;
import com.team4.shoppingmall.coupon.CouponService;
import com.team4.shoppingmall.customer.CustomerDTO;
import com.team4.shoppingmall.customer.CustomerService;
import com.team4.shoppingmall.member.MemberDTO;
import com.team4.shoppingmall.member.MemberService;
import com.team4.shoppingmall.order_detail.Order_DetailDTO;
import com.team4.shoppingmall.order_detail.Order_DetailService;
import com.team4.shoppingmall.order_prod.OrderProdDTO;
import com.team4.shoppingmall.order_prod.OrderProdService;

@Controller
@RequestMapping("/customer")
public class CustomerController {

	@Autowired
	private OrderProdService orderProdService;

	@Autowired
	private Order_DetailService orderDetailService;

	@Autowired
	private CouponService couponService;

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private Addr_ListService addr_ListService;

	@Autowired
	private PaymentService paymentService;
	
	@Autowired
	private CustomerService customerService;
	
	String customerID = "bih63879";// 임시 고객 ID. Session에서 받아올 것임

	Integer orderID = 1;// 주문ID, 주문하기 버튼을 누를 시 생성되는 값을 가져올 것임

	// 상품결제페이지
	@GetMapping("/orderPay")
	public String orderPayPage(Model model1, Model model2, Model model3, Model model4, Model model5, Model model6) {

		// 주문 항목 데이터 가져오기
		OrderProdDTO orderProdDTO = orderProdService.selectById(orderID);

		// 상세 주문 내역 목록
		List<Order_DetailDTO> orderDetailList = orderDetailService.selectByOrder_Id(orderID);

		// 회원정보
		MemberDTO memberDTO = memberService.selectById(customerID);
		
		// 회원의 주소 목록
		List<Addr_ListDTO> addr_ListDTOs=addr_ListService.selectByMember_Id(customerID);

		// 회원이 주문 화면에서 사용 가능한 쿠폰 목록
		List<CouponDTO> usableCouponList = couponService.selectCustomerCouponList(customerID);

		CustomerDTO customerDTO = customerService.selectById(customerID);
		System.out.println("고객추가정보:"+customerDTO);
		model1.addAttribute("orderInfo", orderProdDTO);
		model2.addAttribute("orderDetailList", orderDetailList);
		model3.addAttribute("memberInfo", memberDTO);
		model4.addAttribute("couponList", usableCouponList);
		model5.addAttribute("customerInfo",customerDTO);
		model6.addAttribute("addrList", addr_ListDTOs);

		return "customer/customerPay";
	}

	@PostMapping("/applyCoupon")
	@ResponseBody
	public String applyCoupon(@RequestBody CouponRequestDTO couponRequestDTO) {

		String couponid = couponRequestDTO.getCouponid();
		int orderid = couponRequestDTO.getOrderid();

		if("선택안함".equals(couponid)) {
			return "Coupon applied";
		}else {
			// 주문 항목 데이터 가져오기
			OrderProdDTO orderProdDTO = orderProdService.selectById(orderid);
			int totalPrice = orderProdDTO.getTotal_price();
			
			System.out.println("쿠폰ID:" + couponid);
			CouponDTO selectCouponDTO = couponService.selectById(couponid);

			System.out.println("쿠폰정보:" + selectCouponDTO);
			double discountRate = selectCouponDTO.getDiscount_rate();

			int discountAmount = (int) Math.round(totalPrice * (discountRate / 100.0));

			int discountedPrice = totalPrice - discountAmount;

			System.out.println("할인:" + discountAmount);
			System.out.println("할인가격:" + discountedPrice);
			
			int couponAmount = selectCouponDTO.getQuantity();
			selectCouponDTO.setQuantity(couponAmount-1);
			
			int couponUpdate = couponService.couponUse(selectCouponDTO);
			
			OrderProdDTO updatedPrice = new OrderProdDTO();
			updatedPrice.setOrder_id(orderid);
			updatedPrice.setTotal_price(discountedPrice);
			
			int appliedResult = orderProdService.updateOrderPrice(updatedPrice);
			
			return "Coupon applied";
		}
		
	}
	
	@PostMapping("/applyPoint")
	@ResponseBody
	public String applyCoupon(@RequestBody PointRequestDTO pointRequestDTO) {
		int point = pointRequestDTO.getPoint();
		System.out.println("사용할 포인트:"+point);
		int orderid = pointRequestDTO.getOrderid();
		
		OrderProdDTO orderProdDTO = orderProdService.selectById(orderid);
		int totalPrice = orderProdDTO.getTotal_price();
		
		int pointAppliedPrice = totalPrice - point;
		System.out.println("포인트 사용 후 결제값:"+pointAppliedPrice);
		
		OrderProdDTO updatedPrice = new OrderProdDTO();
		updatedPrice.setOrder_id(orderid);
		updatedPrice.setTotal_price(pointAppliedPrice);
		
		CustomerDTO customerDTO = customerService.selectById(customerID);
		int existPoint = customerDTO.getPoint();
		customerDTO.setPoint(existPoint - point);
		
		int CustomerPointUpdate = customerService.customerUpdate(customerDTO);
		
		int appliedResult = orderProdService.updateOrderPrice(updatedPrice);
		
		return "Point Used";
	}
	
	@PostMapping("/applyAddress")
	@ResponseBody
	public String applyAddress(@RequestBody AddressRequestDTO request) {
		System.out.println(request);
		
		int addr_num=request.getAddr_num();
		int order_id=request.getOrder_id();
		
		OrderProdDTO orderProdDTO = orderProdService.selectById(order_id);
		System.out.println("주문정보:"+orderProdDTO);
		orderProdDTO.setAddr_num(addr_num);
		
		int addrUpdateResult = orderProdService.orderprodUpdate(orderProdDTO);
		
		return "Address Saved";
	}

	// 상품 결제 완료페이지
	@GetMapping("/orderSuccess")
	public String orderSuccessPage() {
		return "customer/customerOrderSuccess";
	}

	// 결제 전 사전 검증을 위한 결제금액 사전등록
	@PostMapping("/preparePayment")
	@ResponseBody
	public String preparePayment(@RequestParam String merchantUid, @RequestParam int amount) {
		return paymentService.registerPaymentAmount(merchantUid, amount);
	}

	// 결제 내용에 대한 검증
	@PostMapping("/verifyPayment")
	@ResponseBody
	public String verifyPayment(@RequestParam("imp_uid") String impUid,
			@RequestParam("merchant_uid") String merchantUid) {
		return paymentService.verifyPayment(impUid, merchantUid);
	}

}
