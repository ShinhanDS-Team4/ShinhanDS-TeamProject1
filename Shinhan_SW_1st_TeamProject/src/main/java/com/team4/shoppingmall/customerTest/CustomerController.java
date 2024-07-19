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

	// String customerID = "bih63879";// 고객의 ID는 session에서 끌어온다.

	// 상품 구매 결제
	@GetMapping("/orderPay.do")
	public String orderPayPage(Model model, Model model1, Model model2, Model model3, Model model4, Model model5,
			Model model6, @RequestParam(value = "order_id", required = false) Integer orderID, HttpSession session) {
		MemberDTO mem = (MemberDTO) session.getAttribute("member");
		String customerID = mem.getMember_id();

		// Integer orderID = 1;// 주문ID. 실제로는 주문하기 버튼을 누르면 주문 ID를 받아와서 끌어옴

		// 주문 데이터 가져오기
		OrderProdDTO orderProdDTO = orderProdService.selectById(orderID);

		// 주문에 포함되어 있는 주문 상세 목록들을 가져오기 (mapper수정)
		List<Order_DetailDTO> orderDetailList = orderDetailService.selectByOrder_Id(orderID);
		System.out.println("orderDetailList="+orderDetailList);
		// 주문을 한 고객의 정보 가져오기
		MemberDTO memberDTO = memberService.selectById(customerID);

		// 고객의 주소 목록 가져오기
		List<Addr_ListDTO> addr_ListDTOs = addr_ListService.selectByMember_Id(customerID);

		// 고객이 가지고 있는 쿠폰 목록 가져오기
		List<CouponDTO> usableCouponList = couponService.selectCustomerCouponList(customerID);

		// 고객이 가지고 있는 회원등급, 포인트를 가져오기
		CustomerDTO customerDTO = customerService.selectById(customerID);

		// 주문 구매 상품 브랜드,이름 가져오기 (수정)
		List<Map<String,String>> brandandProdName = orderDetailService.getOrderProdBrand(orderID);
		model.addAttribute("brandandProdName", brandandProdName);
		System.out.println(brandandProdName);

		model1.addAttribute("orderInfo", orderProdDTO);
		model2.addAttribute("orderDetailList", orderDetailList);
		model3.addAttribute("memberInfo", memberDTO);
		model4.addAttribute("couponList", usableCouponList);
		model5.addAttribute("customerInfo", customerDTO);
		model6.addAttribute("addrList", addr_ListDTOs);

		return "customer/customerPay";
	}

	// 상품 대여 결제
	@GetMapping("/rentPay.do")
	public String rentPayPage(Model model, Model model1, Model model2, Model model3, Model model4, Model model5,
			Model model6, @RequestParam(value = "rental_code", required = false) Integer rentalCode,
			HttpSession session) {
		MemberDTO mem = (MemberDTO) session.getAttribute("member");
		String customerID = mem.getMember_id();

		// Integer rental_code = 2;// 대여ID. 대여하기 버튼을 누르면 끌어옴

		// 대여 정보 가져오기
		RentDTO rentDTO = rentService.selectById(rentalCode);

		// 대여를 한 고객의 정보 가져오기
		MemberDTO memberDTO = memberService.selectById(customerID);

		// 고객이 가지고 있는 쿠폰 목록 가져오기
		List<CouponDTO> usableCouponList = couponService.selectCustomerCouponList(customerID);

		// 고객이 가지고 있는 회원등급, 포인트를 가져오기
		CustomerDTO customerDTO = customerService.selectById(customerID);
		
		// 대여가 가지고 있는 상세 대여 정보 목록 가져오기 (mapper수정)
		List<RentDetailDTO> rentDetailList = rentDetailService.selectByRental_code(rentalCode);

		// 대여주문 구매 상품 브랜드,이름 가져오기
		List<Map<String,String>> rentBrandandProdName = rentDetailService.getRentOrderProdBrand(rentalCode);
		System.out.println("rentBrandandProdName:"+rentBrandandProdName);

		model.addAttribute("rentBrandandProdName", rentBrandandProdName);
		model1.addAttribute("rentInfo", rentDTO);
		model2.addAttribute("rentDetailList", rentDetailList);
		model3.addAttribute("memberInfo", memberDTO);
		model4.addAttribute("couponList", usableCouponList);
		model5.addAttribute("customerInfo", customerDTO);

		return "customer/rentPay";
	}

	// 주문에 쿠폰 적용하기
	@PostMapping("/applyCoupon.do")
	@ResponseBody
	public CouponResultDTO applyCoupon(@RequestBody CouponRequestDTO couponRequestDTO, Model model) {
		CouponResultDTO couponResultDTO = new CouponResultDTO();
		int couponid = couponRequestDTO.getCouponid();
		String customerid = couponRequestDTO.getCustomerid();
		int orderPrice = couponRequestDTO.getOrderPrice();

		// 쿠폰을 선택하지 않은 경우
		if (couponid == 0) {
			couponResultDTO.setDiscount(0);
			couponResultDTO.setDiscountedPrice(orderPrice);
			couponResultDTO.setCouponID(couponid);

			return couponResultDTO;
		} else {

			System.out.println("쿠폰ID:" + couponid);

			CouponDTO couponDTO = new CouponDTO();

			couponDTO.setCoupon_id(couponid);
			couponDTO.setMember_id(customerid);

			CouponDTO selectCouponDTO = couponService.selectById(couponDTO);

			System.out.println("쿠폰정보:" + selectCouponDTO);
			double discountRate = selectCouponDTO.getDiscount_rate();

			int discount = (int) Math.round(orderPrice * (discountRate / 100.0));

			int discountedPrice = orderPrice - discount;

			System.out.println("할인액:" + discount);
			System.out.println("할인 결과 금액 : " + discountedPrice);

			couponResultDTO.setDiscount(discount);
			couponResultDTO.setDiscountedPrice(discountedPrice);
			couponResultDTO.setCouponID(couponid);

			model.addAttribute("couponselectDiscount", discount);
			model.addAttribute("couponSelectedPrice", discountedPrice);
			model.addAttribute("couponInfo", selectCouponDTO);

			model.addAttribute("finalPrice", discountedPrice);

			return couponResultDTO;
		}

	}

	// 주문에 포인트 적용
	@PostMapping("/applyPoint.do")
	@ResponseBody
	public PointResultDTO applyCoupon(@RequestBody PointRequestDTO pointRequestDTO, HttpSession session) {
		MemberDTO mem = (MemberDTO) session.getAttribute("member");
		String customerID = mem.getMember_id();

		int point = pointRequestDTO.getUsePoint();
		System.out.println("포인트:" + point);
		int couponAppliedPrice = pointRequestDTO.getCouponAppliedPrice();

		int pointAppliedPrice = couponAppliedPrice - point;
		System.out.println("포인트 적용 결제가격:" + pointAppliedPrice);

		PointResultDTO pointResultDTO = new PointResultDTO();

		pointResultDTO.setUsePoint(point);
		pointResultDTO.setPointAppliedPrice(pointAppliedPrice);

		return pointResultDTO;
	}

	// 주소 선택하기
	@PostMapping("/applyAddress.do")
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
	@GetMapping("/sellPaySuccess.do")
	public String sellPaySuccess(@RequestParam("order_id") int orderId, @RequestParam("coupon_id") int couponId,
			@RequestParam("point") int usedpoint, @RequestParam("finalPrice") int finalPrice) {

		OrderProdDTO orderProdDTO = orderProdService.selectById(orderId);
		// 구매 주문에 해당하는 주문 상세 목록들 가져오기
		List<Order_DetailDTO> orderDetailDTOs = orderDetailService.selectByOrder_Id(orderId);

		// 주문 상세 목록에 대한 반복문 수행
		for (Order_DetailDTO order_DetailDTO : orderDetailDTOs) {

			System.out.println("주문 상태 처리 전 orderDetail:" + order_DetailDTO);
			// 주문 상세의 주문 상태를 '결제완료'로 변경
			order_DetailDTO.setOrder_state("결제완료");
			System.out.println("주문 상태 처리 후 orderDetail:" + order_DetailDTO);

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

		// 고객 ID로 고객 정보 가져오기
		String customerID = orderProdDTO.getMember_id();
		CustomerDTO customerDTO = customerService.selectById(customerID);

		System.out.println(customerDTO);

		CouponDTO couponClue = new CouponDTO();
		couponClue.setCoupon_id(couponId);
		couponClue.setMember_id(customerID);

		// 사용한 쿠폰의 ID로 쿠폰 개수 1 줄이기
		CouponDTO couponDTO = couponService.selectById(couponClue);
		System.out.println("사용한 쿠폰:" + couponDTO);
		if (!Objects.isNull(couponDTO)) {
			int couponQuantity = couponDTO.getQuantity();
			couponDTO.setQuantity(couponQuantity - 1);

			int couponUpdateResult = couponService.couponUse(couponDTO);
		}

		// 보유 포인트, 멤버등급, 누적 구매액
		int point = customerDTO.getPoint();
		String member_level = customerDTO.getMember_level();
		int accum_amount = customerDTO.getAccum_amount();

		// 사용한 포인트를 보유 포인트에서 감소
		point = point - usedpoint;

		// 누적 구매액 갱신
		accum_amount = accum_amount + finalPrice;
		customerDTO.setAccum_amount(accum_amount);

		// 등급별 포인트 계산 후 적립
		double rate = 0.0;

		if ("Family".equals(member_level)) {
			rate = 0.001;
		} else if ("Bronze".equals(member_level)) {
			rate = 0.005;
		} else if ("Silver".equals(member_level)) {
			rate = 0.01;
		} else if ("Gold".equals(member_level)) {
			rate = 0.015;
		} else if ("Platinum".equals(member_level)) {
			rate = 0.02;
		}

		int upadatedPoint = point + (int) Math.round(finalPrice * rate);

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
	@GetMapping("/rentPaySuccess.do")
	public String rentPaySuccess(@RequestParam("rental_code") int rental_code, @RequestParam("coupon_id") int couponId,
			@RequestParam("point") int usedpoint, @RequestParam("finalPrice") int finalPrice) {

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

		// 고객 ID로 고객 정보 가져오기
		String customerID = rentDTO.getMember_id();
		CustomerDTO customerDTO = customerService.selectById(customerID);
		System.out.println("고객정보:"+customerDTO);

		CouponDTO couponClue = new CouponDTO();
		couponClue.setCoupon_id(couponId);
		couponClue.setMember_id(customerID);

		// 사용한 쿠폰의 ID로 쿠폰 개수 1 줄이기
		CouponDTO couponDTO = couponService.selectById(couponClue);
		System.out.println("사용한 쿠폰:" + couponDTO);
		if (!Objects.isNull(couponDTO)) {
			int couponQuantity = couponDTO.getQuantity();
			couponDTO.setQuantity(couponQuantity - 1);

			int couponUpdateResult = couponService.couponUse(couponDTO);
		}

		// 보유 포인트, 멤버등급, 누적 구매액
		int point = customerDTO.getPoint();
		String member_level = customerDTO.getMember_level();
		int accum_amount = customerDTO.getAccum_amount();

		// 사용한 포인트를 보유 포인트에서 감소
		point = point - usedpoint;

		// 누적 구매액 갱신
		accum_amount = accum_amount + finalPrice;
		customerDTO.setAccum_amount(accum_amount);

		// 등급별 포인트 계산 후 적립
		double rate = 0.0;

		if ("FAMILY".equals(member_level)) {
			rate = 0.001;
		} else if ("BRONZE".equals(member_level)) {
			rate = 0.005;
		} else if ("SILVER".equals(member_level)) {
			rate = 0.01;
		} else if ("GOLD".equals(member_level)) {
			rate = 0.015;
		} else if ("PLATINUM".equals(member_level)) {
			rate = 0.02;
		}

		int upadatedPoint = point + (int) Math.round(finalPrice * rate);

		customerDTO.setPoint(upadatedPoint);

		// 고객의 누적 구매액에 따라 등급 변경
		if (accum_amount >= 1000000) {
			customerDTO.setMember_level("PLATINUM");
		} else if (accum_amount >= 600000 && accum_amount < 1000000) {
			customerDTO.setMember_level("GOLD");
		} else if (accum_amount >= 300000 && accum_amount < 600000) {
			customerDTO.setMember_level("SILVER");
		} else if (accum_amount >= 100000 && accum_amount < 300000) {
			customerDTO.setMember_level("BRONZE");
		} else {
			customerDTO.setMember_level("FAMILY");
		}

		int customerUpdate = customerService.customerUpdate(customerDTO);

		return "customer/customerOrderSuccess";

	}

	// 구매 결제 취소
	@PostMapping("/cancelOrderPay.do")
	@ResponseBody
	public String cancelOrderPay(@RequestParam int order_id) {
		System.out.println("받아온 주문ID:" + order_id);
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

		// 대여 상세 삭제
		int rentDetailDelResult = rentDetailService.rentDetailDelByRentCode(rental_code);

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
