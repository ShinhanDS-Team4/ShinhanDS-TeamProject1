package com.team4.shoppingmall.prodTest;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team4.shoppingmall.buyer_inq.Buyer_InqDTO;
import com.team4.shoppingmall.buyer_inq.Buyer_InqService;
import com.team4.shoppingmall.cart.CartDTO;
import com.team4.shoppingmall.cart.CartService;
import com.team4.shoppingmall.prod_option.Prod_OptionDTO;
import com.team4.shoppingmall.prod_optionTest.Prod_OptionTestService;
import com.team4.shoppingmall.rent_prod_stock.RentProdStockService;
import com.team4.shoppingmall.reviews.ReviewsService;
import com.team4.shoppingmall.seller_prod_stockTest.Seller_Prod_StockTestDTO;
import com.team4.shoppingmall.seller_prod_stockTest.Seller_Prod_StockTestService;

@Controller
@RequestMapping("/prod")
public class ProdTestController {
	
	/* ���߿� ����,DTO �� �̸����� Test����, ���� ���� �ű�� */
	
	@Autowired
	Seller_Prod_StockTestService seller_Prod_StockTestService; //�Ǹ� ��ǰ ���
	
	@Autowired
	ProdTestService prodTestService;  //��ǰ
	
	@Autowired
	Prod_OptionTestService prod_OptionSerTestService;  //��ǰ �ɼ�
	
	@Autowired
	Buyer_InqService buyer_InqService; //������ ����(������-�Ǹ���)
	
	@Autowired
	CartService cartService; //��ٱ���
	
	@Autowired
	ReviewsService reviewsService; //����
	
	@Autowired
	RentProdStockService rentProdStockService; //�뿩��ǰ��� ����
	
	/* ��ǰ ��� ������ */
	@GetMapping("/productlistTest")
	public void productList() {
		
	}
		
	/* ��ǰ �� ������ */
	@GetMapping("/product_detail")
	public void productDetail(String prod_id, Model model) {
		
		//���߿� �����ϱ�
		prod_id = "����Ű ����_1234-1234";
		
		/* ��ǰ�� ������ �ɼ� ��ȸ */
		//�ɼǸ�� �� ���� ��ȸ
		List<Object> prod_Options = prod_OptionSerTestService.selectAllOptionsByProdId(prod_id);
		System.out.println("�ɼ� ��ȸ : "+ prod_Options);
		model.addAttribute("prod_Options", prod_Options);
		
		//�Ǹ� ��ǰ �ɼǺ� ��� ��ȸ
		List<Seller_Prod_StockTestDTO> seller_prod_stockDTO = seller_Prod_StockTestService.selectSpsOptionByProdId(prod_id);
		model.addAttribute("seller_prod_stockDTO", seller_prod_stockDTO);

		//��ǰ ���� ��ȸ
		List<Map<String,Object>> prod_detail_info = prodTestService.selectProdDetailInfoByProdId(prod_id);
		model.addAttribute("prod_detail_info", prod_detail_info);
		
		System.out.println("��ǰ �� ���� ��ȸ : "+ prod_detail_info);
		System.out.println("---��� ������----");
		System.out.println(seller_prod_stockDTO);
		
		
		/* ��ǰ ��ü ���� ��� */		
		List<Map<String,String>> productReviews = reviewsService.selectAllProductReviewByProdId(prod_id);
		model.addAttribute("productReviews", productReviews);
		System.out.println("��ǰ ��ü ���� ��� : " + productReviews);
		
		//���� ��ǰ�� �ɼ� ���
		List<Prod_OptionDTO> prodOptions = prod_OptionSerTestService.productAllOptionsByProdId(prod_id);
		model.addAttribute("prodOptions", prodOptions);
		
		
		System.out.println("���� ��ǰ �ɼ� ��� : " + prodOptions);
		
		/* ��ǰ ��ü ���� ��� */
		List<Buyer_InqDTO> buyer_inqList = buyer_InqService.selectByProdId(prod_id);
		model.addAttribute("buyer_inqList", buyer_inqList);
		System.out.println("��ǰ ��ü ���� ��� : " + buyer_inqList);
		
	}
	
	/* ��ٱ��� */
	//��ǰ ������ �ɼ� �� �����ϱ� -> ��ٱ��Ϸ� insert
	@GetMapping(value = "/productCartInsert.do", produces = "text/plain;charset=utf-8")
	public @ResponseBody String productCartInsert(HttpServletRequest request) throws UnsupportedEncodingException {

		HttpSession session = request.getSession();
    	
		//���߿� �����ϱ�
		String prod_id = "����Ű ����_1234-1234";
		
    	//1.session���� ���� ���� 
        String member_id = "testid";
		//String memberId = (String) session.getAttribute("member_id"); ���߿� �ּ� Ǯ��
		
		//���õ� �ɼ� �� Ȯ�� 
		String param = request.getQueryString();
        System.out.println("Selected option(param): " + param);
        
        String message = null;
        
        //param�� null�� �ƴ� ���
        if(param != null) {
        	System.out.println("(�ɼ�����)Selected option: " + param);
        	/*
        	color=white&size=L&quantity=1&productPrice=40000&prod_id=%EB%82%98%EC%9D%B4%ED%82%A4%20%EB%B0%98%ED%8C%94_1234-1234
        	{quantity=1, color=black, size=L, productPrice=40000, prod_id=����Ű ����_1234-1234}
            color=black, size=L, prod_id=����Ű ����_1234-1234
        	*/
        	
			//(1)param���� �Ѿ�� ���� �ɼǵ� ����
        	HashMap<String, String> map = new HashMap<>(); 
        	HashMap<String, String> optionMap = new HashMap<>(); //�ɼ�Map-Ű(�ɼǸ�):��(�ɼǰ�)
        	String[] propertis = param.split("&");
        	for(String pro: propertis) {
        		String[] keyValue = pro.split("=");
        		
        		//��ǰID �ѱ� ���� �ذ� decode
        		map.put(keyValue[0], URLDecoder.decode(keyValue[1], "utf-8"));
        		
        		//discountPrice�� ��ٱ��Ͽ� �ʿ����(param���� �Ѿ�� �ʿ����) - ���� �ʿ�
        		//if(!keyValue[0].contains("quantity")&& !keyValue[0].contains("discountPrice") &&  !keyValue[0].contains("prod_id"))
        		if(!keyValue[0].contains("quantity")&& !keyValue[0].contains("productPrice") &&  !keyValue[0].contains("prod_id"))
        			optionMap.put(keyValue[0], keyValue[1]);
        	}
        	System.out.println("param���� �Ѿ�� ��ü �� map : " + map);
        	
           
            //2.�ɼǿ� �ش��ϴ� ��ǰ ���id (�ǸŻ�ǰ���)
            String sellStockId = cartService.searchStockId(optionMap, map.get("prod_id"));
            
            if(sellStockId != null) {
            	
                //1.select�� - ��ٱ��Ͽ� ���� ��ǰ �ִ��� ��ȸ
                Map<String,String> map2 = new HashMap<>();
                map2.put("member_id", member_id);
                map2.put("sellstock_id", sellStockId);
                
                CartDTO cartBySellstockDTO = cartService.selectCartBySellstock(map2);
            	
                if(cartBySellstockDTO != null) {
                	//2.update�� - ���� ��ǰ ���� �� ���� ������Ʈ 
                	
                	CartDTO cart = new CartDTO();
                	
                	//select�� ��ȸ�� ����� �ִ� cart_id�� �����ͼ� ����
                	cart.setCart_id(cartBySellstockDTO.getCart_id()); 
                	//cart_amount ���� ���� => ������ �ִ� cart_amount + ����(quantity)	
                	cart.setCart_amount(Integer.parseInt(map.get("quantity")));
                	
                	//int updateResult = cartService.updateCartBySellstock(cart);
                	cartService.updateCartBySellstock(cart);
                	
                } else {
                	//3.insert�� - ��ٱ��� ���̺� ���� ���
                	//���⼭ ���� cart_id = 0�� �ǹ̾���. ������ �����
                	CartDTO cartDTO = new CartDTO(0, member_id, sellStockId, Integer.parseInt(map.get("quantity")));
                	cartService.cartInsert(cartDTO);
                }
         
            }
            message = "��ٱ��Ͽ� ����Ǿ����ϴ�.";
            System.out.println("���ID: "+ sellStockId);
            
            return message; //��ٱ��� ������ ���� ���� X
            
        }else {//(2)param�� null�� ���
				System.out.println("(�ɼ�null)Selected option: " + param);
				message = "�ɼ��� ������ �ּ���";
				return message;  
			  }
    }
	    
	/* �����ϱ� */
	//��ǰ ������ �ɼ� �� �����ϱ� -> �ֹ�������
	//������ �� �Ŀ� �ֹ������̺� ����Ǵ°�? 
	//@GetMapping("/?")
	//public void productOrderInsert(String productOption) {
		
	//}

	/* ��ǰ �뿩 �������� üũ */
	@PostMapping("/isProductRentable")
	@ResponseBody
	public void isProductRentable(HttpServletRequest request) {
		
		String param = request.getQueryString();
		System.out.println("!!��ǰ �뿩 �ɼ�: " + param);
		
		//1.��ǰ�� �뿩��� �����ϴ��� ã��
		//(1)param���� �Ѿ�� ���� �ɼǵ� ����
    	HashMap<String, String> map = new HashMap<>(); 
    	HashMap<String, String> optionMap = new HashMap<>(); //�ɼ�Map-Ű(�ɼǸ�):��(�ɼǰ�)
    	String[] propertis = param.split("&");
    	for(String pro: propertis) {
    		String[] keyValue = pro.split("=");
    		
    		map.put(keyValue[0], keyValue[1]);
    		
    		if(!keyValue[0].contains("rent-prod-quantity")&& !keyValue[0].contains("rent_start_date") &&  !keyValue[0].contains("rent_end_date"))
    			optionMap.put(keyValue[0], keyValue[1]);
    	}
    	System.out.println("(�뿩)param���� �Ѿ�� ��ü �� map : " + map);
    	//{color=black, size=L, rent-prod-quantity=1, rent_start_date=2024-06-26, rent_end_date=2024-07-03}
    	
    	String prod_id = "����Ű ����_1234-1234";
       
        //2.�ɼǿ� �ش��ϴ� ��ǰ ���id (�ǸŻ�ǰ���)
        //String sellStockId = cartService.searchStockId(optionMap, map.get("prod_id"));
        //String rentStockId = rentProdStockService.selectRentStockByProdId(prod_id);
 
		//jsp���� �Է��� ���� �����ϱ�
		
		
	}
	
	
	/* �뿩�˾�â - �뿩�ϱ� ���� (�ֹ��������� �ѱ�) */
	//@PostMapping("/?")
	//public void test2() {}
	

	
	/* ��ǰ �����ϱ� (������=>�Ǹ���) */
	@PostMapping(value = "/productQnaInsert.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String productQnaInsert( 
			@RequestParam String qnaTitle,	//���� ����
			@RequestParam String qnaTestarea, //���� ����
			HttpSession session //session���� �α��� ���� �б�
	){
		Buyer_InqDTO buyer_InqDTO = new Buyer_InqDTO();
		
		Map<String,String> buyer_inq_map = new HashMap<String,String>();
		
		System.out.println("���� ����: "+qnaTitle);
		System.out.println("���� ����: "+qnaTestarea);
		
		
		/* ���ε� */
        //���� ���� 
        //buyer_InqDTO.setBuyer_inq_title(qnaTitle); 
        buyer_inq_map.put("buyer_inq_title", qnaTitle); 

        //���ǳ��� 
		//buyer_InqDTO.setBuyer_inq_content(qnaTestarea); 
		 buyer_inq_map.put("buyer_inq_content", qnaTestarea); 
		 
		//ȸ��ID �׽�Ʈ - �����δ� ���ǿ��� �����;� ��
		 String member_id = "testid";
		//String memberId = (String) session.getAttribute("member_id"); 
		 
		 buyer_inq_map.put("member_id", member_id); 
		 
		//��ǰID �׽�Ʈ - ���� prod_id ���� ������� ��
		 String prod_id = "����Ű ����_1234-1234";
		 buyer_inq_map.put("prod_id", prod_id); 
		
		 
		//insert�� - Buyer_InA���̺� 
		int result = buyer_InqService.buyer_inqInsert(buyer_inq_map);
		
		String message;
		
		if(result > 0) {
			message = "���ǰ� ��ϵǾ����ϴ�.";
			
			return  message;		
			
		}else {
			message = "������ �߻��߽��ϴ�. �ٽ� �õ����ּ���.";
			return  message;
		}
		
	}
	
}