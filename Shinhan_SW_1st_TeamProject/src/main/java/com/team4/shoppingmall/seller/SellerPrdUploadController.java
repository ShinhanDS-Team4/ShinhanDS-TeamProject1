package com.team4.shoppingmall.seller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import retrofit2.http.Multipart;

@Controller
@RequestMapping("/seller")
public class SellerPrdUploadController {

	private JdbcTemplate jdbcTemplate;
	
	@Value("${file.upload-dir}")
    private String uploadDir;
	
	@PostMapping("/uploadPrd")
	public String handleFileUpload(
			@RequestParam("prdName") String prdName,
			@RequestParam("prdPrice") int prdPrice,
			@RequestParam("prdCategory") String prdCategory,
			@RequestParam("file") List<MultipartFile> files,
			@RequestParam("prdDescription") String prdDescription,
			@RequestParam("optName") List<String> optNames,
            @RequestParam("optValue") List<String> optValues,
			@RequestParam("prdStock") int prdStock,
			RedirectAttributes redirectAttributes) throws UnsupportedEncodingException {
		
		
		//한글 깨지는 문제 해결
		String productName = new String(prdName.getBytes("8859_1"),"utf-8");
		String productCategory = new String(prdCategory.getBytes("8859_1"),"utf-8");
		String productDescription = new String(prdDescription.getBytes("8859_1"),"utf-8");
		
		List<String> fileUrls = new ArrayList<>();//사진들의 URL들을 저장할 리스트
				
        for(MultipartFile file : files) {
        	// 파일 타입 체크
            String contentType = file.getContentType();
            System.out.println(contentType);
            if(!"image/jpeg".equals(contentType) && !"image/png".equals(contentType)) {
            	redirectAttributes.addFlashAttribute("PrdRegisterResult", "이미지 파일이 아닙니다.");
            	return "/seller/sellerPrdList";//오류페이지로 리다이렉션(팀프로젝트에서는 alert으로 에러를 띄우고 판매자-물품 리스트로 리다이렉트)
            }
            
            //파일 처리(URL로 변환)
            try {
            	
            	//현재 파일명은 '상품명_등록시각_이미지파일원본이름'
            	//일단 이렇게 만들어두긴 했는데 나중에 '상품ID_번호'든 '재고ID_번호'든 형식에 맞게 고칠 거임
            	String filename = new String(prdName.getBytes("8859_1"),"utf-8")+"_"+System.currentTimeMillis() + "_" + new String(file.getOriginalFilename().getBytes("8859_1"),"utf-8");//일단 이렇게 만들어두긴 했는데 나중에 상품ID든 재고ID든 형식에 맞게 고칠 거임
            	Path filePath = Paths.get(uploadDir).resolve(filename);
            	Files.createDirectories(filePath.getParent()); // 디렉토리가 존재하지 않으면 생성
                Files.write(filePath, file.getBytes()); // 파일 저장
            	
                // 파일 URL 생성
                String fileUrl = "/images/" + filename;
                System.out.println("이미지파일URL : "+fileUrl);
                fileUrls.add(fileUrl);
                
            	
            }catch(IOException e) {
            	e.printStackTrace();
            	redirectAttributes.addFlashAttribute("PrdRegisterResult", "상품 정보 업로드에 실패하였습니다.");
            	return "/seller/sellerPrdList";//오류페이지로 리다이렉션(팀프로젝트에서는 alert으로 에러를 띄우고 판매자-물품 리스트로 리다이렉트)
            }
            
        }
        
        //옵션명 & 옵션값 처리
        List<Map<String,String>> options = new ArrayList<>();
        for(int i=0;i<optNames.size();i++) {
        	Map<String, String> option = new HashMap<String, String>();
        	option.put("optName", new String(optNames.get(i).getBytes("8859_1"),"utf-8"));
        	option.put("optValue", new String(optValues.get(i).getBytes("8859_1"),"utf-8"));
        	
        	System.out.println(option);
        	options.add(option);
        }

        //여기부터는 상품 데이터를 DB에 저장하는 과정을 진행
        
        
        redirectAttributes.addFlashAttribute("PrdRegisterResult", "상품 정보 업로드에 성공하였습니다.");
        return "/seller/sellerPrdList";//성공 페이지로 리다이렉션(팀프로젝트에서는 판매자-물품 리스트로 리다이렉트)
	}
	
}
