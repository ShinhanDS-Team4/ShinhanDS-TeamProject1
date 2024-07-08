package com.team4.shoppingmall;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team4.shoppingmall.member.MemberDTO;
import com.team4.shoppingmall.order_prod.OrderProdDTO;
import com.team4.shoppingmall.order_prod.OrderProdDetailDTO;
import com.team4.shoppingmall.order_prod.OrderProdService;
import com.team4.shoppingmall.prod.ProdService;
import com.team4.shoppingmall.rent.RentDTO;
import com.team4.shoppingmall.rent.RentSelectDTO;
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
	
	@GetMapping("/yun")
	public String test5(Model model, HttpSession session) {
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		if(member != null) {
			model.addAttribute(member);
		}
		return "/yun";
	}

	@GetMapping("/productlist.do")
	public String test1(Model model, HttpServletRequest request) {
		System.out.println("/customer/productlist.jsp"); // ��� ��ǰ���
		List<Map<String, Object>> prodAllOrders = prodService.selectAll2();
		System.out.println(prodAllOrders);
		model.addAttribute("prodAllOrders", prodAllOrders);

		return "customer/productlist";
	}

	/*
	 * // ��ǰ���
	 * 
	 * @GetMapping("/productlist.do") public String
	 * productList(@RequestParam("category_id") int categoryId,
	 * 
	 * @RequestParam("category_name") String categoryName, Model model) {
	 * System.out.println("ī�װ�ID: " + categoryId);
	 * System.out.println("/customer/productlist.jsp"); // ���õ� ī�װ��� ��ǰ ���
	 * List<Map<String, Object>> prodAllOrders =
	 * prodService.selectByCategory(categoryId); System.out.println("���õ� ī�װ� ��ǰ���"
	 * + prodAllOrders); model.addAttribute("prodAllOrders", prodAllOrders);
	 * model.addAttribute("categoryName", categoryName); // ī�װ� �̸� �߰�
	 * 
	 * return "customer/productlist"; }
	 */

	@GetMapping("/rentlist")
	public String test2(Model model, HttpServletRequest request) {
	    System.out.println("/customer/rentlist.jsp");
	
	    // 모든 렌트 정보 가져오기
	    List<RentDTO> rentAllOrders = rentService.selectAll();
	    System.out.println("전체 렌트 목록: " + rentAllOrders);
	
	    // 렌트 상세 정보를 담을 Map
	    Map<Integer, List<RentSelectDTO>> rentDetailsMap = new HashMap<>();
	
	    // 각 렌트에 대한 상세 정보 가져오기
	    for (RentDTO rent : rentAllOrders) {
	        int rental_code = rent.getRental_code();
	        List<RentSelectDTO> rentDetails = rentService.selectById2(rental_code);
	        rentDetailsMap.put(rental_code, rentDetails);
	    }
	    System.out.println("렌트 상세 정보 목록: " + rentDetailsMap);
	
	    // 렌트 상품 옵션 리스트 가져오기
	    List<RentProdStockDTO> optionList = rentService.selectOptions();
	
	    model.addAttribute("rentAllOrders", rentAllOrders);
	    model.addAttribute("rentDetailsMap", rentDetailsMap);
	    model.addAttribute("optionList", optionList);
	
	    return "customer/rentlist";
	}



	// �뿩���
	@PostMapping("/cancelRent.do")
	@ResponseBody
	public String cancelRent(@RequestParam("rentalCode") int rentalCode, HttpServletResponse response) { 
		System.out.println("�뿩��û(�ֹ���ȣ): " + rentalCode);
		
		// �Ǹ��ڿ��� ��û������?
		
		int cancelSuccess = rentService.cancelRent(rentalCode);
		String message = "";
		
		if (cancelSuccess > 0) { 
			message = "success"; 
			return message; 
		} else { 
			message = "failure";
			return message;
		}
	}

	@PostMapping("/returnRent.do")
	@ResponseBody
	public String returnRent(@RequestParam("rentalCode") int rentalCode, HttpServletResponse response) {
		//System.out.println("대여코드: " + rentalCode);

		int returnSuccess = rentService.returnRent(rentalCode);
		String message = "";

		
		if (returnSuccess > 0) { 
			message = "success"; 
			return message; 
		} else { 
			message = "failure";
			return message;
		}
	}

	@GetMapping("/orderlist")
	public String test3(Model model) {
	    System.out.println("/customer/orderlist.jsp");

	    // 모든 주문 정보 가져오기
	    List<OrderProdDTO> allorders = orderProdService.selectAll();
	    System.out.println("전체 주문 목록: " + allorders);

	    // 주문 상세 정보를 담을 Map
	    Map<Integer, List<OrderProdDetailDTO>> orderDetailsMap = new HashMap<>();

	    // 각 주문에 대한 상세 정보 가져오기
	    for (OrderProdDTO order : allorders) {
	        int orderId = order.getOrder_id();
	        List<OrderProdDetailDTO> orderDetails = orderProdService.selectById2(orderId);
	        orderDetailsMap.put(orderId, orderDetails);
	    }
	    System.out.println("주문 상세 정보 목록: " + orderDetailsMap);

	    model.addAttribute("allOrders", allorders);
	    model.addAttribute("orderDetailsMap", orderDetailsMap);
	    model.addAttribute("optionList", orderProdService.selectOptions());

	    return "customer/orderlist";
	}

	@PostMapping("/cancel.do")
	@ResponseBody
	public String processCancel(@RequestParam("orderId") int orderId, HttpServletResponse response) throws IOException {


		int cancelSuccess = orderProdService.orderCancel(orderId); 

		String message = "";

		if (cancelSuccess > 0) { 
			message = "success"; 
			return message; 
		} else { 
			message = "failure";
			return message;
		}
	}

	
	@PostMapping("/refund.do")
	@ResponseBody
	public String processRefund(@RequestParam("orderId") int orderId, HttpServletResponse response) throws IOException {
		System.out.println("orderId: " + orderId);

		// �Ǹ��ڿ��� ȯ�ҿ�û ������

		int refundSuccess = orderProdService.orderRefund(orderId); 
		String message = "";

		if (refundSuccess > 0) { 
			message = "success"; 
			return message; 
		} else { 
			message = "failure";
			return message;
		}
	}
}
