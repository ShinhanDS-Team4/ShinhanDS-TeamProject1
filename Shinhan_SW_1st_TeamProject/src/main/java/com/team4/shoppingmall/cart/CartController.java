package com.team4.shoppingmall.cart;


import java.util.List;
import java.util.Map;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Objects;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team4.shoppingmall.addr_list.Addr_ListDTO;
import com.team4.shoppingmall.addr_list.Addr_ListService;
import com.team4.shoppingmall.member.MemberDTO;
import com.team4.shoppingmall.order_detail.Order_DetailDTO;
import com.team4.shoppingmall.order_detail.Order_DetailService;
import com.team4.shoppingmall.order_prod.OrderProdDAOInterface;
import com.team4.shoppingmall.order_prod.OrderProdDTO;
import com.team4.shoppingmall.order_prod.OrderProdService;
import com.team4.shoppingmall.prod.ProdDTO;
import com.team4.shoppingmall.prod.ProdService;
import com.team4.shoppingmall.rent.RentDAOInterface;
import com.team4.shoppingmall.rent.RentDTO;
import com.team4.shoppingmall.rent.RentService;
import com.team4.shoppingmall.rent_detail.RentDetailDTO;
import com.team4.shoppingmall.rent_detail.RentDetailService;
import com.team4.shoppingmall.rent_prod_stock.RentProdStockDTO;
import com.team4.shoppingmall.rent_prod_stock.RentProdStockService;
import com.team4.shoppingmall.seller_prod_stock.Seller_Prod_StockDTO;
import com.team4.shoppingmall.seller_prod_stock.Seller_Prod_StockService;

import com.team4.shoppingmall.member.MemberDTO;

@Controller
@RequestMapping("/cart")
public class CartController {
	
	@Autowired
	CartService cartService;
	
	@Autowired
	OrderProdService orderProdService;
	
	@Autowired
	RentService rentService;
	
	@Autowired
	OrderProdDAOInterface orderprodDAO;
	
	@Autowired
	RentDAOInterface rentprodDAO;
	
	@Autowired
	Seller_Prod_StockService seller_Prod_StockService;
	
	@Autowired
	RentProdStockService rentProdStockService;
	
	@Autowired
	ProdService prodService;
	
	@Autowired
	Order_DetailService order_DetailService;
	
	@Autowired
	RentDetailService rentDetailService;
	
	@Autowired
	Addr_ListService addr_ListService;
  
  @GetMapping("/cart.do")
	public String cartPage(HttpSession session, Model model) {
		
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		String member_id = member.getMember_id();
		
		List<CartDTO> sellStockCartList = cartService.selectSellStockByMemberId(member_id);
		model.addAttribute("sellStockCartList", sellStockCartList);
		System.out.println("sellStockCartList=" + sellStockCartList);
		
		List<CartDTO> rentStockCartList =cartService.selectRentStockByMemberId(member_id);
		model.addAttribute("rentStockCartList", rentStockCartList);
		System.out.println("rentStockCartList=" + rentStockCartList);
		
		//판매 장바구니 상품 정보 모두 조회
		List<Map<String,Object>> cartProdInfo = cartService.selectSellCartProdInfo(member_id);
		model.addAttribute("cartProdInfo", cartProdInfo);
		System.out.println("cartProdInfo=" + cartProdInfo);
		//대여 장바구니 상품 정보 모두 조회
		List<Map<String,Object>> cartRentProdInfo = cartService.selectRentCartProdInfo(member_id);
		model.addAttribute("cartRentProdInfo", cartRentProdInfo);
		System.out.println("cartRentProdInfo=" + cartRentProdInfo);	
		
		//판매 장바구니 건수
		int countSellproduct = cartService.countSellCartList(member_id);
		model.addAttribute("countSellproduct", countSellproduct);
		//대여 장바구니 건수
		int countRentproduct = cartService.countRentCartList(member_id);
		model.addAttribute("countRentproduct", countRentproduct);
		
		return "cart/cart";
	}
	
	@PostMapping("/createOrder.do")
	@ResponseBody
	public OrderProdDTO createOrder(@RequestBody  List<Integer> cartIds, HttpSession session) {
		
		MemberDTO mem = (MemberDTO)session.getAttribute("member");
		String customerID = mem.getMember_id();
		
		//계정의 대표주소 가져오기
		Addr_ListDTO addr_ListDTO = addr_ListService.findMasterAddr(customerID);
		
		LocalDate localDate = LocalDate.now();
		// LocalDate로 현재 날짜를 받아와 SQL.Date로 전환
		Date sqlDate = Date.valueOf(localDate);
		
		//대여 항목과 주문 항목의 최대값을 각각 가져오기
		int maxOrder_id = orderprodDAO.sequenceOrderId()+1;
		
		//총 구매가
		int orderTotal_price = 0;
		
		//각 장바구니 ID에 대한 반복문 처리
		for(Integer cartId : cartIds) {
			CartDTO cartDTO = cartService.selectByCartId(cartId);
			
			String s_stock_ID = cartDTO.getS_stock_id();
			String r_stock_ID = cartDTO.getR_stock_id();
			Integer amount = cartDTO.getCart_amount();
			
			//장바구니 ID가 판매 상품을 가진 경우
			if(!Objects.isNull(s_stock_ID)&&Objects.isNull(r_stock_ID)) {
				//해당 상세 주문의 판매 재고의 가격을 알아냄
				Seller_Prod_StockDTO seller_Prod_StockDTO = seller_Prod_StockService.selectByStockId(s_stock_ID);
				ProdDTO prodDTO = prodService.selectByProdId(seller_Prod_StockDTO.getProd_id());
				
				//해당 재고에 대한 판매 상세 객체 생성
				Order_DetailDTO order_DetailDTO = new Order_DetailDTO();
				order_DetailDTO.setOrder_num(amount);
				order_DetailDTO.setOrder_id(maxOrder_id);
				order_DetailDTO.setOrder_product_price(prodDTO.getProd_price());
				order_DetailDTO.setS_stock_id(s_stock_ID);
				
				int price = amount * prodDTO.getProd_price();
				orderTotal_price += price;
				
				int ordDetailInsertResult = order_DetailService.orderDetailInsert(order_DetailDTO);
			}
		}
		
		OrderProdDTO orderProdDTO = new OrderProdDTO();
		orderProdDTO.setOrder_id(maxOrder_id);
		orderProdDTO.setOrder_date(sqlDate);
		orderProdDTO.setMember_id(customerID);
		orderProdDTO.setTotal_price(orderTotal_price);
		orderProdDTO.setAddr_num(addr_ListDTO.getAddr_num());//주소를 대표주소로 설정
		
		int orderInsertResult = orderprodDAO.orderprodInsert(orderProdDTO);
		
		return orderProdDTO;
	}
	
	
	@PostMapping("/createRent.do")
	@ResponseBody
	public RentDTO createRent(@RequestBody  List<Integer> cartIds, HttpSession session) {
		
		MemberDTO mem = (MemberDTO)session.getAttribute("member");
		String customerID = mem.getMember_id();
		
		LocalDate localDate = LocalDate.now();
		// LocalDate로 현재 날짜를 받아와 SQL.Date로 전환
		Date sqlDate = Date.valueOf(localDate);
		
		// 7일 뒤의 날짜를 LocalDate로 계산
		LocalDate futureDate = localDate.plusDays(7);
		
		// 7일 뒤의 날짜를 SQL Date로 전환
		Date sqlFutureDate = Date.valueOf(futureDate);
		
		//대여 항목과 주문 항목의 최대값을 각각 가져와서 1 더하기
		int maxRent_id = rentprodDAO.searchRentId()+1;
		
		//총 구매가
		int rentTotal_price = 0;
		
		//각 장바구니 ID에 대한 반복문 처리
		for(Integer cartId : cartIds) {
			CartDTO cartDTO = cartService.selectByCartId(cartId);
			
			String s_stock_ID = cartDTO.getS_stock_id();
			String r_stock_ID = cartDTO.getR_stock_id();
			Integer amount = cartDTO.getCart_amount();
			
			//장바구니 ID가 대여 상품을 가진 경우
			if(Objects.isNull(s_stock_ID)&&!Objects.isNull(r_stock_ID)) {
				//해당 상세 주뭉의 대여 재고 가격을 알아냄
				RentProdStockDTO rentProdStockDTO = rentProdStockService.selectById(r_stock_ID);
				ProdDTO prodDTO = prodService.selectByProdId(rentProdStockDTO.getProd_id());
				
				//해당 재고에 대한 대여 상세 객체 생성
				RentDetailDTO rentDetailDTO = new RentDetailDTO();
				rentDetailDTO.setRent_num(amount);
				rentDetailDTO.setRental_code(maxRent_id);
				rentDetailDTO.setRent_product_price(prodDTO.getProd_price());
				rentDetailDTO.setR_stock_id(r_stock_ID);
				
				int price = amount * prodDTO.getProd_price();
				rentTotal_price += price;
				
				int rentDetailInsertResult = rentDetailService.rentDetailInsert(rentDetailDTO);
			}
		}
		
		RentDTO rentDTO = new RentDTO();
		rentDTO.setRental_code(maxRent_id);
		rentDTO.setRent_start_date(sqlDate);
		rentDTO.setRent_end_date(sqlFutureDate);
		rentDTO.setMember_id(customerID);
		rentDTO.setTotal_rent_price(rentTotal_price);
		
		int rentInsertResult = rentprodDAO.rentInsert(rentDTO);
		
		return rentDTO;
			
	}
	
	@PostMapping("/deleteCart.do")
	@ResponseBody
	public String deleteCart(@RequestBody Integer request) {
		System.out.println(request);
		Integer cart_id = request;
		int cartDeleteResult = cartService.cartDelete(cart_id);
		
		if(cartDeleteResult>0) {
			return "cart Deleted";
		}
		else {
			return "delete Error";
		}
		
		
	}
	
	@PostMapping("/changeCartAmount.do")
	@ResponseBody
	public String changeCartAmount(@RequestBody CartAmountRequest cartAmountRequest) {
		int cartID = cartAmountRequest.getCart_id();
		int cartAmount = cartAmountRequest.getCart_amount();
		
		CartDTO cartDTO = cartService.selectByCartId(cartID);
		cartDTO.setCart_amount(cartAmount);
		
		int cartAmountUpdateResult = cartService.cartUpdate(cartDTO);
		
		
		if(cartAmountUpdateResult>0) {
			return "CartAmount Updated";
		}
		else {
			return "Update Error";
		}
	}
	
}
