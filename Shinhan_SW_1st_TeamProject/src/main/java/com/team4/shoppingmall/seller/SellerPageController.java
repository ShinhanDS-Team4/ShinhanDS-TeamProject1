package com.team4.shoppingmall.seller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.team4.shoppingmall.admin_inq.Admin_InqDTO;
import com.team4.shoppingmall.admin_inq.Admin_InqService;
import com.team4.shoppingmall.buyer_inq.Buyer_InqDAOInterface;
import com.team4.shoppingmall.buyer_inq.Buyer_InqDTO;
import com.team4.shoppingmall.buyer_inq.Buyer_InqService;
import com.team4.shoppingmall.member.MemberService;
import com.team4.shoppingmall.order_detail.OrderUpdateReqDTO;
import com.team4.shoppingmall.order_detail.Order_DetailDTO;
import com.team4.shoppingmall.order_detail.Order_DetailService;
import com.team4.shoppingmall.prod.ProdService;
import com.team4.shoppingmall.prod_image.Prod_ImageDTO;
import com.team4.shoppingmall.prod_image.Prod_ImageService;
import com.team4.shoppingmall.prod_option.Prod_OptionDTO;
import com.team4.shoppingmall.prod_option.Prod_OptionService;
import com.team4.shoppingmall.rent.RentDTO;
import com.team4.shoppingmall.rent_detail.RentDetailDTO;
import com.team4.shoppingmall.rent_detail.RentDetailService;
import com.team4.shoppingmall.rent_prod_stock.RentProdStockDTO;
import com.team4.shoppingmall.rent_prod_stock.RentProdStockService;
import com.team4.shoppingmall.seller_prod_stock.StockUpdateDTO;
import com.team4.shoppingmall.seller_prod_stock.Seller_Prod_StockDTO;
import com.team4.shoppingmall.seller_prod_stock.Seller_Prod_StockService;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Controller
@RequestMapping("/seller")
public class SellerPageController {

	@Autowired
	Buyer_InqService buyer_inqService;

	@Autowired
	Admin_InqService admin_inqService;

	@Autowired
	MemberService memberService;

	@Autowired
	ProdService prodService;

	@Autowired
	Prod_ImageService imageService;

	@Autowired
	Seller_Prod_StockService seller_Prod_StockService;

	@Autowired
	RentProdStockService rentProdStockService;

	@Autowired
	Order_DetailService order_DetailService;

	@Autowired
	RentDetailService rentDetailService;

	@Autowired
	Prod_OptionService prod_OptionService;

	String member_id = "573-50-00882";// �엫�떆濡� �궗�슜�븷 �뙋留ㅼ옄ID(�궗�뾽�옄�벑濡앸쾲�샇)

	// �긽�뭹 �씠誘몄� �뙆�씪 �뾽濡쒕뱶 �뵒�젆�넗由�
	// 1.硫붿씤 �씠誘몄� �뙆�씪
	@Value("${file.main-img-upload-dir}")
	private String mainIMG_uploadDir;

	// 2.�꽕紐� �씠誘몄� �뙆�씪
	@Value("${file.desc-img-upload-dir}")
	private String descIMG_uploadDir;

	// 硫붿씤 �솕硫� 蹂댁뿬二쇨린
	@GetMapping("/MainPage.do")
	public String mainpage(Model model) {
		model.addAttribute("sellerInfo", memberService.selectById(member_id));

		// �뿬湲곗꽌 SQL臾몄쓣 �궗�슜�빐 model濡� �뜲�씠�꽣瑜� �걣�뼱�샂
		// �뿬湲곗뿉�뒗 �뙋留ㅼ옄媛� �뙋留ㅽ븯�뒗 �긽�뭹�뱾�쓽 �뙋留ㅻ웾 �뜲�씠�꽣瑜� �걣�뼱�삤怨�, �뜲�씠�꽣瑜� 洹몃옒�봽�솕�븯�뿬 �몴�쁽
		// model.addAttribute(result, flashMap);
		return "seller/sellerMain";
	}

	// �뙋留�&���뿬 �긽�뭹 �럹�씠吏� 蹂댁뿬二쇨린
	@GetMapping("/PrdList.do")
	public String prdList(Model model, Model model1, Model model2) {
		model.addAttribute("sellerInfo", memberService.selectById(member_id));
		
		// 판매 상품 리스트
		model1.addAttribute("stockSList", seller_Prod_StockService.findSellStockList(member_id));

		System.out.println("�뙋留ㅼ긽�뭹 由ъ뒪�듃 遺덈윭�샂");
		// ���뿬 �긽�뭹 由ъ뒪�듃
		model2.addAttribute("stockRList", rentProdStockService.findRentStockList(member_id));

		System.out.println("���뿬�긽�뭹 由ъ뒪�듃 遺덈윭�샂");

		return "/seller/sellerPrdList";
	}

	// �뙋留�&諛곗넚 �럹�씠吏� 蹂댁뿬二쇨린
	@GetMapping("/DeliveryList.do")
	public String deliveryList(Model model, Model model1, Model model2) {
		
		model.addAttribute("sellerInfo", memberService.selectById(member_id));

		// �뙋留�&諛곗넚 由ъ뒪�듃
		// 1.�뙋留� �긽�뭹 ���긽 二쇰Ц�긽�꽭由ъ뒪�듃
		System.out.println(order_DetailService.selectBySellerID(member_id));
		System.out.println(rentDetailService.selectBySellerID(member_id));

		model1.addAttribute("orderDetailList", order_DetailService.selectBySellerID(member_id));
		model2.addAttribute("rentDetailList", rentDetailService.selectBySellerID(member_id));
		return "/seller/sellerDelivery";
	}

	// �뙋留� 二쇰Ц �빆紐� �씪愿꾩쿂由�
	@PostMapping("/updateOrderStatus")
	@ResponseBody
	public String updateOrderStauts(@RequestBody OrderUpdateReqDTO request) {
		List<Integer> orderDetailIds = request.getOrderDetailIds();
		System.out.println(orderDetailIds);

		String status = request.getStatus();

		for (Integer orderDetail : orderDetailIds) {

			Order_DetailDTO order_DetailDTO = new Order_DetailDTO();

			order_DetailDTO.setOrderdetail_id(orderDetail);
			order_DetailDTO.setOrder_state(status);

			int statusUpdateResult = order_DetailService.orderDetailStatusUpdate(order_DetailDTO);
		}
		return "Update Success";
	}

	// �뙋留� 二쇰Ц �빆紐� �씪愿꾩궘�젣
	@PostMapping("/deleteOrderDetails")
	@ResponseBody
	public String deleteOrderDetails(@RequestBody OrderUpdateReqDTO request) {
		List<Integer> orderDetailIds = request.getOrderDetailIds();
		System.out.println(orderDetailIds);
		for (Integer orderDetail : orderDetailIds) {
			int orderDetailDelResult = order_DetailService.orderDetailDelete(orderDetail);
		}

		return "Delete Success";
	}

	// ���뿬 二쇰Ц �빆紐� �씪愿꾩쿂由�
	@PostMapping("/updateRentStatus")
	@ResponseBody
	public String updateRentStatus(@RequestBody OrderUpdateReqDTO request) {
		List<Integer> rentDetailIds = request.getOrderDetailIds();
		System.out.println("���뿬 �씪愿꾩쿂由� ���긽 紐⑸줉:" + rentDetailIds);

		String status = request.getStatus();

		for (Integer rentDetail : rentDetailIds) {

			RentDetailDTO rentDatilDTO = new RentDetailDTO();

			rentDatilDTO.setRentdetail_id(rentDetail);
			rentDatilDTO.setRent_state(status);

			int statusUpdateResult = rentDetailService.rentDetailStatusUpdate(rentDatilDTO);
		}
		return "Update Success";
	}

	// ���뿬 二쇰Ц �빆紐� �씪愿꾩궘�젣
	@PostMapping("/deleteRentDetails")
	@ResponseBody
	public String deleteRentDetails(@RequestBody OrderUpdateReqDTO request) {
		List<Integer> rentDetailIds = request.getOrderDetailIds();
		System.out.println(rentDetailIds);
		for (Integer rentDetail : rentDetailIds) {
			int rentDetailDelResult = rentDetailService.rentDetailDelete(rentDetail);
		}
		return "Delete Success";
	}
	
	@PostMapping("/deleteSellStocks")
	@ResponseBody
	public String deleteSellStocks(@RequestBody StockUpdateDTO request) {
		List<String> sellStockIds = request.getSellStockIds();
		for(String sellStockId : sellStockIds) {
			int sellStockDelResult = seller_Prod_StockService.seller_prod_stockDelete(sellStockId);
		}
		return "Delete Success";
	}
	@PostMapping("/deleteRentStocks")
	@ResponseBody
	public String deletesSellStocks(@RequestBody StockUpdateDTO request) {
		List<String> rentStockIds = request.getSellStockIds();
		for(String rentStockId : rentStockIds) {
			int rentStockDelResult = rentProdStockService.rentProdDelete(rentStockId);
		}
		return "Delete Success";
	}
	

	// 臾몄쓽 紐⑸줉 �럹�씠吏� 蹂댁뿬二쇨린
	@GetMapping("/Q&AList.do")
	public String qaList(Model model, Model model3, Model model4, HttpServletRequest request) {
		
		model.addAttribute("sellerInfo", memberService.selectById(member_id));
		
		// 구매자의 문의 목록
		System.out.println(buyer_inqService.selectInqList(member_id));
		model3.addAttribute("buyerQAList", buyer_inqService.selectInqList(member_id));
		// System.out.println(model1);
		model4.addAttribute("adminQAList", admin_inqService.selectByMemberId(member_id));

		return "/seller/sellerQ&dAList";
	}

	// �긽�뭹 �벑濡� �럹�씠吏�
	@GetMapping("/AddProduct.do")
	public String addProduct(Model model) {
		
		model.addAttribute("sellerInfo", memberService.selectById(member_id));
		return "/seller/seller_addPrd";
	}

	// �긽�뭹 �닔�젙 �럹�씠吏�
	@GetMapping("/ModifyProduct.do")
	public String modifyProduct(Model model,Model model1, Model model2, Model model3, Model model4, Model model5,
			@RequestParam("stock_id") String stockID) throws UnsupportedEncodingException {

		String stock_id = URLDecoder.decode(stockID, "UTF-8");// �븳湲�濡� 蹂��솚
		System.out.println("媛��졇�삩 stock_id:"+stock_id);

		// �옱怨쟅D媛� �뼱�뒓 �옱怨� �뀒�씠釉붿뿉 �냽�븯�뒗吏� �솗�씤
		Seller_Prod_StockDTO seller_Prod_StockDTO = seller_Prod_StockService.selectByStockId(stock_id);// �옱怨� �뜲�씠�꽣瑜� �쟾遺� �걣�뼱�샂
		System.out.println("�솗�씤寃곌낵:"+seller_Prod_StockDTO);
		if (Objects.isNull(seller_Prod_StockDTO)) {// ���뿬�긽�뭹 �옱怨좎씪 寃쎌슦
			RentProdStockDTO rentProdStockDTO = rentProdStockService.selectById(stock_id);// �옱怨좎쓽 湲곕낯 �젙蹂� �걣�뼱�삤湲�
			System.out.println("�옱怨쟅D:"+rentProdStockDTO);
			
			String ProdID = rentProdStockDTO.getProd_id();

			Prod_ImageDTO mainImageDTO = new Prod_ImageDTO();
			mainImageDTO.setProd_id(ProdID);
			mainImageDTO.setImg_type(0);

			Prod_ImageDTO descImageDTO = new Prod_ImageDTO();
			descImageDTO.setProd_id(ProdID);
			descImageDTO.setImg_type(1);

			// �빐�떦 �옱怨좎쓽 �긽�뭹ID�� �뿰�룞�릺�뼱 �엳�뒗 �긽�뭹�씠誘몄�ID(=�씠誘몄� �뙆�씪紐�) 紐⑸줉�쓣 媛��졇�삩�떎.
			List<String> prodMainImgList = imageService.findMainImgFileNameByProdID(mainImageDTO);
			List<String> prodDescImgList = imageService.findDescImgFileNameByProdID(descImageDTO);

			System.out.println(prodMainImgList);
			System.out.println(prodDescImgList);
			
			List<Integer> optionList = new ArrayList<Integer>();

			optionList.add(rentProdStockDTO.getOpt_id1());
			optionList.add(rentProdStockDTO.getOpt_id2());
			optionList.add(rentProdStockDTO.getOpt_id3());
			optionList.add(rentProdStockDTO.getOpt_id4());
			optionList.add(rentProdStockDTO.getOpt_id5());

			List<Prod_OptionDTO> optionDTOList = new ArrayList<Prod_OptionDTO>();

			for (Integer option : optionList) {
				System.out.println(option);
				if (!Objects.isNull(option)) {
					Prod_OptionDTO prod_OptionDTO = prod_OptionService.selectByOptionId(option);
					optionDTOList.add(prod_OptionDTO);
				}
			}

			model1.addAttribute("StockInfo", rentProdStockDTO);
			model2.addAttribute("ProductInfo", prodService.selectByProdId(ProdID));
			model3.addAttribute("ProdMainImgList", prodMainImgList);
			model4.addAttribute("ProdDescImgList", prodDescImgList);
			
			return "/seller/seller_RentStock_modifyPrd";
		} else {// �뙋留ㅼ긽�뭹 �옱怨좎씪 寃쎌슦
			String ProdID = seller_Prod_StockDTO.getProd_id();
			Prod_ImageDTO mainImageDTO = new Prod_ImageDTO();
			mainImageDTO.setProd_id(ProdID);
			mainImageDTO.setImg_type(0);

			Prod_ImageDTO descImageDTO = new Prod_ImageDTO();
			descImageDTO.setProd_id(ProdID);
			descImageDTO.setImg_type(1);

			// �빐�떦 �옱怨좎쓽 �긽�뭹ID�� �뿰�룞�릺�뼱 �엳�뒗 �긽�뭹�씠誘몄�ID(=�씠誘몄� �뙆�씪紐�) 紐⑸줉�쓣 媛��졇�삩�떎.
			List<String> prodMainImgList = imageService.findMainImgFileNameByProdID(mainImageDTO);
			List<String> prodDescImgList = imageService.findDescImgFileNameByProdID(descImageDTO);

			List<Integer> optionList = new ArrayList<Integer>();

			optionList.add(seller_Prod_StockDTO.getOpt_id1());
			optionList.add(seller_Prod_StockDTO.getOpt_id2());
			optionList.add(seller_Prod_StockDTO.getOpt_id3());
			optionList.add(seller_Prod_StockDTO.getOpt_id4());
			optionList.add(seller_Prod_StockDTO.getOpt_id5());

			List<Prod_OptionDTO> optionDTOList = new ArrayList<Prod_OptionDTO>();

			for (Integer option : optionList) {
				System.out.println(option);
				if (!Objects.isNull(option)) {
					Prod_OptionDTO prod_OptionDTO = prod_OptionService.selectByOptionId(option);
					optionDTOList.add(prod_OptionDTO);
				}
			}

			// System.out.println(uploadDir);
			model.addAttribute("sellerInfo", memberService.selectById(member_id));
			model1.addAttribute("StockInfo", seller_Prod_StockDTO);
			model2.addAttribute("ProductInfo", prodService.selectByProdId(ProdID));
			model3.addAttribute("ProdMainImgList", prodMainImgList);
			model4.addAttribute("ProdDescImgList", prodDescImgList);
			model5.addAttribute("optionList", optionDTOList);
			
			return "/seller/seller_SellStock_modifyPrd";
		}
	}

	// 援щℓ�옄臾몄쓽 �떟蹂� �뙘�뾽
	@GetMapping("/answerCustomer.do")
	public String answerCustomer(Model model, @RequestParam("buyer_inq_id") Integer buyer_inq_id,
			HttpServletRequest request) {
		System.out.println(buyer_inq_id);
		System.out.println(buyer_inqService.selectByInqIdFORseller(buyer_inq_id));

		System.out.println(buyer_inqService.selectByInqIdFORseller(buyer_inq_id));

		model.addAttribute("bqa", buyer_inqService.selectByInqIdFORseller(buyer_inq_id));

		return "/seller/seller_CustomerQAPopUp";
	}

	// 援щℓ�옄 臾몄쓽�뿉 �떟蹂�
	@PostMapping("/answerCustomer.do")
	@ResponseBody
	public String answerCquestion(@RequestParam("buyer_inq_id") Integer buyerInqId,
			/*
			 * @RequestParam("member_id") String memberId,
			 * 
			 * @RequestParam("buyer_inq_title") String questionTitle,
			 * 
			 * @RequestParam("buyer_inq_content") String buyerInqContent,
			 */
			@RequestParam("buyer_reply") String buyerReply) throws UnsupportedEncodingException {

		String buyer_reply = URLDecoder.decode(buyerReply, "UTF-8");

		System.out.println(buyer_reply);

		// �뾽濡쒕뱶 �궇吏�
		// �삤�뒛 �궇吏쒕�� LocalDate濡� 媛��졇�샂
		LocalDate localDate = LocalDate.now();

		// LocalDate瑜� java.sql.Date濡� 蹂��솚
		Date sqlDate = Date.valueOf(localDate);

		Buyer_InqDTO buyer_InqDTO = new Buyer_InqDTO();
		buyer_InqDTO.setBuyer_inq_id(buyerInqId);
		buyer_InqDTO.setBuyer_reply(buyer_reply);
		buyer_InqDTO.setBuyer_reply_date(sqlDate);

		System.out.println(buyer_InqDTO);

		int result = buyer_inqService.buyer_inqUpdate(buyer_InqDTO);
		System.out.println(result);
		return "Answer submitted successfully.";
	}

	// 愿�由ъ옄臾몄쓽 議고쉶 �뙘�뾽
	@GetMapping("/answerAdmin.do")
	public String answerAdmin(Model model, @RequestParam("admin_inq_id") Integer admin_inq_id) {
		model.addAttribute("aqa", admin_inqService.selectByInqId(admin_inq_id));
		return "/seller/seller_AdminAPopUp";
	}

	// 愿�由ъ옄臾몄쓽 �벑濡� �뙘�뾽
	@GetMapping("/addAdminQA.do")
	public String addAdminQA(Model model) {
		String member_id = "573-50-00882";// �엫�떆濡� �궗�슜�븷 �뙋留ㅼ옄ID(�궗�뾽�옄�벑濡앸쾲�샇)
		System.out.println("議고쉶 : " + memberService.selectById(member_id));
		model.addAttribute("aqa", memberService.selectById(member_id));
		return "/seller/seller_AdminQPopUp";
	}

	// 愿�由ъ옄�뿉寃� 臾몄쓽 �벑濡�
	@PostMapping("/addAdminQA.do")
	@ResponseBody
	public String registerStoAquestion(@RequestParam("member_id") String mid,
			@RequestParam("admin_inq_title") String StoAqTitle, @RequestParam("admin_inq_content") String StoAq)
			throws UnsupportedEncodingException {

		String member_id = URLDecoder.decode(mid, "UTF-8");
		String admin_inq_title = URLDecoder.decode(StoAqTitle, "UTF-8");
		String admin_inq_content = URLDecoder.decode(StoAq, "UTF-8");

		// �뾽濡쒕뱶 �궇吏�
		// �삤�뒛 �궇吏쒕�� LocalDate濡� 媛��졇�샂
		LocalDate localDate = LocalDate.now();

		// LocalDate瑜� java.sql.Date濡� 蹂��솚
		Date sqlDate = Date.valueOf(localDate);

		// 臾몄쓽ID �깮�꽦
		Integer qid = 12305;

		// �씠�썑�뿉 SQL臾몄쑝濡� DB�뿉 �벑濡�

		Admin_InqDTO admin_InqDTO = new Admin_InqDTO();
		admin_InqDTO.setAdmin_inq_id(qid);
		admin_InqDTO.setAdmin_inq_title(admin_inq_title);
		admin_InqDTO.setAdmin_inq_content(admin_inq_content);
		admin_InqDTO.setAdmin_inq_date(sqlDate);
		admin_InqDTO.setMember_id(member_id);

		int result = admin_inqService.admin_inqInsert(admin_InqDTO);
		System.out.println(result);
		return "Answer submitted successfully.";
	}

}