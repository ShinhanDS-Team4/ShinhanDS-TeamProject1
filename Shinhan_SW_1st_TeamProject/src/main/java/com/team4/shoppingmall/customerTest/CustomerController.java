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
import javax.servlet.http.HttpSession;

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
import com.team4.shoppingmall.rent.RentDTO;
import com.team4.shoppingmall.rent.RentService;
import com.team4.shoppingmall.rent_detail.RentDetailDTO;
import com.team4.shoppingmall.rent_detail.RentDetailService;
import com.team4.shoppingmall.rent_prod_stock.RentProdStockDTO;
import com.team4.shoppingmall.rent_prod_stock.RentProdStockService;
import com.team4.shoppingmall.seller_prod_stock.Seller_Prod_StockDTO;
import com.team4.shoppingmall.seller_prod_stock.Seller_Prod_StockService;

@Controller
@RequestMapping("/customer")
public class CustomerController {

	@Autowired
	private OrderProdService orderProdService;


	@Autowired
	private RentService rentService;

	@Autowired
	private Order_DetailService orderDetailService;

	@Autowired
	private RentDetailService rentDetailService;

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

	@Autowired
	private Seller_Prod_StockService seller_Prod_StockService;

	@Autowired
	private RentProdStockService rentProdStockService;

	//String customerID = "bih63879";// 고객의 ID는 session에서 끌어온다.

	// 상품 구매 결제
	@GetMapping("/orderPay")
	public String orderPayPage(Model model1, Model model2, Model model3, Model model4, Model model5, Model model6, HttpSession session) {
		MemberDTO mem = (MemberDTO)session.getAttribute("member");
		String customerID = mem.getMember_id();
		
		Integer orderID = 1;// 주문ID. 실제로는 주문하기 버튼을 누르면 주문 ID를 받아와서 끌어옴

		// 주문 데이터 가져오기
		OrderProdDTO orderProdDTO = orderProdService.selectById(orderID);

		// 주문에 포함되어 있는 주문 상세 목록들을 가져오기
		List<Order_DetailDTO> orderDetailList = orderDetailService.selectByOrder_Id(orderID);

		// 주문을 한 고객의 정보 가져오기
		MemberDTO memberDTO = memberService.selectById(customerID);

		// 고객의 주소 목록 가져오기
		List<Addr_ListDTO> addr_ListDTOs = addr_ListService.selectByMember_Id(customerID);

		// 고객이 가지고 있는 쿠폰 목록 가져오기
		List<CouponDTO> usableCouponList = couponService.selectCustomerCouponList(customerID);

		// 고객이 가지고 있는 회원등급, 포인트를 가져오기
		CustomerDTO customerDTO = customerService.selectById(customerID);

		model1.addAttribute("orderInfo", orderProdDTO);
		model2.addAttribute("orderDetailList", orderDetailList);
		model3.addAttribute("memberInfo", memberDTO);
		model4.addAttribute("couponList", usableCouponList);
		model5.addAttribute("customerInfo", customerDTO);
		model6.addAttribute("addrList", addr_ListDTOs);

		return "customer/customerPay";
	}

	// 상품 대여 결제
	@GetMapping("/rentPay")
	public String rentPayPage(Model model1, Model model2, Model model3, Model model4, Model model5, Model model6, HttpSession session) {
		MemberDTO mem = (MemberDTO)session.getAttribute("member");
		String customerID = mem.getMember_id();
		
		Integer rental_code = 2;// 대여ID. 대여하기 버튼을 누르면 끌어옴

		// 대여 정보 가져오기
		RentDTO rentDTO = rentService.selectById(rental_code);

		// 대여가 가지고 있는 상세 대여 정보 목록 가져오기
		List<RentDetailDTO> rentDetailList = rentDetailService.selectByRental_code(rental_code);

		// 대여를 한 고객의 정보 가져오기
		MemberDTO memberDTO = memberService.selectById(customerID);

		// 고객이 가지고 있는 쿠폰 목록 가져오기
		List<CouponDTO> usableCouponList = couponService.selectCustomerCouponList(customerID);

		// 고객이 가지고 있는 회원등급, 포인트를 가져오기
		CustomerDTO customerDTO = customerService.selectById(customerID);

		model1.addAttribute("rentInfo", rentDTO);
		model2.addAttribute("rentDetailList", rentDetailList);
		model3.addAttribute("memberInfo", memberDTO);
		model4.addAttribute("couponList", usableCouponList);
		model5.addAttribute("customerInfo", customerDTO);

		return "customer/rentPay";
	}

	// 대여 주문에 쿠폰 적용하기
	@PostMapping("/applyRentCoupon")
	@ResponseBody
	public String applyRentCoupon(@RequestBody CouponRequestDTO couponRequestDTO) {

		String couponid = couponRequestDTO.getCouponid();
		int orderid = couponRequestDTO.getOrderid();

		if ("선택안함".equals(couponid)) {
			return "Coupon applied";
		} else {
			// 현재 최종가 가져오기
			RentDTO rentDTO = rentService.selectById(orderid);
			int totalPrice = rentDTO.getTotal_rent_price();

			System.out.println("쿠폰ID:" + couponid);
			CouponDTO selectCouponDTO = couponService.selectById(couponid);

			System.out.println("선택한 쿠폰 정보:" + selectCouponDTO);
			double discountRate = selectCouponDTO.getDiscount_rate();

			int discountAmount = (int) Math.round(totalPrice * (discountRate / 100.0));

			int discountedPrice = totalPrice - discountAmount;

			System.out.println("할인:" + discountAmount);
			System.out.println("할인 후 가격:" + discountedPrice);

			int couponAmount = selectCouponDTO.getQuantity();
			selectCouponDTO.setQuantity(couponAmount - 1);

			int couponUpdate = couponService.couponUse(selectCouponDTO);

			rentDTO.setTotal_rent_price(discountedPrice);

			int appliedResult = rentService.updateRent(rentDTO);

			return "Coupon applied";
		}

	}

	// 대여 주문에 포인트 적용하기
	@PostMapping("/applyRentPoint")
	@ResponseBody
	public String applyRentPoint(@RequestBody PointRequestDTO pointRequestDTO, HttpSession session) {
		MemberDTO mem = (MemberDTO)session.getAttribute("member");
		String customerID = mem.getMember_id();
		
		int point = pointRequestDTO.getPoint();
		System.out.println("보유포인트:" + point);
		int orderid = pointRequestDTO.getOrderid();

		RentDTO rentDTO = rentService.selectById(orderid);
		int totalPrice = rentDTO.getTotal_rent_price();

		int pointAppliedPrice = totalPrice - point;
		System.out.println("포인트가 적용된 가격:" + pointAppliedPrice);

		rentDTO.setTotal_rent_price(pointAppliedPrice);

		int appliedResult = rentService.updateRent(rentDTO);

		CustomerDTO customerDTO = customerService.selectById(customerID);
		int existPoint = customerDTO.getPoint();
		customerDTO.setPoint(existPoint - point);

		int CustomerPointUpdate = customerService.customerUpdate(customerDTO);

		return "Point Used";
	}

	// 구매 주문에 쿠폰 적용하기
	@PostMapping("/applyCoupon")
	@ResponseBody
	public String applyCoupon(@RequestBody CouponRequestDTO couponRequestDTO) {

		String couponid = couponRequestDTO.getCouponid();
		int orderid = couponRequestDTO.getOrderid();
		
		// 쿠폰을 선택하지 않은 경우
		if ("선택안함".equals(couponid)) {
			return "Coupon applied";
		} else {
			// 쿠폰을 선택한 경우
			OrderProdDTO orderProdDTO = orderProdService.selectById(orderid);
			int totalPrice = orderProdDTO.getTotal_price();

			System.out.println("쿠폰ID:" + couponid);
			CouponDTO selectCouponDTO = couponService.selectById(couponid);

			System.out.println("쿠폰정보:" + selectCouponDTO);
			double discountRate = selectCouponDTO.getDiscount_rate();

			int discountAmount = (int) Math.round(totalPrice * (discountRate / 100.0));

			int discountedPrice = totalPrice - discountAmount;

			System.out.println("쿠폰 할인액:" + discountAmount);
			System.out.println("쿠폰 적용 결제액:" + discountedPrice);

			int couponAmount = selectCouponDTO.getQuantity();
			selectCouponDTO.setQuantity(couponAmount - 1);

			int couponUpdate = couponService.couponUse(selectCouponDTO);

			OrderProdDTO updatedPrice = new OrderProdDTO();
			updatedPrice.setOrder_id(orderid);
			updatedPrice.setTotal_price(discountedPrice);

			int appliedResult = orderProdService.updateOrderPrice(updatedPrice);

			return "Coupon applied";
		}

	}

	// 구매 주문 포인트 적용
	@PostMapping("/applyPoint")
	@ResponseBody
	public String applyCoupon(@RequestBody PointRequestDTO pointRequestDTO, HttpSession session) {
		MemberDTO mem = (MemberDTO)session.getAttribute("member");
		String customerID = mem.getMember_id();
		
		int point = pointRequestDTO.getPoint();
		System.out.println("포인트 보유량:" + point);
		int orderid = pointRequestDTO.getOrderid();

		OrderProdDTO orderProdDTO = orderProdService.selectById(orderid);
		int totalPrice = orderProdDTO.getTotal_price();

		int pointAppliedPrice = totalPrice - point;
		System.out.println("포인트 적용 결제가격:" + pointAppliedPrice);

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

	// 주소 선택하기
	@PostMapping("/applyAddress")
	@ResponseBody
	public String applyAddress(@RequestBody AddressRequestDTO request, HttpSession session) {
		System.out.println(request);

		int addr_num = request.getAddr_num();
		int order_id = request.getOrder_id();

		OrderProdDTO orderProdDTO = orderProdService.selectById(order_id);
		orderProdDTO.setAddr_num(addr_num);
		System.out.println("주소 적용 후 주문정보:" + orderProdDTO);

		int addrUpdateResult = orderProdService.orderprodUpdate(orderProdDTO);

		session.setAttribute("selectedAddr", addr_num);

		return "Address Saved";
	}

	// 구매 결제 완료 후 프로세스
	@GetMapping("/sellPaySuccess")
	public String sellPaySuccess(@RequestParam("order_id") Integer order_id) {

		OrderProdDTO orderProdDTO = orderProdService.selectById(order_id);
		// 구매 주문에 해당하는 주문 상세 목록들 가져오기
		List<Order_DetailDTO> orderDetailDTOs = orderDetailService.selectByOrder_Id(order_id);

		// 주문 상세 목록에 대한 반복문 수행
		for (Order_DetailDTO order_DetailDTO : orderDetailDTOs) {

			// 주문 상세의 주문 상태를 '결제완료'로 변경
			order_DetailDTO.setOrder_state("결제완료");

			// 해당 주문이 구매한 판매 재고 정보를 가져오기
			String s_stock_id = order_DetailDTO.getS_stock_id();
			Seller_Prod_StockDTO seller_Prod_StockDTO = seller_Prod_StockService.selectByStockId(s_stock_id);
			int currentStock = seller_Prod_StockDTO.getStock();// 해당 재고의 재고량
			int currentSellTotal = seller_Prod_StockDTO.getTotal();// 해당 재고의 판매량

			// 주문량과 해당 주문 제품의 가격 가져오기
			int orderAmount = order_DetailDTO.getOrder_num();
			int orderPrice = order_DetailDTO.getOrder_product_price();

			// 판매 재고 정보 : 재고량과 판매량 수정
			seller_Prod_StockDTO.setStock(currentStock - orderAmount);
			seller_Prod_StockDTO.setTotal(currentSellTotal + orderAmount);

			int updateOrderStatus = orderDetailService.orderDetailUpdate(order_DetailDTO);
			int updateStock = seller_Prod_StockService.seller_prod_stockUpdate(seller_Prod_StockDTO);
		}

		// 고객의 포인트와 고객등급, 누적 구매액 가져오기
		String customerID = orderProdDTO.getMember_id();
		CustomerDTO customerDTO = customerService.selectById(customerID);
		int orderPrice = orderProdDTO.getTotal_price();

		int point = customerDTO.getPoint();
		String member_level = customerDTO.getMember_level();
		int accum_amount = customerDTO.getAccum_amount();

		// 누적 구매액 갱신
		accum_amount = accum_amount + orderPrice;
		customerDTO.setAccum_amount(accum_amount);

		// 등급별 포인트 계산 후 적립
		double rate = 0.0;

		if ("Family".equals(member_level)) {
			rate = 0.1;
		} else if ("Bronze".equals(member_level)) {
			rate = 0.5;
		} else if ("Silver".equals(member_level)) {
			rate = 1.0;
		} else if ("Gold".equals(member_level)) {
			rate = 1.5;
		} else if ("Platinum".equals(member_level)) {
			rate = 2.0;
		}

		int upadatedPoint = point + (int) Math.round(orderPrice * rate);

		customerDTO.setPoint(upadatedPoint);

		// 고객의 누적 구매액에 따라 등급 변경
		if (accum_amount >= 1000000) {
			customerDTO.setMember_level("Platinum");
		} else if (accum_amount >= 600000 && accum_amount < 1000000) {
			customerDTO.setMember_level("Gold");
		} else if (accum_amount >= 300000 && accum_amount < 600000) {
			customerDTO.setMember_level("Silver");
		} else if (accum_amount >= 100000 && accum_amount < 300000) {
			customerDTO.setMember_level("Bronze");
		} else {
			customerDTO.setMember_level("Family");
		}

		int customerUpdate = customerService.customerUpdate(customerDTO);

		return "customer/customerOrderSuccess";
	}

	// 대여 결제 완료 후 프로세스
	@GetMapping("/rentPaySuccess")
	public String rentPaySuccess(@RequestParam("rental_code") Integer rental_code) {

		RentDTO rentDTO = rentService.selectById(rental_code);

		List<RentDetailDTO> rentDetailDTOs = rentDetailService.selectByRental_code(rental_code);

		for (RentDetailDTO rentDetailDTO : rentDetailDTOs) {

			// 대여 상세의 대여 상태를 '결제완료'로 변경
			rentDetailDTO.setRent_state("결제완료");
			String r_stock_id = rentDetailDTO.getR_stock_id();

			// 해당 대여가 구매한 대여 재고 정보를 가져오기
			RentProdStockDTO rentProdStockDTO = rentProdStockService.selectById(r_stock_id);
			int currentStock = rentProdStockDTO.getStock();
			int currentRentTotal = rentProdStockDTO.getTotal();

			// 대여량과 해당 대여 제품의 가격 가져오기
			int rentAmount = rentDetailDTO.getRent_num();
			int rentPrice = rentDetailDTO.getRent_product_price();

			// 대여 재고 정보 : 재고량과 대여량 갱신
			rentProdStockDTO.setStock(currentStock - rentAmount);
			rentProdStockDTO.setTotal(currentRentTotal + rentAmount);

			int updateOrderStatus = rentDetailService.rentDetailUpdate(rentDetailDTO);
			int updateStock = rentProdStockService.rentStockUpdate(rentProdStockDTO);

		}

		// 고객의 포인트와 고객등급, 누적 구매액 가져오기
		String customerID = rentDTO.getMember_id();
		CustomerDTO customerDTO = customerService.selectById(customerID);
		int rentPrice = rentDTO.getTotal_rent_price();

		int point = customerDTO.getPoint();
		String member_level = customerDTO.getMember_level();
		int accum_amount = customerDTO.getAccum_amount();

		// 누적 구매액 갱신
		accum_amount = accum_amount + rentPrice;
		customerDTO.setAccum_amount(accum_amount);

		// 등급별 포인트 계산 후 적립
		double rate = 0.0;

		if ("Family".equals(member_level)) {
			rate = 0.1;
		} else if ("Bronze".equals(member_level)) {
			rate = 0.5;
		} else if ("Silver".equals(member_level)) {
			rate = 1.0;
		} else if ("Gold".equals(member_level)) {
			rate = 1.5;
		} else if ("Platinum".equals(member_level)) {
			rate = 2.0;
		}

		int upadatedPoint = point + (int) Math.round(rentPrice * rate);

		customerDTO.setPoint(upadatedPoint);

		// 고객의 누적 구매액에 따라 등급 변경
		if (accum_amount >= 1000000) {
			customerDTO.setMember_level("Platinum");
		} else if (accum_amount >= 600000 && accum_amount < 1000000) {
			customerDTO.setMember_level("Gold");
		} else if (accum_amount >= 300000 && accum_amount < 600000) {
			customerDTO.setMember_level("Silver");
		} else if (accum_amount >= 100000 && accum_amount < 300000) {
			customerDTO.setMember_level("Bronze");
		} else {
			customerDTO.setMember_level("Family");
		}

		int customerUpdate = customerService.customerUpdate(customerDTO);

		return "customer/customerOrderSuccess";

	}

	// 구매 결제 취소
	@PostMapping("/cancelOrderPay.do")
	@ResponseBody
	public String cancelOrderPay(@RequestParam int order_id) {
		int orderID = order_id;

		// 주문 상세 삭제
		int orderDetailDelResult = orderDetailService.orderDetailDelByOrderID(order_id);

		// 주문 삭제
		int orderDelResult = orderProdService.orderprodDelete(order_id);

		return "Canceled";
	}

	// 대여 결제 취소
	@PostMapping("/cancelRentPay.do")
	@ResponseBody
	public String cancelRentPay(@RequestParam int rental_code) {
		int rentalCode = rental_code;

		// 대여 상세 삭제
		int rentDetailDelResult = rentDetailService.rentDetailDelByRentCode(rentalCode);

		// 대여 삭제
		int rentDelResult = rentService.rentprodDelete(rental_code);

		return "Canceled";
	}

	// 결제 전 결제 내용을 미리 포트원에 업로드
	@PostMapping("/preparePayment")
	@ResponseBody
	public String preparePayment(@RequestParam String merchantUid, @RequestParam int amount) {
		return paymentService.registerPaymentAmount(merchantUid, amount);
	}

	// 결제검증
	@PostMapping("/verifyPayment")
	@ResponseBody
	public String verifyPayment(@RequestParam("imp_uid") String impUid,
			@RequestParam("merchant_uid") String merchantUid) {
		return paymentService.verifyPayment(impUid, merchantUid);
	}

}

