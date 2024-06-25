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

	@Value("${file.upload-dir}")
	private String uploadDir;

	@PostMapping("/uploadPrd")
	public String handleFileUpload(@RequestParam("prdType") String prdType, @RequestParam("prdName") String prdName,
			@RequestParam("prdPrice") int prdPrice, @RequestParam("prdCategory") int prdCategory,
			@RequestParam("file") List<MultipartFile> files, @RequestParam("prdDescription") String prdDescription,
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
		ProdDTO prodDTO = prodService.selectByProdId(prod_id);

		if (Objects.isNull(prodDTO)) {
			// 상품 등록
			prodDTO.setProd_id(prod_id);
			prodDTO.setProd_name(productName);
			prodDTO.setProd_desc(prdDescription);
			prodDTO.setProd_price(prdPrice);
			prodDTO.setProd_added_date(sqlDate);
			prodDTO.setCategory_id(prdCategory);
			prodDTO.setMember_id(member_id);

			int prdRegResult = prodService.prodInsert(prodDTO);

			//상품 테이블 등록 종료
			
			// 2.상품 이미지(PROD_IMAGE) 테이블 데이터 저장
			int fileIndex = 1; // 파일 인덱스를 1로 초기화
			
			for (MultipartFile file : files) {
				// 파일 타입 체크
				String contentType = file.getContentType();
				System.out.println(contentType);
				if (!"image/jpeg".equals(contentType) && !"image/png".equals(contentType)) {
					redirectAttributes.addFlashAttribute("PrdRegisterResult", "이미지 파일이 아닙니다.");
					return "/seller/sellerPrdList";// 오류페이지로 리다이렉션(팀프로젝트에서는 alert으로 에러를 띄우고 판매자-물품 리스트로 리다이렉트)
				}

				// 파일 처리(URL로 변환)
				try {
					// 파일명은 '상품명_판매자ID_image_x'(x는 sequence)
					String filename = prod_id + "_image_" + fileIndex;
					Path filePath = Paths.get(uploadDir).resolve(filename);
					Files.createDirectories(filePath.getParent()); // 디렉토리가 존재하지 않으면 생성
					Files.write(filePath, file.getBytes()); // 파일 저장

					// 파일 URL 생성 >> 주의!!) 해당 파일URL은 생성 시점에서 사용 중인 서버에서만 유효함
					String fileUrl = "/images/" + filename;
					System.out.println("이미지파일URL : " + fileUrl);
					fileUrls.add(fileUrl);
					
					//DB에 저장
					
					Prod_ImageDTO imageDTO = new Prod_ImageDTO();
					
					imageDTO.setImg_id(filename);
					imageDTO.setProd_id(prod_id);
					
					int prdImgRegResult = imageService.prod_imageInsert(imageDTO);
					
					fileIndex++;
					
				} catch (IOException e) {
					e.printStackTrace();
					redirectAttributes.addFlashAttribute("PrdRegisterResult", "상품 정보 업로드에 실패하였습니다.");
					return "/seller/sellerPrdList";// 오류페이지로 리다이렉션(팀프로젝트에서는 alert으로 에러를 띄우고 판매자-물품 리스트로 리다이렉트)
				}
			}
		}
		
		// 3.재고(Stock) 테이블 : 재고 테이블 등록은 상품ID, 
		
		// 옵션명 & 옵션값 처리
		List<Map<String, String>> options = new ArrayList<>();//옵션리스트, 근데 이거 필요없어
		
		for (int i = 0; i < optNames.size(); i++) {
			Map<String, String> option = new HashMap<String, String>();
			option.put("optName", new String(optNames.get(i).getBytes("8859_1"), "utf-8"));
			option.put("optValue", new String(optValues.get(i).getBytes("8859_1"), "utf-8"));

			String optionName =  URLDecoder.decode(optNames.get(i), "UTF-8");
			String optionValue =  URLDecoder.decode(optValues.get(i), "UTF-8");
			
			//현재 DB에서 상품 ID 별로 가장 큰 옵션 ID를 가져온다
			int maxOptionID = optionService.findMaxOptId(prod_id);
			maxOptionID++;
			
			Prod_OptionDTO optionDTO = new Prod_OptionDTO();
			optionDTO.setOpt_id(maxOptionID);
			optionDTO.setOpt_name(optionName);
			optionDTO.setOpt_value(optionValue);
			optionDTO.setProd_id(prod_id);
			
			int optRegResult = optionService.optionInsert(optionDTO);
			
			System.out.println(option);
			options.add(option);
		}

		

		redirectAttributes.addFlashAttribute("PrdRegisterResult", "상품 정보 업로드에 성공하였습니다.");
		return "/seller/sellerPrdList";// 성공 페이지로 리다이렉션(팀프로젝트에서는 판매자-물품 리스트로 리다이렉트)
	}

}
