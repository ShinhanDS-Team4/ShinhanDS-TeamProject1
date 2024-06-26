package com.team4.shoppingmall;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team4.shoppingmall.order_prod.OrderProdDTO;
import com.team4.shoppingmall.order_prod.OrderProdService;
import com.team4.shoppingmall.prod.ProdDTO;
import com.team4.shoppingmall.prod.ProdService;
import com.team4.shoppingmall.rent.RentDTO;
import com.team4.shoppingmall.rent.RentService;
import com.team4.shoppingmall.rent_prod_stock.RentProdStockDTO;

@Controller
@RequestMapping("/customer")
public class TestControllerYun { 
	
		@Autowired
		OrderProdService orderProdService;
		@Autowired
		RentService rentService;
		@Autowired
		ProdService prodService;
	
		// 상품목록
		@GetMapping("/productlist.do")
		public String test1(Model model, HttpServletRequest request) {
			System.out.println("/customer/productlist.jsp");  
			// 모든 상품목록
			List<Map<String, Object>> prodAllOrders = prodService.selectAll2();
			System.out.println("전체상품목록" + prodAllOrders);
			model.addAttribute("prodAllOrders", prodAllOrders);

			return "customer/productlist";   
		}
		
		// 대여목록
		@GetMapping("/rentlist.do")
		public String test2(Model model, HttpServletRequest request) {
			System.out.println("/customer/rentlist.jsp"); 
			
			// 모든 대여목록
			List<RentDTO> rentAllOrders = rentService.selectAll(); 
			System.out.println("전체대여내역" + rentAllOrders);
			
			// 주문별 상세목록 Map
	        Map<Integer, Map<String, Object>> rentDetailsMap = new HashMap();
			
	        // 각 주문에 대한 주문 상세 목록
	        for (RentDTO rent : rentAllOrders) {
	            int rental_code = rent.getRental_code();
	            Map<String, Object> rentDetails = rentService.selectById2(rental_code);
	            rentDetailsMap.put(rental_code, rentDetails);
	        }
	        System.out.println("각 상세대여내역" + rentDetailsMap);
	        
	        //각 상품의 모든 옵션
	        List<RentProdStockDTO> optionList = rentService.selectOptions();
			
			model.addAttribute("rentAllOrders", rentAllOrders);
			model.addAttribute("rentDetailsMap", rentDetailsMap);
			model.addAttribute("optionList", optionList);
			
			return "customer/rentlist";   
		}
		
		// 주문목록
		@GetMapping("/orderlist.do")
		public String test3(Model model, HttpServletRequest request) {
			System.out.println("/customer/orderlist.jsp");
			
			// 모든 주문목록
			List<OrderProdDTO> allorders = orderProdService.selectAll();
			System.out.println("전체주문내역" + allorders);  
			
			// 주문별 상세목록 Map
	        Map<Integer, Map<String, Object>> orderDetailsMap = new HashMap();
			
	        // 각 주문에 대한 주문 상세 목록
	        for (OrderProdDTO order : allorders) {
	            int orderId = order.getOrder_id();
	            Map<String, Object> orderDetails = orderProdService.selectById2(orderId);
	            orderDetailsMap.put(orderId, orderDetails);
	        }
			System.out.println("각 상세주문내역" + orderDetailsMap);
			
			model.addAttribute("allOrders", allorders);
			model.addAttribute("orderDetailsMap", orderDetailsMap);
			model.addAttribute("optionList", orderProdService.selectOptions());
			
			return "customer/orderlist";  
		} 
		
	    // 환불요청
	    @PostMapping("/refund.do")
	    public void processRefund(@RequestParam("orderId") int orderId, HttpServletResponse response) throws IOException {
	        System.out.println("환불요청(주문번호): " + orderId);
	        
	        //판매자에게 환불요청 보내기
	        
	        //boolean refundSuccess = orderProdService.processRefund(orderId);
	        boolean refundSuccess = true;
	        
	        if (refundSuccess) {
	            response.getWriter().write("success");
	        } else {
	            response.getWriter().write("failure");
	        }
	    }

		

}
