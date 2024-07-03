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
	
	
	String customerID = "bih63879";// �ӽ� �� ID. Session���� �޾ƿ� ����

	

	// ��ǰ ���� ���� ������
	@GetMapping("/orderPay")
	public String orderPayPage(Model model1, Model model2, Model model3, Model model4, Model model5, Model model6) {
		Integer orderID = 1;// �ֹ�ID(�ӽ�), �����δ� �ֹ��ϱ� ��ư Ŭ�� �� �����Ǵ� �ֹ�ID�� �����´�.
		
		// �ֹ� �׸� ������ ��������
		OrderProdDTO orderProdDTO = orderProdService.selectById(orderID);

		// �� �ֹ� ���� ���
		List<Order_DetailDTO> orderDetailList = orderDetailService.selectByOrder_Id(orderID);

		// ȸ������
		MemberDTO memberDTO = memberService.selectById(customerID);
		
		// ȸ���� �ּ� ���
		List<Addr_ListDTO> addr_ListDTOs=addr_ListService.selectByMember_Id(customerID);

		// ȸ���� �ֹ� ȭ�鿡�� ��� ������ ���� ���
		List<CouponDTO> usableCouponList = couponService.selectCustomerCouponList(customerID);

		CustomerDTO customerDTO = customerService.selectById(customerID);
		System.out.println("���߰�����:"+customerDTO);
		model1.addAttribute("orderInfo", orderProdDTO);
		model2.addAttribute("orderDetailList", orderDetailList);
		model3.addAttribute("memberInfo", memberDTO);
		model4.addAttribute("couponList", usableCouponList);
		model5.addAttribute("customerInfo",customerDTO);
		model6.addAttribute("addrList", addr_ListDTOs);

		return "customer/customerPay";
	}
	
	// ��ǰ �뿩 ���� ������
	@GetMapping("/rentPay")
	public String rentPayPage(Model model1, Model model2, Model model3, Model model4, Model model5, Model model6) {
		Integer rental_code = 2;//�뿩ID(�ӽ�) �����δ� �뿩�ϱ� ��ư�� ������ �� �����Ǵ� �뿩ID�� �����´�.
		
		// �뿩 �׸� ������ ��������
		RentDTO rentDTO = rentService.selectById(rental_code);
		
		// �� �ֹ� ���� ���
		List<RentDetailDTO> rentDetailList = rentDetailService.selectByRental_code(rental_code);
		
		// ȸ������
		MemberDTO memberDTO = memberService.selectById(customerID);
		
		// ȸ���� �ּ� ���
		List<Addr_ListDTO> addr_ListDTOs=addr_ListService.selectByMember_Id(customerID);
		
		// ȸ���� �ֹ� ȭ�鿡�� ��� ������ ���� ���
		List<CouponDTO> usableCouponList = couponService.selectCustomerCouponList(customerID);
		
		CustomerDTO customerDTO = customerService.selectById(customerID);
		System.out.println("���߰�����:"+customerDTO);
		model1.addAttribute("rentInfo", rentDTO);
		model2.addAttribute("rentDetailList", rentDetailList);
		model3.addAttribute("memberInfo", memberDTO);
		model4.addAttribute("couponList", usableCouponList);
		model5.addAttribute("customerInfo",customerDTO);
		
		return "customer/rentPay";
	}

	@PostMapping("/applyRentCoupon")
	@ResponseBody
	public String applyRentCoupon(@RequestBody CouponRequestDTO couponRequestDTO) {
		
		String couponid = couponRequestDTO.getCouponid();
		int orderid = couponRequestDTO.getOrderid();
		
		if("���þ���".equals(couponid)) {
			return "Coupon applied";
		}else {
			// �ֹ� �׸� ������ ��������
			RentDTO rentDTO = rentService.selectById(orderid);
			int totalPrice = rentDTO.getTotal_rent_price();
			
			System.out.println("����ID:" + couponid);
			CouponDTO selectCouponDTO = couponService.selectById(couponid);
			
			System.out.println("��������:" + selectCouponDTO);
			double discountRate = selectCouponDTO.getDiscount_rate();
			
			int discountAmount = (int) Math.round(totalPrice * (discountRate / 100.0));
			
			int discountedPrice = totalPrice - discountAmount;
			
			System.out.println("����:" + discountAmount);
			System.out.println("���ΰ���:" + discountedPrice);
			
			int couponAmount = selectCouponDTO.getQuantity();
			selectCouponDTO.setQuantity(couponAmount-1);
			
			int couponUpdate = couponService.couponUse(selectCouponDTO);
			
			rentDTO.setTotal_rent_price(discountedPrice);
			
			int appliedResult = rentService.updateRent(rentDTO);
			
			return "Coupon applied";
		}
		
	}
	
	@PostMapping("/applyRentPoint")
	@ResponseBody
	public String applyRentPoint(@RequestBody PointRequestDTO pointRequestDTO) {
		int point = pointRequestDTO.getPoint();
		System.out.println("����� ����Ʈ:"+point);
		int orderid = pointRequestDTO.getOrderid();
		
		RentDTO rentDTO = rentService.selectById(orderid);
		int totalPrice = rentDTO.getTotal_rent_price();
		
		int pointAppliedPrice = totalPrice - point;
		System.out.println("����Ʈ ��� �� ������:"+pointAppliedPrice);
		
		rentDTO.setTotal_rent_price(pointAppliedPrice);
		
		int appliedResult = rentService.updateRent(rentDTO);
		
		CustomerDTO customerDTO = customerService.selectById(customerID);
		int existPoint = customerDTO.getPoint();
		customerDTO.setPoint(existPoint - point);
		
		int CustomerPointUpdate = customerService.customerUpdate(customerDTO);
		
		return "Point Used";
	}
	@PostMapping("/applyCoupon")
	@ResponseBody
	public String applyCoupon(@RequestBody CouponRequestDTO couponRequestDTO) {

		String couponid = couponRequestDTO.getCouponid();
		int orderid = couponRequestDTO.getOrderid();

		if("���þ���".equals(couponid)) {
			return "Coupon applied";
		}else {
			// �ֹ� �׸� ������ ��������
			OrderProdDTO orderProdDTO = orderProdService.selectById(orderid);
			int totalPrice = orderProdDTO.getTotal_price();
			
			System.out.println("����ID:" + couponid);
			CouponDTO selectCouponDTO = couponService.selectById(couponid);

			System.out.println("��������:" + selectCouponDTO);
			double discountRate = selectCouponDTO.getDiscount_rate();

			int discountAmount = (int) Math.round(totalPrice * (discountRate / 100.0));

			int discountedPrice = totalPrice - discountAmount;

			System.out.println("����:" + discountAmount);
			System.out.println("���ΰ���:" + discountedPrice);
			
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
		System.out.println("����� ����Ʈ:"+point);
		int orderid = pointRequestDTO.getOrderid();
		
		OrderProdDTO orderProdDTO = orderProdService.selectById(orderid);
		int totalPrice = orderProdDTO.getTotal_price();
		
		int pointAppliedPrice = totalPrice - point;
		System.out.println("����Ʈ ��� �� ������:"+pointAppliedPrice);
		
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
		System.out.println("�ֹ�����:"+orderProdDTO);
		orderProdDTO.setAddr_num(addr_num);
		
		int addrUpdateResult = orderProdService.orderprodUpdate(orderProdDTO);
		
		return "Address Saved";
	}

	// 구매 결제 완료 후 프로세스
	@GetMapping("/sellPaySuccess")
	public String sellPaySuccess(@RequestParam("order_id") Integer order_id) {
		
		List<Order_DetailDTO> orderDetailDTOs = orderDetailService.selectByOrder_Id(order_id);
		
		for (Order_DetailDTO order_DetailDTO : orderDetailDTOs) {
			
			//�ֹ� �� - ���¸� �����Ϸ�� ����
			order_DetailDTO.setOrder_state("결제완료");
			
			String s_stock_id = order_DetailDTO.getS_stock_id();
			
			Seller_Prod_StockDTO seller_Prod_StockDTO = seller_Prod_StockService.selectByStockId(s_stock_id);
			int currentStock = seller_Prod_StockDTO.getStock();
			int currentSell = seller_Prod_StockDTO.getTotal();
			
			//�ֹ� �󼼺� �ֹ� ���� �������
			int orderAmount= order_DetailDTO.getOrder_num();
			int orderPrice = order_DetailDTO.getOrder_product_price();
			
			int orderTotal = orderAmount*orderPrice;
			
			//�ش� ����� ��� 1 ����, �Ǹŷ� 1 ����
			seller_Prod_StockDTO.setStock(currentStock-orderAmount);
			seller_Prod_StockDTO.setTotal(currentSell+orderAmount);
			
			int updateOrderStatus = orderDetailService.orderDetailUpdate(order_DetailDTO);
			int updateStock = seller_Prod_StockService.seller_prod_stockUpdate(seller_Prod_StockDTO);
			
		}
		
		return "customer/customerOrderSuccess";
	}
	
	// 대여 결제 완료 후 프로세스
	@GetMapping("/rentPaySuccess")
	public String rentPaySuccess(@RequestParam("rental_code") Integer rental_code) {
		
		List<RentDetailDTO> rentDetailDTOs = rentDetailService.selectByRental_code(rental_code);
		
		for(RentDetailDTO rentDetailDTO : rentDetailDTOs) {

			//�뿩 �� - ���¸� ���� �Ϸ�� ����
			rentDetailDTO.setRent_state("결제완료");
			String r_stock_id = rentDetailDTO.getR_stock_id();
			
			//�ش� ����� ���� ��� ��������
			RentProdStockDTO rentProdStockDTO = rentProdStockService.selectById(r_stock_id);
			int currentStock=rentProdStockDTO.getStock();
			int currentRent=rentProdStockDTO.getTotal();
			
			//�ֹ� �󼼺� �ֹ� ���� �������
			int rentAmount= rentDetailDTO.getRent_num();
			int rentPrice = rentDetailDTO.getRent_product_price();
			
			int rentTotal = rentAmount*rentPrice;
			
			rentProdStockDTO.setStock(currentStock - rentAmount); 
			rentProdStockDTO.setTotal(currentRent + rentAmount); 
			
			int updateOrderStatus = rentDetailService.rentDetailUpdate(rentDetailDTO);
			int updateStock = rentProdStockService.rentProdUpdate(rentProdStockDTO);
			
		}
		
		return "customer/customerOrderSuccess";
	}

	// ���� �� ���� ������ ���� �����ݾ� �������
	@PostMapping("/preparePayment")
	@ResponseBody
	public String preparePayment(@RequestParam String merchantUid, @RequestParam int amount) {
		return paymentService.registerPaymentAmount(merchantUid, amount);
	}

	// ���� ���뿡 ���� ����
	@PostMapping("/verifyPayment")
	@ResponseBody
	public String verifyPayment(@RequestParam("imp_uid") String impUid,
			@RequestParam("merchant_uid") String merchantUid) {
		return paymentService.verifyPayment(impUid, merchantUid);
	}

}