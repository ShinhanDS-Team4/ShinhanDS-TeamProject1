package com.team4.shoppingmall.prodTest;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.team4.shoppingmall.buyer_inq.Buyer_InqDTO;
import com.team4.shoppingmall.buyer_inq.Buyer_InqService;
import com.team4.shoppingmall.cart.CartService;
import com.team4.shoppingmall.category.CategoryDTO;
import com.team4.shoppingmall.category.CategoryService;
import com.team4.shoppingmall.order_detail.Order_DetailService;
import com.team4.shoppingmall.order_prod.OrderProdService;
import com.team4.shoppingmall.prod.ProductNewVO;
import com.team4.shoppingmall.prod_option.Prod_OptionDTO;
import com.team4.shoppingmall.prod_optionTest.Prod_OptionTestService;
import com.team4.shoppingmall.rent.RentService;
import com.team4.shoppingmall.rent_detail.RentDetailService;
import com.team4.shoppingmall.rent_prod_stock.RentProdStockDTO;
import com.team4.shoppingmall.rent_prod_stock.RentProdStockService;
import com.team4.shoppingmall.reviews.ReviewsDTO;
import com.team4.shoppingmall.reviews.ReviewsService;
import com.team4.shoppingmall.seller_prod_stockTest.Seller_Prod_StockTestDTO;
import com.team4.shoppingmall.seller_prod_stockTest.Seller_Prod_StockTestService;

@Controller
@RequestMapping("/prod")
public class ProdTestController {
	
	
	@Autowired
	Seller_Prod_StockTestService seller_Prod_StockTestService; 
	
	@Autowired
	ProdTestService prodTestService; 
	
	@Autowired
	Prod_OptionTestService prod_OptionSerTestService; 
	
	@Autowired
	Buyer_InqService buyer_InqService; 
	
	@Autowired
	CartService cartService;
	
	@Autowired
	ReviewsService reviewsService;
	
	@Autowired
	RentService rentService;
	
	@Autowired
	RentProdStockService rentProdStockService;
	
	@Autowired
	RentDetailService rentDetailService; 
  
	@Autowired
	OrderProdService orderProdService;
	
	@Autowired
	Order_DetailService order_DetailService; 
	
	@Autowired
	CategoryService categoryService; 
	
	
	@GetMapping("/productlistTest")
	public void productList() {
		
	}
		
	/* 상품 상세 페이지 */
	@GetMapping("/product_detail")
	public void productDetail(String prod_id, Model model) throws JsonProcessingException {
		
		//나중에 삭제하기
		//prod_id = "논아이론 사틴 솔리드 드레스 셔츠 - 화이트_199-81-22242"; //대여재고없는상품 test
		prod_id = "자수 미니 원피스 - 화이트_199-81-21909";
		
		//상품의 정보와 옵션 조회
		//옵션명과 값 전부 조회
		ArrayList<Object> prod_Options = (ArrayList<Object>) prod_OptionSerTestService.selectAllOptionsByProdId(prod_id);
		model.addAttribute("prod_Options", prod_Options);
		 
		//판매 상품 옵션별 재고량 조회
		List<Seller_Prod_StockTestDTO> seller_prod_stockDTO = seller_Prod_StockTestService.selectSpsOptionByProdId(prod_id);
		model.addAttribute("seller_prod_stockDTO", seller_prod_stockDTO);
		ObjectMapper mapper = new ObjectMapper();
		String jsonText = mapper.writeValueAsString( seller_prod_stockDTO );
		model.addAttribute( "stockList", jsonText );

		//상품 정보 조회 (쿼리 수정)
		Map<String,Object> prod_detail_info = prodTestService.selectProdDetailInfoByProdId(prod_id);
		prod_detail_info.put("prod_id", prod_id); 
		model.addAttribute("prod_detail_info", prod_detail_info);
		
		//상품 카테고리 조회
		CategoryDTO category = categoryService.productCategoryByProdId(prod_id);
		model.addAttribute("category", category);
		
		//리뷰 평균과 리뷰 수
		ReviewsDTO reviewInfo = reviewsService.reviewAvgByProdId(prod_id); 
		model.addAttribute("reviewInfo", reviewInfo);
		
		//대여 상품 옵션별 재고량 조회
		List<RentProdStockDTO> rentStockList = rentProdStockService.selectRpsOptionByProdId(prod_id);
		model.addAttribute("rentStockList", rentStockList);
		ObjectMapper rentMapper = new ObjectMapper();
		String jsonTextRent = rentMapper.writeValueAsString( rentStockList );
		model.addAttribute( "rentStockList", jsonTextRent );
		
		/* 상품 전체 리뷰 목록 */			
		List<Map<String,String>> productReviews = reviewsService.selectAllProductReviewByProdId(prod_id);
		model.addAttribute("productReviews", productReviews);
		
		//리뷰 목록에 불러올 상품의 옵션 목록
		List<Prod_OptionDTO> prodOptions = prod_OptionSerTestService.productAllOptionsByProdId(prod_id);
		model.addAttribute("prodOptions", prodOptions);
		
		/* 상품 전체 문의 목록 */
		List<Buyer_InqDTO> buyer_inqList = buyer_InqService.selectByProdId(prod_id);
		model.addAttribute("buyer_inqList", buyer_inqList);
		
		//상품의 대여재고ID 조회 - 대여 버튼 활성화
		List<RentProdStockDTO> rentProductStockCheck = rentProdStockService.selectRentStockByProdId2(prod_id);
		model.addAttribute("rentProductStockCheck", rentProductStockCheck);
		
	}
	
	
  //장바구니 - 상품(판매)
	@PostMapping("/productCartInsert.do")
	@ResponseBody
	public int productCartInsert(String prod_id,
								 HttpServletRequest request, 
								 HttpSession session, 
								 Model model,
								 @RequestBody ProductNewVO prodVO) 
	{
		//session
		//MemberDTO member =  session.getAttribute("member");
		//String member_id = member.getMember_id();
        String member_id = "testid";
        prod_id = "";
        
        if(prodVO.getS_stock_id() == null || prodVO == null) {
    		return 0; 
		}
       
        
    int cart_amount = prodVO.getOrder_num();
		int sellProdCartInsert = cartService.cartInsert(prodVO, member_id, cart_amount);
		
		return sellProdCartInsert;
		
	}
	//장바구니 - 상품(대여)
	@PostMapping("/rentProductCartInsert.do")
	@ResponseBody
	public int rentProductCartInsert(String prod_id,
								 HttpServletRequest request, 
								 HttpSession session, 
								 Model model,
								 @RequestBody ProductNewVO prodVO) 
	{
		//session
		//MemberDTO member =  session.getAttribute("member");
		//String member_id = member.getMember_id();
        String member_id = "testid";
        prod_id = "";
        
        if(prodVO == null || prodVO.getR_stock_id() == null) {
    		return 0; 
		}
        
		int cartRentProductInsert = cartService.cartRentProductInsert(prodVO, member_id);
		
		return cartRentProductInsert;
		
	}
	    
	/* 구매하기 */ 
	//ProductNewVO 생성
	@PostMapping("/productOrderInsert.do")
	@ResponseBody
	public int productOrderInsert(HttpServletRequest request, 
								  Model model,
								  @RequestBody ProductNewVO prodVO,
								  HttpSession session) throws UnsupportedEncodingException
	{
    	//session
		//MemberDTO member =  session.getAttribute("member");
		//String member_id = member.getMember_id();
        String member_id = "testid";
        String prod_id = "";
		
      //재고 체크 (프론트에서 체크 했는데 백도 나중에 추가)
    	if(prodVO.getS_stock_id() == null || prodVO == null) {
    		return 0; 
		}
    	
		int productPrice = Integer.parseInt(prodVO.getProductPrice());
		int total_price = productPrice * prodVO.getOrder_num();   //주문 총금액
		
		//1.주문,주문상세 생성 (서비스에서 로직 처리)
		int orderProdInsert =  orderProdService.orderprodInsert(prodVO, total_price, member_id);
		
		return orderProdInsert; 
    }
	
	/* 대여하기 */
	@PostMapping("/rentProductOrderInsert.do")
	@ResponseBody
	public int rentProductOrderInsert(HttpServletRequest request, 
								  Model model,
								  @RequestBody ProductNewVO prodVO,
								  HttpSession session) 
	{
		//MemberDTO member =  session.getAttribute("member");
		//String member_id = member.getMember_id();
		String member_id = "testid";	 
        String prod_id = "";
        
        if(prodVO.getR_stock_id() == null || prodVO == null) {
        	return 0; 
        }
        
      
        int rentProdInsert = rentService.rentInsert2(prodVO, member_id);
        
        
        return rentProdInsert; 
        
	}

	
	/* 상품 문의하기 (구매자=>판매자) */
	@PostMapping(value = "/productQnaInsert.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String productQnaInsert( 
			@RequestParam("prod_id") String prod_id,
			@RequestParam String qnaTitle,	
			@RequestParam String qnaTestarea, 
			HttpSession session 
	){
		Buyer_InqDTO buyer_InqDTO = new Buyer_InqDTO();
		
		Map<String,String> buyer_inq_map = new HashMap<String,String>();
		
		//MemberDTO member =  session.getAttribute("member");
		//String member_id = member.getMember_id();
		String member_id = "testid";
		 prod_id = "자수 미니 원피스 - 화이트_199-81-21909";
		//prod_id = "논아이론 사틴 솔리드 드레스 셔츠 - 화이트_199-81-22242";
		
         buyer_inq_map.put("buyer_inq_title", qnaTitle); 
		 buyer_inq_map.put("buyer_inq_content", qnaTestarea); 
		 buyer_inq_map.put("member_id", member_id); 
		 buyer_inq_map.put("prod_id", prod_id); 
		 
		int result = buyer_InqService.buyer_inqInsert(buyer_inq_map);
		
		String message;
		
    if(result > 0) {
			message = "문의가 등록되었습니다.";
			
			return  message;		
			
		}else {
			message = "오류가 발생했습니다. 다시 시도해주세요.";
			return  message;
		}
		
	}
	
}