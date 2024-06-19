package com.team4.shoppingmall.seller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Blob;
import java.sql.SQLException;

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
	public String handleFileUpload(@RequestParam("file") MultipartFile file,RedirectAttributes redirectAttributes) {
		// 파일 타입 체크
        String contentType = file.getContentType();
        System.out.println(contentType);
        
        if(!"image/jpeg".equals(contentType) && !"image/png".equals(contentType)) {
        	redirectAttributes.addFlashAttribute("PrdRegisterResult", "이미지 파일이 아닙니다.");
        	return "/seller/sellerPrdList";//오류페이지로 리다이렉션(팀프로젝트에서는 alert으로 에러를 띄우고 판매자-물품 리스트로 리다이렉트)
        }
		
        try {
        	String filename = System.currentTimeMillis() + "_" + file.getOriginalFilename();
        	Path filePath = Paths.get(uploadDir).resolve(filename);
        	Files.createDirectories(filePath.getParent()); // 디렉토리가 존재하지 않으면 생성
            Files.write(filePath, file.getBytes()); // 파일 저장
        	
            // 파일 URL 생성
            String fileUrl = "/images/" + filename;
            
            System.out.println("이미지파일URL : "+fileUrl);
        	
        }catch(IOException e) {
        	e.printStackTrace();
        	redirectAttributes.addFlashAttribute("PrdRegisterResult", "상품 정보 업로드에 실패하였습니다.");
        	return "/seller/sellerPrdList";//오류페이지로 리다이렉션(팀프로젝트에서는 alert으로 에러를 띄우고 판매자-물품 리스트로 리다이렉트)
        }
        
        redirectAttributes.addFlashAttribute("PrdRegisterResult", "상품 정보 업로드에 성공하였습니다.");
        return "/seller/sellerPrdList";//성공 페이지로 리다이렉션(팀프로젝트에서는 판매자-물품 리스트로 리다이렉트)
	}
	
}
