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
import org.springframework.web.bind.annotation.ResponseBody;

import com.team4.shoppingmall.order_prod.OrderProdDTO;
import com.team4.shoppingmall.order_prod.OrderProdDetailDTO;
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

	

	@GetMapping("/productlist.do")
	public String test1(Model model, HttpServletRequest request) {
		System.out.println("/customer/productlist.jsp"); 
		List<Map<String, Object>> prodAllOrders = prodService.selectAll2();
		model.addAttribute("prodAllOrders", prodAllOrders);

		return "customer/productlist";
	}

	
	
	@GetMapping("/rentlist.do")
	public String test2(Model model, HttpServletRequest request) {
		System.out.println("/customer/rentlist.jsp");

		
		List<RentDTO> rentAllOrders = rentService.selectAll();

	
		Map<Integer, Map<String, Object>> rentDetailsMap = new HashMap();

		
		for (RentDTO rent : rentAllOrders) {
			int rental_code = rent.getRental_code();
			Map<String, Object> rentDetails = rentService.selectById2(rental_code);
			rentDetailsMap.put(rental_code, rentDetails);
		}

		
		List<RentProdStockDTO> optionList = rentService.selectOptions();

		model.addAttribute("rentAllOrders", rentAllOrders);
		model.addAttribute("rentDetailsMap", rentDetailsMap);
		model.addAttribute("optionList", optionList);

		return "customer/rentlist";
	}

	
	@GetMapping("/orderlist.do")
	public String test3(Model model, HttpServletRequest request) {
		System.out.println("/customer/orderlist.jsp");

		List<OrderProdDTO> allorders = orderProdService.selectAll();

		Map<Integer, Map<String, Object>> orderDetailsMap = new HashMap();

		for (OrderProdDTO order : allorders) {
			int orderId = order.getOrder_id();
			List<OrderProdDetailDTO> orderDetails = orderProdService.selectById2(orderId);
			//orderDetailsMap.put(orderId, orderDetails);
		}

		model.addAttribute("allOrders", allorders);
		model.addAttribute("orderDetailsMap", orderDetailsMap);
		model.addAttribute("optionList", orderProdService.selectOptions());

		return "customer/orderlist";
	}

	@PostMapping("/cancel.do")
	@ResponseBody
	public String processCancel(@RequestParam("orderId") int orderId, HttpServletResponse response) throws IOException {
		
		
		int cancelSuccess = orderProdService.orderCancel(orderId);
		// boolean refundSuccess = true;
		String message = "";
		
		if (cancelSuccess>0) {
			//response.getWriter().write("success");
			message = "success";
			
			return message;
			
		} else {
			//response.getWriter().write("failure");
			message = "failure";
			return message;
		}
	}
	
	@PostMapping("/refund.do")
	@ResponseBody
	public String processRefund(@RequestParam("orderId") int orderId, HttpServletResponse response) throws IOException {
		
		int refundSuccess = orderProdService.orderRefund(orderId);
		// boolean refundSuccess = true;
		String message = "";
		
		if (refundSuccess>0) {
			//response.getWriter().write("success");
			message = "success";
			
			return message;
			
		} else {
			//response.getWriter().write("failure");
			message = "failure";
			return message;
		}
	}

}
