package com.team4.shoppingmall.reviews;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team4.shoppingmall.member.MemberDTO;

@Controller
@RequestMapping("/review")
public class ReviewsController {


	@Autowired
	ReviewsService reviewsService;
	@Autowired
	private AwsS3Biz s3Service;
	@Value("${aws.accesskey}")
	private String accessKey;
	
	//업로드 폼을 보여주는 메서드(upload랑 display 페이지는 테스트용입니다.)
	@GetMapping("/upload")
    public String showUploadForm() {
        return "board/reviewWritetest";
    }

	// 여러 파일을 업로드하는 메서드
    @PostMapping("/upload")
    public String uploadFiles(HttpServletRequest request, @RequestParam("files") MultipartFile[] files, RedirectAttributes redirectAttributes) throws Exception {
        List<String> imageUrls = new ArrayList<>();  // 업로드된 파일의 URL을 저장할 리스트

        // 업로드된 각 파일을 처리
        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                String originalFileName = file.getOriginalFilename();  // 원본 파일명
                String uuidFileName = getUuidFileName(originalFileName);  // UUID를 사용하여 파일명 생성

                // 파일을 S3에 업로드하고 URL을 받음
                String fileUrl = s3Service.uploadObject(file, uuidFileName);
                imageUrls.add(fileUrl);  // URL을 리스트에 추가
            }
        }

        // 세션에 URL 리스트 저장
        HttpSession session = request.getSession();
        session.setAttribute("uploadedImageUrls", imageUrls);

        // 리디렉션할 때 URL 리스트 전달
        redirectAttributes.addFlashAttribute("uploadedImageUrls", imageUrls);
        return "redirect:display";  // 이미지 표시 페이지로 리디렉션
    }

    // 업로드된 이미지를 표시하는 메서드
    @GetMapping("/display")
    public String displayImages(HttpSession session, Model model) {
        // 세션에서 업로드된 이미지 URL 리스트를 가져옴
        List<String> uploadedImageUrls = (List<String>) session.getAttribute("uploadedImageUrls");
        if (uploadedImageUrls == null || uploadedImageUrls.isEmpty()) {
            model.addAttribute("message", "No images uploaded yet!");  // 업로드된 이미지가 없을 때 메시지 설정
            return "errorPage";  // 에러 페이지 또는 적절한 메시지를 보여줄 페이지로 리턴
        }
        model.addAttribute("uploadedImageUrls", uploadedImageUrls);  // 모델에 URL 리스트 추가
        return "board/displayImage";  // 이미지 표시 페이지로 이동
    }
	
	
	

	@GetMapping("/write.do")
	public String writeReview() {
		return "board/reviewWrite";
	}

	@PostMapping("/write.do")
	public String postReview(ReviewsDTO review, HttpServletRequest request, @RequestParam("reviewImg") MultipartFile review_img, RedirectAttributes redirectAttributes) throws Exception {
	    if (!review_img.isEmpty()) {
	     // =========파일명 받아옴=====================//
	        String originalFileName = review_img.getOriginalFilename();
	     // ========= 파일명 중복 방지 처리 ========= //
	        String uuidFileName = getUuidFileName(originalFileName);

	        // 파일 업로드 및 URL 받기
	        String fileUrl = s3Service.uploadObject(review_img, uuidFileName);
	        review.setReview_img(fileUrl);  // ReviewsDTO에 URL 설정
	    }

	    // 리뷰 데이터 저장
	    reviewsService.reviewsInsert(review);
	    return "board/qa_board";
	}
	
	
    @GetMapping("/displayImage")
    public String displayImage(HttpSession session, Model model) {
        String uploadedImageUrl = (String) session.getAttribute("uploadedImageUrl");
        if (uploadedImageUrl == null) {
            model.addAttribute("message", "No image uploaded yet!");
            return "errorPage";  // 에러 페이지 또는 적절한 메시지를 보여줄 페이지
        }
        model.addAttribute("uploadedImageUrl", uploadedImageUrl);
        System.out.println(uploadedImageUrl);
        return "board/displayImage";
    }

	private static String getUuidFileName(String originalFileName) {
		return UUID.randomUUID().toString() + "_" + originalFileName;
	}

}