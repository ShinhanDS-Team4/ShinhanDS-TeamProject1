package com.team4.shoppingmall.prodTest;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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
import com.team4.shoppingmall.member.MemberDTO;
import com.team4.shoppingmall.order_detail.Order_DetailService;
import com.team4.shoppingmall.order_prod.OrderProdService;
import com.team4.shoppingmall.prod.ProdDTO;
import com.team4.shoppingmall.prod.ProdService;
import com.team4.shoppingmall.prod.ProductNewVO;
import com.team4.shoppingmall.prod_image.Prod_ImageDTO;
import com.team4.shoppingmall.prod_image.Prod_ImageService;
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
	

	/* Test패키지로 작업  */
	@Autowired
	Seller_Prod_StockTestService seller_Prod_StockTestService; 
	
	@Autowired
	ProdTestService prodTestService;  //ProdTest
	
	@Autowired
	ProdService prodService; 
	
	@Autowired
	Prod_OptionTestService prod_OptionTestService; 
	
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
  
  @Autowired
	Prod_ImageService imageService;
	
	@PostMapping("/getproductnumsbyctg")
	@ResponseBody
	public Integer getProductNumsByCtg(@RequestBody Map<String, Object> schInfo) {
		return prodTestService.searchNumsByBrndAndPrc(schInfo);
	}
	
	@PostMapping("/setproductbyctg")
	@ResponseBody
	public List<Map<String, Object>> setProductByCtg(@RequestBody Map<String, Object> schInfo) {
		final Integer productsPerPage = 24;
		
		Integer currentPg = (Integer) schInfo.get("currentPage");
		schInfo.put("start", productsPerPage*(currentPg-1));
		schInfo.put("end", productsPerPage*(currentPg)+1);
		
		List<Map<String, Object>> prdtLstByBrnd = prodTestService.searchByBrndAndPrc(schInfo);

		return prdtLstByBrnd;
	}
	
	@PostMapping("/headerctg")
	@ResponseBody
	public Map<String, List<CategoryDTO>> headerCtg(@RequestBody Map<String, Object> highest) {
		Map<String, List<CategoryDTO>> ctgsPerCtg = new HashMap<String, List<CategoryDTO>>();
		for(String high_ctg :highest.keySet()) {
			ctgsPerCtg.put(high_ctg, categoryService.selectByParentId((Integer) highest.get(high_ctg)));
		}
		return ctgsPerCtg;
	}
	
	@GetMapping("/setbrnds")
	public String getbrnds(Model model, Integer category_id, Integer brndPg, Integer is_lowest) {
		final Integer brndsPerPage = 20;
		
		Map<String, Integer> brndInfo = new HashMap<>();
		brndInfo.put("category_id", category_id);
		brndInfo.put("start", brndsPerPage*(brndPg-1));
		brndInfo.put("end", brndsPerPage*(brndPg)+1);
		brndInfo.put("is_lowest", is_lowest);
		
		List<String> brndsList = prodTestService.selectBrndsByCtgId(brndInfo);
		Integer totalBrnds = prodTestService.selectBrndsNumsByCtgId(brndInfo);
		
		model.addAttribute("brndsList", brndsList);
		model.addAttribute("totalBrnds", totalBrnds);
		
		return "/prod/setbrndresp";
	}
	
	@GetMapping("/productlist")
	public void productList(Model model, Integer shwCtgNum, Integer currentPg) {
		final Integer productsPerPage = 24;
		
		if(currentPg == null) {
			currentPg = 1;
		}
		
		if(shwCtgNum == null) {
			shwCtgNum = 11000000;
		}
		
		CategoryDTO currentCtg = categoryService.selectById(shwCtgNum);
		Map<String, Integer> beforeTrace = new HashMap<>();
		
		beforeTrace.put("category_id1", currentCtg.getCategory_id());
		beforeTrace.put("category_id2", currentCtg.getCategory_id()-currentCtg.getCategory_id()%100);
		beforeTrace.put("category_id3", currentCtg.getCategory_id()-currentCtg.getCategory_id()%10000);
		beforeTrace.put("category_id4", currentCtg.getCategory_id()-currentCtg.getCategory_id()%1000000);
		
		List<CategoryDTO> traceCtgs = categoryService.traceCurCtg(beforeTrace);
		model.addAttribute("currentCtg", currentCtg);
		model.addAttribute("traceCtgs", traceCtgs);
		
		Map<String, Integer> InfoForSelect = new HashMap<>();
		InfoForSelect.put("category_id", shwCtgNum);
		InfoForSelect.put("start", productsPerPage*(currentPg-1));
		InfoForSelect.put("end", productsPerPage*(currentPg)+1);
		
		List<Map<String, Object>> allProdByCtg;
		List<CategoryDTO> categoriesByCurCtg;
		Integer allProdNumsByCtg;
		
		if(currentCtg.getIs_lowest() == 0) {
			categoriesByCurCtg = categoryService.selectByParentId(shwCtgNum);
			allProdNumsByCtg = prodTestService.selectAllProdNumsByCurCtg(shwCtgNum);
			allProdByCtg = prodTestService.selectAllProdByCurCtg(InfoForSelect);			
		} else {
			categoriesByCurCtg = categoryService.selectByParentId(currentCtg.getParent_category_id());
			allProdNumsByCtg = prodTestService.selectProdNumsByLwstCtgId(shwCtgNum);
			allProdByCtg = prodTestService.selectProdByLwstCtgId(InfoForSelect);
		}
		
		model.addAttribute("categoriesByCurCtg", categoriesByCurCtg);
		model.addAttribute("allProdNumsByCtg", allProdNumsByCtg);
		model.addAttribute("allProdByCtg", allProdByCtg);
		model.addAttribute("currentPg", currentPg);
	}
		
	/* 상품 상세 페이지 */
	@GetMapping("/product_detail")
	public void productDetail(String prod_id, 
								Model model
								//,@RequestParam(value = "prod_id", required = false) String prod_id
								//,@RequestBody Map<String, Object> request 
	) throws JsonProcessingException {
		
		//나중에 삭제하기
		//prod_id = "여성 원피스_199-81-22245"; //사진연결
		//prod_id = "논아이론 사틴 솔리드 드레스 셔츠 - 화이트_199-81-22242"; //판매에 있고 ,대여재고없는상품 test
		prod_id = "[대여상품]원피스 - 화이트_222-81-77709"; //대여재고만 있는 상품	
		//prod_id = "세일러 셔츠-스카이블루_199-81-22361";
		prod_id = "자수 미니 원피스 - 화이트_199-81-21909"; //둘다 있는 상품
		
		//상품의 정보와 옵션 조회
		//옵션명과 값 전부 조회
		ArrayList<Object> prod_Options = (ArrayList<Object>) prod_OptionTestService.selectAllOptionsByProdId(prod_id);
		model.addAttribute("prod_Options", prod_Options);
		System.out.println("prod_Options="+prod_Options);
		
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
		
		System.out.println("prod_detail_info=" + prod_detail_info);
		System.out.println("�긽�뭹id=" + prod_id);
		
		//상품 카테고리 조회
		CategoryDTO category = categoryService.productCategoryByProdId(prod_id);
		model.addAttribute("category", category);
		
		//리뷰 평균과 리뷰 수
		ProdDTO prod = prodService.selectByProdId(prod_id);
		String prod_name = prod.getProd_name();
		Map<Integer, Integer> reviewInfo = reviewsService.reviewAvgByProdId(prod_name); 
		System.out.println(reviewInfo);
		model.addAttribute("reviewInfo", reviewInfo);
		
		//대여 상품 옵션별 재고량 조회
		List<RentProdStockDTO> rentStockList = rentProdStockService.selectRpsOptionByProdId(prod_id);
		model.addAttribute("rentStockList", rentStockList);
		ObjectMapper rentMapper = new ObjectMapper();
		String jsonTextRent = rentMapper.writeValueAsString( rentStockList );
		model.addAttribute( "rentStockList", jsonTextRent );
		
		/* 상품 전체 리뷰 목록 */		
		List<Map<String,String>> productReviews = reviewsService.selectAllProductReviewByProdName(prod_name);
		System.out.println(productReviews);
		model.addAttribute("productReviews", productReviews);
		
		//리뷰 목록에 불러올 상품의 옵션 목록
		List<Prod_OptionDTO> prodOptions = prod_OptionTestService.productAllOptionsByProdId(prod_id);
		model.addAttribute("prodOptions", prodOptions);
		System.out.println("prodOptions="+prodOptions);
		
		/* 상품 전체 문의 목록 */
		List<Buyer_InqDTO> buyer_inqList = buyer_InqService.selectByProdId(prod_id);
		model.addAttribute("buyer_inqList", buyer_inqList);
		
		//상품의 대여재고ID 조회 - 대여 버튼 활성화
		List<RentProdStockDTO> rentProductStockCheck = rentProdStockService.selectRentStockByProdId2(prod_id);
		model.addAttribute("rentProductStockCheck", rentProductStockCheck);
		
		//상품의 이미지
		Prod_ImageDTO imageDTO = new Prod_ImageDTO();
		//imageDTO.setImg_id("imageDTOforSearch");
		//imageDTO.setProd_id(prod_id);
		//imageDTO.setImg_type(0);
		
		//상품id로 전체 사진 조회
		List<Prod_ImageDTO> imgIdList = imageService.findAllImgsByProdID(prod_id);
		System.out.println("imgIdList" + imgIdList);
		
		//메인 사진들 조회
		List<Map<String,Object>> mainImgIdList = imageService.prodMainImgInfoByProdId(prod_id); 
		model.addAttribute("mainImgIdList", mainImgIdList);
		//상품 정보 사진 조회
		List<Map<String,Object>> subImgIdList = imageService.prodSubImgInfoByProdId(prod_id); 
		model.addAttribute("subImgIdList", subImgIdList);
		
		//상품 설명
		ProdDTO prodDesc = prodService.selectByProdId(prod_id);
		model.addAttribute("prodDesc", prodDesc);
		System.out.println("prodDesc=" + prodDesc);
	}
	

	// 로그인 여부 확인 
   @RequestMapping("/checkLoginStatus")
    public ResponseEntity<Map<String, Boolean>> checkLoginStatus(HttpSession session) {
        Map<String, Boolean> response = new HashMap<>();
        response.put("isLoggedIn", session.getAttribute("member") != null);
        return ResponseEntity.ok(response);
    }
   

   	//장바구니 - 상품(판매)
	@RequestMapping("/productCartInsert.do")
	@ResponseBody
	public Map<String, Object> productCartInsert(String prod_id,
								 HttpServletRequest request, 
								 HttpSession session, 
								 Model model,
								 @RequestBody ProductNewVO prodVO) 
	{
		
		Map<String, Object> response = new HashMap<>();
		
		//session
		MemberDTO member =  (MemberDTO) session.getAttribute("member");
		String member_id = member.getMember_id();
		prod_id = prodVO.getProd_id();
        
        if(prodVO.getS_stock_id() == null || prodVO == null) {
    		return response; 
		}
       
        try {
        	//판매상품 장바구니ID
	        int cart_amount = prodVO.getOrder_num();
			int cart_id = cartService.cartInsert(prodVO, member_id, cart_amount);
			response.put("status", "success");
	        response.put("cart_id", cart_id);
        }catch (Exception e) {
       	 	 response.put("status", "error");
	         response.put("message", e.getMessage());
        }
		
		return response;
		
	}
	//장바구니 - 상품(대여)
	@RequestMapping("/rentProductCartInsert.do")
	@ResponseBody
	public Map<String, Object> rentProductCartInsert(String prod_id,
									 HttpServletRequest request, 
									 HttpSession session, 
									 Model model,
									 @RequestBody ProductNewVO prodVO) 
	{
		
		Map<String, Object> response = new HashMap<>();
		
		//session
		MemberDTO member =  (MemberDTO) session.getAttribute("member");
		String member_id = member.getMember_id();
        prod_id = prodVO.getProd_id();
        
        if(prodVO == null || prodVO.getR_stock_id() == null) {
    		return response; 
		}
        
        try {
        	//장바구니ID - 대여상품
        	int rentCartId = cartService.cartRentProductInsert(prodVO, member_id);
        	response.put("status", "success");
	        response.put("rentCartId", rentCartId);
        }catch (Exception e) {
        	 response.put("status", "error");
 	         response.put("message", e.getMessage());
		}
		
		return response;		
	}
	    
	/* 구매하기 */ 
	//ProductNewVO 생성
	@RequestMapping("/productOrderInsert.do")
	@ResponseBody
	public Map<String, Object> productOrderInsert(HttpServletRequest request, 
								  Model model,
								  @RequestBody ProductNewVO prodVO,
								  HttpSession session) throws UnsupportedEncodingException
	{
		
		Map<String, Object> response = new HashMap<>();
		 
    	//session
		MemberDTO member =  (MemberDTO) session.getAttribute("member");
		String member_id = member.getMember_id();
        String prod_id = prodVO.getProd_id();
        System.out.println("援щℓ�븯湲곗긽�뭹id=" + prod_id);
        
        //재고 체크 (프론트에서 체크 했는데 백도 나중에 추가)
    	if(prodVO.getS_stock_id() == null || prodVO == null) {
    		  return response;  
		}
    	
		int productPrice = Integer.parseInt(prodVO.getProductPrice());
		int total_price = productPrice * prodVO.getOrder_num();   //二쇰Ц 珥앷툑�븸
		
		//1.주문,주문상세 생성 (서비스에서 로직 처리)
	    try {
	    	//1.주문,주문상세 생성 (서비스에서 로직 처리)
	        int order_id = orderProdService.orderprodInsert(prodVO, total_price, member_id);

	        response.put("status", "success");
	        response.put("order_id", order_id);
	    } catch (Exception e) {
	        response.put("status", "error");
	        response.put("message", e.getMessage());
	    }

	    return response; 
    }
	
	/* 대여하기 */
	@RequestMapping("/rentProductOrderInsert.do")
	@ResponseBody
	public Map<String, Object> rentProductOrderInsert(HttpServletRequest request, 
								  Model model,
								  @RequestBody ProductNewVO prodVO,
								  HttpSession session) 
	{
		Map<String, Object> response = new HashMap<>();
		
		//session
		MemberDTO member =  (MemberDTO) session.getAttribute("member");
		String member_id = member.getMember_id();
        String prod_id = prodVO.getProd_id();
        
        
        if(prodVO.getR_stock_id() == null || prodVO == null) {
        	return response; 
        }
        
        try {
        	//대여 생성 후 대여id 반환 (서비스에서 로직 처리)
        	int rental_code = rentService.rentInsert2(prodVO, member_id);
        	response.put("status", "success");
	        response.put("rental_code", rental_code);
        } catch (Exception e) {
	        response.put("status", "error");
	        response.put("message", e.getMessage());
	    }
        
        
        return response; 
        
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
		
		MemberDTO member =  (MemberDTO) session.getAttribute("member");
		String member_id = member.getMember_id();
		
		
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