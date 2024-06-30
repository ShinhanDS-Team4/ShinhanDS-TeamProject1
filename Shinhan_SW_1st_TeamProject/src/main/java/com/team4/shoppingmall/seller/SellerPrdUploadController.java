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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

	
	//상품 이미지 파일 업로드 디렉토리
	//1.메인 이미지 파일
	@Value("${file.main-img-upload-dir}")
	private String mainIMG_uploadDir;
	
	//2.설명 이미지 파일
	@Value("${file.desc-img-upload-dir}")
	private String descIMG_uploadDir;

	@PostMapping("/uploadPrd")
	public String handleFileUpload(
			@RequestParam("prdType") String prdType,
			@RequestParam("prdName") String prdName,
			@RequestParam("prdPrice") int prdPrice, 
			@RequestParam("prdCategory") int prdCategory,
			@RequestParam("mainImgFile") List<MultipartFile> mainFiles, 
			@RequestParam("descImgFile") List<MultipartFile> descFiles, 
			@RequestParam("prdDescription") String prdDescription,
			@RequestParam("optName") List<String> optNames, @RequestParam("optValue") List<String> optValues,
			@RequestParam("prdStock") int prdStock, RedirectAttributes redirectAttributes)
			throws UnsupportedEncodingException {

		String member_id = "573-50-00882";// 임시로 사용할 판매자ID(사업자등록번호) >> 이건 로그인 기능이 페이지와 연결되면 Session에서 가져올 거임

		// 한글 깨지는 문제 해결
		String productType = URLDecoder.decode(prdType, "UTF-8");
		String productName = URLDecoder.decode(prdName, "UTF-8");
		// String productCategory = URLDecoder.decode(prdCategory,"UTF-8");
		String productDescription = URLDecoder.decode(prdDescription, "UTF-8");

		System.out.println(productType);
		System.out.println(productName);
		// System.out.println(productCategory);
		System.out.println(productDescription);

		List<String> fileUrls = new ArrayList<>();// 사진들의 URL들을 저장할 리스트

		/*----------여기부터는 상품 데이터를 DB에 저장하는 과정을 진행----------*/

		// 업로드 날짜
		// 오늘 날짜를 LocalDate로 가져옴
		LocalDate localDate = LocalDate.now();

		// LocalDate를 java.sql.Date로 변환
		Date sqlDate = Date.valueOf(localDate);

		// 1.상품(Product) 테이블 저장 : 동일 상품 ID 존재 여부 확인 필요
		String prod_id = productName + "_" + member_id; // 상품ID : 상품명_판매자ID

		System.out.println("상품ID : " + prod_id);

		// PROD에서 상품 ID를 검색하여 동일한 값이 존재하는지 우선 확인
		// if(존재하지 않으면) 상품 등록 & 사진 등록 후 재고 등록
		// else(존재하면) => 재고(Stock) 데이터만 만들면 됨
		ProdDTO prodDTO = new ProdDTO();
				
		prodDTO = prodService.selectByProdId(prod_id);
		
		System.out.println(prodDTO);

		if (Objects.isNull(prodDTO)) {
			// 상품 등록
			ProdDTO prodDTO2 = new ProdDTO();
			
			prodDTO2.setProd_id(prod_id);
			prodDTO2.setProd_name(productName);
			prodDTO2.setProd_desc(prdDescription);
			prodDTO2.setProd_price(prdPrice);
			prodDTO2.setProd_added_date(sqlDate);
			prodDTO2.setCategory_id(prdCategory);
			prodDTO2.setMember_id(member_id);

			int prdRegResult = prodService.prodInsert(prodDTO2);
			System.out.println(prdRegResult);

			// 상품 테이블 등록 종료

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

		// 3.재고(Stock) 등록
		// 여기서부터 productType 별로 StockDTO를 따로따로 생성해서 처리한다
		if (productType.equals("판매")) {// 판매용 재고에 들어가야 하는 경우(SELLER_PROD_STOCK)
			// 등록하려는 재고와 일치하는 상품ID를 가진 판매 재고들 중 재고ID 끝자리 숫자가 제일 큰 재고ID의 끝자리 수를 가져온다.
			// ex)나이키 반팔_550-398-22934_1~5 >> 5
			Integer maxSellStockNum=seller_Prod_StockService.findMaxStockNumber(prod_id);
			System.out.println(maxSellStockNum);
			if(Objects.isNull(maxSellStockNum)) maxSellStockNum=0;
			maxSellStockNum++;// ex) 6으로 올림
			
			System.out.println(maxSellStockNum);
			
			String stockID = prod_id + "_SELL_" + maxSellStockNum;
			Seller_Prod_StockDTO seller_Prod_StockDTO = new Seller_Prod_StockDTO();
			seller_Prod_StockDTO.setS_stock_id(stockID);
			seller_Prod_StockDTO.setStock(prdStock);
			seller_Prod_StockDTO.setTotal(0);
			seller_Prod_StockDTO.setProd_id(prod_id);

			// 옵션명 & 옵션값 처리
			// for문을 이용한 opt_id 추가
			for (int i = 0; i < optNames.size(); i++) {
				String optionName = URLDecoder.decode(optNames.get(i), "UTF-8");
				String optionValue = URLDecoder.decode(optValues.get(i), "UTF-8");
				
				System.out.println(optionName);
				System.out.println(optionValue);

				// 현재 DB의 상품옵션(PROD_OPTION) 테이블에서 가장 큰 옵션 ID를 가져온다
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

		} else if(productType.equals("대여")){// 대여 재고에 들어가야 하는 경우(RENT_PROD_STOCK)
			// 등록하려는 재고와 일치하는 상품ID를 가진 대여 재고들 중 재고ID 끝자리 숫자가 제일 큰 재고ID의 끝자리 수를 가져온다.
			// ex)나이키 반팔_550-398-22934_1~5 >> 5
			Integer maxSellStockNum = rentProdStockService.findMaxStockNumber(prod_id);
			if(Objects.isNull(maxSellStockNum)) maxSellStockNum=0;
			maxSellStockNum++;// ex) 6으로 올림
			
			System.out.println("대여재고 최대값:"+maxSellStockNum);

			String stockID = prod_id + "_RENT_" + maxSellStockNum;
			RentProdStockDTO rentProdStockDTO = new RentProdStockDTO();
			rentProdStockDTO.setR_stock_id(stockID);
			rentProdStockDTO.setStock(prdStock);
			rentProdStockDTO.setTotal(0);
			rentProdStockDTO.setProd_id(prod_id);

			// 옵션명 & 옵션값 처리
			// for문을 이용한 opt_id 추가
			for (int i = 0; i < optNames.size(); i++) {
				String optionName = URLDecoder.decode(optNames.get(i), "UTF-8");
				String optionValue = URLDecoder.decode(optValues.get(i), "UTF-8");

				// 현재 DB의 상품옵션(PROD_OPTION) 테이블에서 가장 큰 옵션 ID를 가져온다
				Integer maxOptionID = optionService.findMaxOptId();
				if (Objects.isNull(maxOptionID))
					maxOptionID = 0;
				maxOptionID++;

				Prod_OptionDTO optionDTO = new Prod_OptionDTO();
				optionDTO.setOpt_id(maxOptionID);
				optionDTO.setOpt_name(optionName);
				optionDTO.setOpt_value(optionValue);
				optionDTO.setProd_id(prod_id);

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
		return "/seller/sellerPrdList";// 성공 페이지로 리다이렉션(팀프로젝트에서는 판매자-물품 리스트로 리다이렉트)
	}
}
