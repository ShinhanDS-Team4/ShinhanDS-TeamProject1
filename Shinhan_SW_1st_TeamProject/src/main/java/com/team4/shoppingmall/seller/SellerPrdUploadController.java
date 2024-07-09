package com.team4.shoppingmall.seller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Blob;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team4.shoppingmall.category.CategoryDTO;
import com.team4.shoppingmall.category.CategoryService;
import com.team4.shoppingmall.member.MemberDTO;
import com.team4.shoppingmall.prod.ProdDTO;
import com.team4.shoppingmall.prod.ProdService;
import com.team4.shoppingmall.prod_image.Prod_ImageDTO;
import com.team4.shoppingmall.prod_image.Prod_ImageService;
import com.team4.shoppingmall.prod_option.Prod_OptionDTO;
import com.team4.shoppingmall.prod_option.Prod_OptionService;
import com.team4.shoppingmall.rent_prod_stock.RentProdStockDTO;
import com.team4.shoppingmall.rent_prod_stock.RentProdStockService;
import com.team4.shoppingmall.seller_prod_stock.Seller_Prod_StockDTO;
import com.team4.shoppingmall.seller_prod_stock.Seller_Prod_StockService;

import retrofit2.http.Multipart;

@Controller
@RequestMapping("/seller")
public class SellerPrdUploadController {

	private JdbcTemplate jdbcTemplate;

	@Autowired
	ProdService prodService;

	@Autowired
	Prod_ImageService imageService;

	@Autowired
	Prod_OptionService optionService;

	@Autowired
	Seller_Prod_StockService seller_Prod_StockService;

	@Autowired
	RentProdStockService rentProdStockService;

	@Autowired
	CategoryService categoryService;

	//상품 이미지 파일 업로드 디렉토리
	//1.메인 이미지 파일
	@Value("${file.main-img-upload-dir}")
	private String mainIMG_uploadDir;
	
	//2.설명 이미지 파일
	@Value("${file.desc-img-upload-dir}")
	private String descIMG_uploadDir;
	
	
	//선택한 상품에 대해서 다음 항목들 찾기
	@PostMapping("/find2ndCategoryList.do")
	@ResponseBody
	public List<CategoryDTO> findNextCategoryList(@RequestBody Integer categoryID) {
		System.out.println("받은 카테고리 ID : "+categoryID);
		
		CategoryDTO categoryDTO = new CategoryDTO();
		
		categoryDTO.setCategory_id(0);
		categoryDTO.setCategory_depth(2);
		categoryDTO.setParent_category_id(categoryID);
		
		List<CategoryDTO> categoryList = categoryService.categoryListBydepth(categoryDTO);
		System.out.println(categoryList);
		
		return categoryList;
		
	}
	
	//선택한 상품에 대해서 다음 항목들 찾기
	@PostMapping("/find3rdCategoryList.do")
	@ResponseBody
	public List<CategoryDTO> find3rdCategoryList(@RequestBody Integer categoryID) {
		System.out.println("받은 카테고리 ID : "+categoryID);
		
		CategoryDTO categoryDTO = new CategoryDTO();
		
		categoryDTO.setCategory_id(0);
		categoryDTO.setCategory_depth(3);
		categoryDTO.setParent_category_id(categoryID);
		
		List<CategoryDTO> categoryList = categoryService.categoryListBydepth(categoryDTO);
		System.out.println(categoryList);
		
		return categoryList;
		
	}
	
	@PostMapping("/find4thCategoryList.do")
	@ResponseBody
	public List<CategoryDTO> find4thCategoryList(@RequestBody Integer categoryID) {
		System.out.println("받은 카테고리 ID : "+categoryID);
		
		CategoryDTO categoryDTO = new CategoryDTO();
		
		categoryDTO.setCategory_id(0);
		categoryDTO.setCategory_depth(4);
		categoryDTO.setParent_category_id(categoryID);
		
		List<CategoryDTO> categoryList = categoryService.categoryListBydepth(categoryDTO);
		System.out.println(categoryList);
		
		return categoryList;
		
	}


	@PostMapping("/uploadPrd")
	public String handleFileUpload(
			@RequestParam("prdType") String prdType,
			@RequestParam("prdName") String prdName,
			@RequestParam("prdPrice") int prdPrice, 
			@RequestParam("finalCategory") int prdCategory,
			@RequestParam("mainImgFile") List<MultipartFile> mainFiles, 
			@RequestParam("descImgFile") List<MultipartFile> descFiles, 
			@RequestParam("prdDescription") String prdDescription,
			@RequestParam("optName") List<String> optNames, @RequestParam("optValue") List<String> optValues,
			@RequestParam("prdStock") int prdStock, RedirectAttributes redirectAttributes, HttpSession session)
			throws UnsupportedEncodingException {

		MemberDTO mem = (MemberDTO)session.getAttribute("member");
		String sellerID = mem.getMember_id();
		//String member_id = "573-50-00882";

		String productType = URLDecoder.decode(prdType, "UTF-8");
		String productName = URLDecoder.decode(prdName, "UTF-8");
		// String productCategory = URLDecoder.decode(prdCategory,"UTF-8");
		String productDescription = URLDecoder.decode(prdDescription, "UTF-8");

		System.out.println(productType);
		System.out.println(productName);
		// System.out.println(productCategory);
		System.out.println(productDescription);

		List<String> fileUrls = new ArrayList<>();

		
		LocalDate localDate = LocalDate.now();

		// LocalDate로 현재 날짜를 받아와 SQL.Date로 전환
		Date sqlDate = Date.valueOf(localDate);

		
		String prod_id = productName + "_" + sellerID; 

		System.out.println("상품ID : " + prod_id);


		ProdDTO prodDTO = new ProdDTO();
				
		prodDTO = prodService.selectByProdId(prod_id);
		
		System.out.println(prodDTO);

		if (Objects.isNull(prodDTO)) {
		
			ProdDTO prodDTO2 = new ProdDTO();
			
			prodDTO2.setProd_id(prod_id);
			prodDTO2.setProd_name(productName);
			prodDTO2.setProd_desc(prdDescription);
			prodDTO2.setProd_price(prdPrice);
			prodDTO2.setProd_added_date(sqlDate);
			prodDTO2.setCategory_id(prdCategory);
			prodDTO2.setMember_id(sellerID);

			int prdRegResult = prodService.prodInsert(prodDTO2);
			System.out.println(prdRegResult);

			

			// 2.상품 이미지(PROD_IMAGE) 테이블 데이터 저장
			// 상품이미지 등록은 메인 이미지 목록 등록 >> 설명 이미지 목록 등록 순으로 진행
			int mainfileIndex = 1; // 메인 이미지 파일 인덱스를 1로 초기화
			int descfileIndex = 1; // 설명 이미지 파일 인덱스를 1로 초기화

			for (MultipartFile mainfile : mainFiles) {
				// 파일 타입 체크
				String contentType = mainfile.getContentType();

				System.out.println(contentType);
				if (!"image/jpeg".equals(contentType) && !"image/png".equals(contentType)) {
					redirectAttributes.addFlashAttribute("PrdRegisterResult", "이미지 파일이 아닙니다.");
					return "/seller/sellerPrdList";		
        }


				//서버 컴퓨터의 디렉토리에 파일 저장
				//(1)메인이미지 파일
				try {
					// 파일명은 '상품명_판매자ID_image_x'(x는 sequence)
					String filename = prod_id + "_image_" + mainfileIndex+".png";
					Path filePath = Paths.get(mainIMG_uploadDir).resolve(filename);
					Files.createDirectories(filePath.getParent()); // �뵒�젆�넗由ш� 議댁옱�븯吏� �븡�쑝硫� �깮�꽦
					Files.write(filePath, mainfile.getBytes()); // �뙆�씪 ���옣

					// DB에 저장
					Prod_ImageDTO imageDTO = new Prod_ImageDTO();

					imageDTO.setImg_id(filename);//상품명_판매자ID_image_fileindex
					imageDTO.setProd_id(prod_id);//상품_판매자ID
					imageDTO.setImg_type(0);
					
					System.out.println(imageDTO);

					int prdMainImgRegResult = imageService.prod_imageInsert(imageDTO);

					mainfileIndex++;

				} catch (IOException e) {
					e.printStackTrace();
					redirectAttributes.addFlashAttribute("PrdRegisterResult", "상품 정보 업로드에 실패하였습니다.");
					return "/seller/sellerPrdList";// 오류페이지로 리다이렉션(팀프로젝트에서는 alert으로 에러를 띄우고 판매자-물품 리스트로 리다이렉트)
				}
			}
			
			
			//(2)설명이미지파일
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

					Prod_ImageDTO imageDTO = new Prod_ImageDTO();

					imageDTO.setImg_id(filename);
					imageDTO.setProd_id(prod_id);
					imageDTO.setImg_type(1);
					
					System.out.println(imageDTO);

					int prdDescImgRegResult = imageService.prod_imageInsert(imageDTO);

					descfileIndex++;

				} catch (IOException e) {
					e.printStackTrace();
					redirectAttributes.addFlashAttribute("PrdRegisterResult", "상품 정보 업로드 실패하였습니다.");
					return "/seller/sellerPrdList";
				}
			}
		}

	
		if (productType.equals("판매")) {
		
			Integer maxSellStockNum=seller_Prod_StockService.findMaxStockNumber(prod_id);
			System.out.println(maxSellStockNum);
			if(Objects.isNull(maxSellStockNum)) maxSellStockNum=0;
			maxSellStockNum++;
			
			System.out.println(maxSellStockNum);
			
			String stockID = prod_id + "_SELL_" + maxSellStockNum;
			Seller_Prod_StockDTO seller_Prod_StockDTO = new Seller_Prod_StockDTO();
			seller_Prod_StockDTO.setS_stock_id(stockID);
			seller_Prod_StockDTO.setStock(prdStock);
			seller_Prod_StockDTO.setTotal(0);
			seller_Prod_StockDTO.setProd_id(prod_id);

		
			for (int i = 0; i < optNames.size(); i++) {
				String optionName = URLDecoder.decode(optNames.get(i), "UTF-8");
				String optionValue = URLDecoder.decode(optValues.get(i), "UTF-8");
				
				System.out.println(optionName);
				System.out.println(optionValue);

				
				Integer maxOptionID = optionService.findMaxOptId();
				if (Objects.isNull(maxOptionID))
					maxOptionID = 0;
				maxOptionID++;

				Prod_OptionDTO optionDTO = new Prod_OptionDTO();
				optionDTO.setOpt_id(maxOptionID);
				optionDTO.setOpt_name(optionName);
				optionDTO.setOpt_value(optionValue);
				optionDTO.setProd_id(prod_id);

				int optRegResult = optionService.optionInsert(optionDTO);

				switch (i) {
				case 0:
					seller_Prod_StockDTO.setOpt_id1(maxOptionID);
					break;
				case 1:
					seller_Prod_StockDTO.setOpt_id2(maxOptionID);
					break;
				case 2:
					seller_Prod_StockDTO.setOpt_id3(maxOptionID);
					break;
				case 3:
					seller_Prod_StockDTO.setOpt_id4(maxOptionID);
					break;
				case 4:
					seller_Prod_StockDTO.setOpt_id5(maxOptionID);
					break;
				}

			}

			int sellStockRegResult = seller_Prod_StockService.seller_prod_stockInsert(seller_Prod_StockDTO);

		} else if(productType.equals("대여")){
			
			Integer maxSellStockNum = rentProdStockService.findMaxStockNumber(prod_id);
			if(Objects.isNull(maxSellStockNum)) maxSellStockNum=0;
			maxSellStockNum++;
			
			

			String stockID = prod_id + "_RENT_" + maxSellStockNum;
			RentProdStockDTO rentProdStockDTO = new RentProdStockDTO();
			rentProdStockDTO.setR_stock_id(stockID);
			rentProdStockDTO.setStock(prdStock);
			rentProdStockDTO.setTotal(0);
			rentProdStockDTO.setProd_id(prod_id);

		
			for (int i = 0; i < optNames.size(); i++) {
				String optionName = URLDecoder.decode(optNames.get(i), "UTF-8");
				String optionValue = URLDecoder.decode(optValues.get(i), "UTF-8");

			
				Integer maxOptionID = optionService.findMaxOptId();
				if (Objects.isNull(maxOptionID))
					maxOptionID = 0;
				maxOptionID++;

				Prod_OptionDTO optionDTO = new Prod_OptionDTO();
				optionDTO.setOpt_id(maxOptionID);
				optionDTO.setOpt_name(optionName);
				optionDTO.setOpt_value(optionValue);
				optionDTO.setProd_id(prod_id);
				
				int optRegResult = optionService.optionInsert(optionDTO);

				switch (i) {
				case 0:
					rentProdStockDTO.setOpt_id1(maxOptionID);
					break;
				case 1:
					rentProdStockDTO.setOpt_id2(maxOptionID);
					break;
				case 2:
					rentProdStockDTO.setOpt_id3(maxOptionID);
					break;
				case 3:
					rentProdStockDTO.setOpt_id4(maxOptionID);
					break;
				case 4:
					rentProdStockDTO.setOpt_id5(maxOptionID);
					break;
				}
			}
			int rentStockRegResult = rentProdStockService.rentProdInsert(rentProdStockDTO);	
			System.out.println(rentStockRegResult);
		}
		redirectAttributes.addFlashAttribute("PrdRegisterResult", "상품 정보 업로드에 성공하였습니다.");
    return "redirect:/seller/PrdList.do";// 성공 페이지로 리다이렉션(팀프로젝트에서는 판매자-물품 리스트로 리다이렉트)
	}
}