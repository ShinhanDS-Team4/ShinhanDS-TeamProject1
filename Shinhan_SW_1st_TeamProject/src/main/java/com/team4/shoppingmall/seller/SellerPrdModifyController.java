package com.team4.shoppingmall.seller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.apache.velocity.runtime.resource.loader.URLResourceLoader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team4.shoppingmall.admin_inq.Admin_InqService;
import com.team4.shoppingmall.buyer_inq.Buyer_InqService;
import com.team4.shoppingmall.member.MemberService;
import com.team4.shoppingmall.prod.ProdDTO;
import com.team4.shoppingmall.prod.ProdService;
import com.team4.shoppingmall.prod_image.Prod_ImageDTO;
import com.team4.shoppingmall.prod_image.Prod_ImageService;
import com.team4.shoppingmall.prod_option.Prod_OptionService;
import com.team4.shoppingmall.rent_prod_stock.RentProdStockDTO;
import com.team4.shoppingmall.rent_prod_stock.RentProdStockService;
import com.team4.shoppingmall.seller_prod_stock.Seller_Prod_StockDTO;
import com.team4.shoppingmall.seller_prod_stock.Seller_Prod_StockService;

@Controller
@RequestMapping("/seller")
public class SellerPrdModifyController {

	@Autowired
	Buyer_InqService buyer_inqService;

	@Autowired
	Admin_InqService admin_inqService;

	@Autowired
	MemberService memberService;

	@Autowired
	ProdService prodService;

	@Autowired
	Prod_OptionService optionService;

	@Autowired
	Prod_ImageService imageService;

	@Autowired
	Seller_Prod_StockService seller_Prod_StockService;

	@Autowired
	RentProdStockService rentProdStockService;

	String member_id = "573-50-00882";// 임시로 사용할 판매자ID(사업자등록번호)

	// 상품 이미지 파일 업로드 디렉토리
	// 1.메인 이미지 파일
	@Value("${file.main-img-upload-dir}")
	private String mainIMG_uploadDir;

	// 2.설명 이미지 파일
	@Value("${file.desc-img-upload-dir}")
	private String descIMG_uploadDir;

	@PostMapping("/resetMainProdImg")
	@ResponseBody
	public String resetMainProdImg(@RequestBody Map<String, Object> request) throws IOException {
		System.out.println("메인 사진 목록 삭제 작업 시작");
		String prod_id = (String) request.get("prodid");
		System.out.println("상품ID:" + prod_id);
		System.out.println(prod_id);

		List<String> imgIdList = imageService.findAllImgFileNameByProdID(prod_id);

		int imgDeleteResult = imageService.prod_imageDelete(prod_id);
		System.out.println("수행 완료");
		if (imgDeleteResult > 0) {
			for (String imgID : imgIdList) {

				Path filePath = Paths.get(mainIMG_uploadDir).resolve(imgID);
				Files.delete(filePath);

				System.out.println(imgID + "삭제 완료");
			}
		}

		return "resetImgSuccess";
	}

	@PostMapping("/resetDescProdImg")
	@ResponseBody
	public String resetDescProdImg(@RequestBody Map<String, Object> request) throws IOException {
		System.out.println("설명 사진 목록 삭제 작업 시작");
		String prod_id = (String) request.get("prodid");
		System.out.println("상품ID:" + prod_id);
		// String prod_id = "나이키%20반팔2_573-50-00882";
		System.out.println(prod_id);
		List<String> imgIdList = imageService.findAllImgFileNameByProdID(prod_id);

		int imgDeleteResult = imageService.prod_imageDelete(prod_id);
		System.out.println("수행 완료");
		if (imgDeleteResult > 0) {
			for (String imgID : imgIdList) {

				Path filePath = Paths.get(mainIMG_uploadDir).resolve(imgID);
				Files.delete(filePath);

				System.out.println(imgID + "삭제 완료");
			}
		}

		return "resetImgSuccess";
	}

	@PostMapping("updateStockInfo")
	public String updateStockInfo(
			@RequestParam("prdId") String prdID, 
			@RequestParam("prdPrice") int prdPrice, 
			@RequestParam("prdCategory") int prdCategory,
			@RequestParam("mainImgFile") List<MultipartFile> mainFiles, 
			@RequestParam("descImgFile") List<MultipartFile> descFiles, 
			@RequestParam("prdDescription") String prdDescription,
			@RequestParam("stockid") String stockid,
			@RequestParam("prdStock") int prdStock,
			RedirectAttributes redirectAttributes
			) throws UnsupportedEncodingException {
		String member_id = "573-50-00882";//판매자ID 임시, Session에서 받아올 것임
		
		String prod_id=URLDecoder.decode(prdID, "UTF-8");//상품ID
		String prd_desc=URLDecoder.decode(prdDescription,"UTF-8");//상품설명
		int prd_category = prdCategory;
		
		ProdDTO prodDTO = new ProdDTO();
		
		prodDTO.setProd_id(prod_id);
		prodDTO.setProd_desc(prd_desc);
		prodDTO.setCategory_id(prd_category);
		prodDTO.setProd_price(prdPrice);
		
		int prdUpdateResult = prodService.prodModify(prodDTO);
		
		// 상품이미지 등록은 메인 이미지 목록 등록 >> 설명 이미지 목록 등록 순으로 진행
		int mainfileIndex = 1; // 메인 이미지 파일 인덱스를 1로 초기화
		int descfileIndex = 1; // 설명 이미지 파일 인덱스를 1로 초기화
		
		
		//메인 사진 초기화 후 재등록
		if(!Objects.isNull(mainFiles)) {
			for (MultipartFile mainfile : mainFiles) {
				// 파일 타입 체크
				String contentType = mainfile.getContentType();
				System.out.println(contentType);
				if (!"image/jpeg".equals(contentType) && !"image/png".equals(contentType)) {
					redirectAttributes.addFlashAttribute("PrdRegisterResult", "이미지 파일이 아닙니다.");
					return "/seller/sellerPrdList";// 오류페이지로 리다이렉션(팀프로젝트에서는 alert으로 에러를 띄우고 판매자-물품 리스트로 리다이렉트)
				}

				//서버 컴퓨터의 디렉토리에 파일 저장
				
				//(1)메인이미지 파일
				try {
					// 파일명은 '상품명_판매자ID_mainimage_x'(x는 sequence)
					String filename = prod_id + "_mainimage_" + mainfileIndex+".png";
					Path filePath = Paths.get(mainIMG_uploadDir).resolve(filename);
					Files.createDirectories(filePath.getParent()); // 디렉토리가 존재하지 않으면 생성
					Files.write(filePath, mainfile.getBytes()); // 파일 저장

					// DB에 저장
					Prod_ImageDTO imageDTO = new Prod_ImageDTO();

					imageDTO.setImg_id(filename);//상품명_판매자ID_image_fileindex
					imageDTO.setProd_id(prod_id);//상품_판매자ID
					
					System.out.println(imageDTO);

					int prdMainImgRegResult = imageService.prod_imageInsert(imageDTO);

					mainfileIndex++;

				} catch (IOException e) {
					e.printStackTrace();
					redirectAttributes.addFlashAttribute("PrdRegisterResult", "상품 정보 업로드에 실패하였습니다.");
					return "/seller/sellerPrdList";// 오류페이지로 리다이렉션(팀프로젝트에서는 alert으로 에러를 띄우고 판매자-물품 리스트로 리다이렉트)
				}
			}
		}
		
		if(!Objects.isNull(descFiles)) {
			for (MultipartFile descfile : descFiles) {
				// 파일 타입 체크
				String contentType = descfile.getContentType();
				System.out.println(contentType);
				if (!"image/jpeg".equals(contentType) && !"image/png".equals(contentType)) {
					redirectAttributes.addFlashAttribute("PrdRegisterResult", "이미지 파일이 아닙니다.");
					return "/seller/sellerPrdList";// 오류페이지로 리다이렉션(팀프로젝트에서는 alert으로 에러를 띄우고 판매자-물품 리스트로 리다이렉트)
				}

				// 서버 컴퓨터의 디렉토리에 파일 저장
				try {
					// 파일명은 '상품명_판매자ID_descimage_x'(x는 sequence)
					String filename = prod_id + "_descimage_" + descfileIndex+".png";
					Path filePath = Paths.get(descIMG_uploadDir).resolve(filename);
					Files.createDirectories(filePath.getParent()); // 디렉토리가 존재하지 않으면 생성
					Files.write(filePath, descfile.getBytes()); // 파일 저장

					// DB에 저장
					Prod_ImageDTO imageDTO = new Prod_ImageDTO();

					imageDTO.setImg_id(filename);//상품명_판매자ID_image_fileindex
					imageDTO.setProd_id(prod_id);//상품_판매자ID
					
					System.out.println(imageDTO);

					int prdDescImgRegResult = imageService.prod_imageInsert(imageDTO);

					descfileIndex++;

				} catch (IOException e) {
					e.printStackTrace();
					redirectAttributes.addFlashAttribute("PrdRegisterResult", "상품 정보 업로드에 실패하였습니다.");
					return "/seller/sellerPrdList";// 오류페이지로 리다이렉션(팀프로젝트에서는 alert으로 에러를 띄우고 판매자-물품 리스트로 리다이렉트)
				}
			}
		}
		
		//재고ID-재고량 변경
		String stock_id = URLDecoder.decode(prdID, "UTF-8");
		if(stock_id.contains("_SELL_")) {//판매재고인 경우
			Seller_Prod_StockDTO seller_Prod_StockDTO = new Seller_Prod_StockDTO();
			seller_Prod_StockDTO.setS_stock_id(stock_id);
			seller_Prod_StockDTO.setStock(prdStock);
			
			int changeSellStock = seller_Prod_StockService.sellStockUpdate(seller_Prod_StockDTO);
		
		}
		else if(stock_id.contains("_RENT_")) {//대여재고인 경우
			RentProdStockDTO rentProdStockDTO = new RentProdStockDTO();
			rentProdStockDTO.setR_stock_id(stock_id);
			rentProdStockDTO.setStock(prdStock);
			
			int changeRentStock = rentProdStockService.rentStockUpdate(rentProdStockDTO);
		}
		
		redirectAttributes.addFlashAttribute("PrdRegisterResult", "상품 정보 최신화에 성공하였습니다.");
		return "/seller/sellerPrdList";// 성공 페이지로 리다이렉션(팀프로젝트에서는 판매자-물품 리스트로 리다이렉트) 
	}

}
