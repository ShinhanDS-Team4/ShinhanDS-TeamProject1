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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team4.shoppingmall.buyer_inq.Buyer_InqDTO;
import com.team4.shoppingmall.buyer_inq.Buyer_InqService;
import com.team4.shoppingmall.cart.CartDTO;
import com.team4.shoppingmall.cart.CartService;
import com.team4.shoppingmall.prod_optionTest.Prod_OptionTestService;
import com.team4.shoppingmall.reviews.ReviewsDTO;
import com.team4.shoppingmall.reviews.ReviewsService;
import com.team4.shoppingmall.seller_prod_stockTest.Seller_Prod_StockTestDTO;
import com.team4.shoppingmall.seller_prod_stockTest.Seller_Prod_StockTestService;

@Controller
@RequestMapping("/prod")
public class ProdTestController {
	
	@Autowired
	Seller_Prod_StockTestService seller_Prod_StockTestService; //판매 상품 재고
	
	@Autowired
	ProdTestService prodTestService;  //상품
	
	@Autowired
	Prod_OptionTestService prod_OptionSerTestService;  //상품 옵션
	
	@Autowired
	Buyer_InqService buyer_InqService; //구매자 문의(구매자-판매자)
	
	@Autowired
	CartService cartService; //장바구니
	
	@Autowired
	ReviewsService reviewsService; //리뷰
	
	/* 상품 목록 페이지 */
	@GetMapping("/productlistTest")
	public void productList() {
		
	}
		
	/* 상품 상세 페이지 */
	@GetMapping("/product_detail")
	public void productDetail(String prod_id, Model model) {
		
		//옵션명과 값 전부 조회
		List<Object> prod_Options = prod_OptionSerTestService.selectAllOptionsByProdId(prod_id);
		System.out.println("옵션 조회 : "+ prod_Options);
		model.addAttribute("prod_Options", prod_Options);
		
		//판매 상품 옵션별 재고량 조회
		List<Seller_Prod_StockTestDTO> seller_prod_stockDTO = seller_Prod_StockTestService.selectSpsOptionByProdId(prod_id);
		model.addAttribute("seller_prod_stockDTO", seller_prod_stockDTO);
		
		//상품 정보 조회
		List<Map<String,Object>> prod_detail_info = prodTestService.selectProdDetailInfoByProdId(prod_id);
		model.addAttribute("prod_detail_info", prod_detail_info);
		System.out.println("상품 상세 정보 조회 : "+ prod_detail_info);
		
		//System.out.println("---재고 데이터----");
		//System.out.println(seller_prod_stockDTO);
		
		
		/* 상품 리뷰 목록 */
		System.out.println("리뷰 목록~~ 상품id : " + prod_id);
		
		//상품id 받아오는 방법 다시 수정
		
		//주문상세id->재고id->해당 상품 id의 리뷰목록 조회	
		List<ReviewsDTO> productReviews = reviewsService.selectAllProductReviewByProdId(prod_id);
		model.addAttribute("productReviews", productReviews);
		
		System.out.println("리뷰 목록~~ : " + productReviews);
	}
	
	/* 장바구니 */
	//상품 선택한 옵션 값 저장하기 -> 장바구니로 insert
	@GetMapping(value = "/productCartInsert", produces = "text/plain;charset=utf-8")
	public @ResponseBody String productCartInsert(HttpServletRequest request) throws UnsupportedEncodingException {
		//선택된 옵션 값 확인 
		String param = request.getQueryString();
        System.out.println("Selected option: " + param);
        
        String message = null;
        
        if(param != null) {
        	System.out.println("(옵션존재)Selected option: " + param);
        	// color=white&size=L&quantity=1&discountPrice=40000&prod_id=%EB%82%98%EC%9D%B4%ED%82%A4%20%EB%B0%98%ED%8C%94_1234-1234
        	//{quantity=1, color=black, size=L, discountPrice=40000, prod_id=나이키 반팔_1234-1234}
            //color=black, size=L, prod_id=나이키 반팔_1234-1234
        	
			//param으로 넘어온 선택 옵션들 저장
        	HashMap<String, String> map = new HashMap<>(); //
        	HashMap<String, String> optionMap = new HashMap<>(); //옵션Map-키(옵션명):값(옵션값)
        	String[] propertis = param.split("&");
        	for(String pro: propertis) {
        		String[] keyValue = pro.split("=");
        		
        		map.put(keyValue[0], URLDecoder.decode(keyValue[1], "utf-8")); //상품ID의 한글을 decode
        		
        		//discountPrice는 장바구니에 필요없음(param으로 넘어올 필요없음) - 수정 필요
        		if(!keyValue[0].contains("quantity")&& !keyValue[0].contains("discountPrice") &&  !keyValue[0].contains("prod_id"))
        			optionMap.put(keyValue[0], keyValue[1]);
        	}
        	System.out.println(map);
        	
        	
        	//1.session에서 읽을 예정 - 회원ID
            String member_id = "testid";
           
            //2.재고id알아내기 
            String stockId = cartService.searchStockId(optionMap, map.get("prod_id"));
            
            //로그인 한 사람의 cart_id를 검색한다. 없으면 새로 만들고, 있으면 존재하는 cart_id를 사용한다. 
            if(stockId != null) {
            	//장바구니테이블에 Insert
            	//여기서 쓰인 cart_id=0은 의미없음. 시퀀스 사용중
            	CartDTO cartDTO = new CartDTO(0, member_id, stockId, null, Integer.parseInt(map.get("quantity")));
            	cartService.cartInsert(cartDTO);
            }
            
            message = "재고ID: "+ stockId + " , 장바구니로 이동";
            
        	return message; //장바구니 페이지 아직 연결 X
		}else {
			//선택한 옵션값이 null인 경우
			System.out.println("(옵션null)Selected option: " + param);
			message = "옵션을 선택해 주세요";
			return message;  
		}
	}
	
	
	//상품 선택한 옵션 값 저장하기 -> 주문페이지
	@GetMapping("/?")
	public void productOrderInsert(String productOption) {
		
		// 선택된 옵션 값 확인 
        //System.out.println("Selected option: " + productOption);
	}

	/* 대여 상품 */
	
	
	/* 상품 문의 */
	@GetMapping("/productQnaInsert")
	@ResponseBody
	public String productQnaInsert( 
			@RequestParam("qnaTitle") String qnaTitle,
			@RequestParam("qnaWriterName") String qnaWriterName, //확인 필요!
			@RequestParam("qnaTestarea") String qnaTestarea,
			HttpSession session) 
	{
		Buyer_InqDTO buyer_InqDTO = new Buyer_InqDTO();
		
		//로그인 회원 정보
		//MemberDTO member = session.getAttribute("");//회원 정보 변수 확인 후 수정 필요
		String writer = null;
		//if(member == null) {
		//	writer = "손님";	
		//}else {
		//	writer = member.getMember_id(); //회원id
		//}

		//업로드
		//확인 필요! (팝업창에 이름 입력이 있음.) 
		buyer_InqDTO.setMember_id(writer); //작성자 == 로그인한 회원?
		buyer_InqDTO.setBuyer_inq_content(qnaTestarea); //문의내용
		buyer_InqDTO.setBuyer_inq_title(qnaTitle);
		
		
		//Buyer_InA테이블 insert문
		int result = buyer_InqService.buyer_inqInsert(buyer_InqDTO);
		String message;
		if(result > 0) {
			message = "문의가 등록되었습니다.";
		}else {
			message = "오류가 발생했습니다. 다시 시도해주세요.";
		}
       
        return  "redirect:product_detail";		
	}
	
}
