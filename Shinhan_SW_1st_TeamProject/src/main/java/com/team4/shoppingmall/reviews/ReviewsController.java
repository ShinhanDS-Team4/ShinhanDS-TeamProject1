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
	
	//AWS S3 참고용 업로드 페이지
	@GetMapping("/upload")
    public String showUploadForm() {
        return "board/reviewWritetest";
    }

	// ���� ������ ���ε��ϴ� �޼���
    @PostMapping("/upload")
    public String uploadFiles(HttpServletRequest request,
    		@RequestParam("files") MultipartFile[] files,
    		RedirectAttributes redirectAttributes) throws Exception {
        List<String> imageUrls = new ArrayList<>();  // ���ε�� ������ URL�� ������ ����Ʈ

        // ���ε�� �� ������ ó��
        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                String originalFileName = file.getOriginalFilename();  // ���� ���ϸ�
                String uuidFileName = getUuidFileName(originalFileName);  // UUID�� ����Ͽ� ���ϸ� ����

                // ������ S3�� ���ε��ϰ� URL�� ����
                String fileUrl = s3Service.uploadObject(file, uuidFileName);
                imageUrls.add(fileUrl);  // URL�� ����Ʈ�� �߰�
            }
        }

        // ���ǿ� URL ����Ʈ ����
        HttpSession session = request.getSession();
        session.setAttribute("uploadedImageUrls", imageUrls);

        // ���𷺼��� �� URL ����Ʈ ����
        redirectAttributes.addFlashAttribute("uploadedImageUrls", imageUrls);
        return "redirect:display";  // �̹��� ǥ�� �������� ���𷺼�
    }

    // ���ε�� �̹����� ǥ���ϴ� �޼���
    @GetMapping("/display")
    public String displayImages(HttpSession session, Model model) {
        // ���ǿ��� ���ε�� �̹��� URL ����Ʈ�� ������
        List<String> uploadedImageUrls = (List<String>) session.getAttribute("uploadedImageUrls");
        if (uploadedImageUrls == null || uploadedImageUrls.isEmpty()) {
            model.addAttribute("message", "No images uploaded yet!");  // ���ε�� �̹����� ���� �� �޽��� ����
            return "errorPage";  // ���� ������ �Ǵ� ������ �޽����� ������ �������� ����
        }
        model.addAttribute("uploadedImageUrls", uploadedImageUrls);  // �𵨿� URL ����Ʈ �߰�
        return "board/displayImage";  // �̹��� ǥ�� �������� �̵�
    }
	
	@GetMapping("myreview.do")
	public String myReview(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberDTO mem = (MemberDTO)session.getAttribute("member");
		//���߿� ���͸� �ϰ����� �켱�� �ӽù������� �б��� ��������
		if(mem == null) {
			return "redirect:/member_test/login.do";
		}
		String member_Id = mem.getMember_id();
		
		List<ReviewsDTO> reviews = reviewsService.selectBymemId(member_Id);
		model.addAttribute("reviews", reviews);
		return "board/myreview";
	}
	

	@GetMapping("/write.do")
	public String writeReview(HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberDTO mem = (MemberDTO)session.getAttribute("member");
		//로그인테스트용, 현재는 필터링으로 거름.
		if(mem == null) {
			return "redirect:/member_test/login.do";
		}
		
		return "board/reviewWrite";
	}

	@PostMapping("/write.do")
	public String postReview(ReviewsDTO review, HttpServletRequest request,
			@RequestParam("reviewImg") MultipartFile review_img,
			RedirectAttributes redirectAttributes) throws Exception {
		
	    if (!review_img.isEmpty()) {
	     // =========���ϸ� �޾ƿ�=====================//
	        String originalFileName = review_img.getOriginalFilename();
	     // ========= ���ϸ� �ߺ� ���� ó�� ========= //
	        String uuidFileName = getUuidFileName(originalFileName);

	        // ���� ���ε� �� URL �ޱ�
	        String fileUrl = s3Service.uploadObject(review_img, uuidFileName);
	        review.setReview_img(fileUrl);  // ReviewsDTO�� URL ����
	    }
	    HttpSession session = request.getSession();
	    MemberDTO mem = (MemberDTO)session.getAttribute("member");
		//���߿� ���͸� �ϰ����� �켱�� �ӽù������� �б��� ��������
		if(mem == null) {
			return "redirect:/member_test/login.do";
		}
		String id = mem.getMember_id();
		System.out.println(mem);
		review.setMember_id(id);
		
	    // 리뷰추가
	    reviewsService.reviewsInsert(review);
		
	    return "redirect:/customer/myPage.do";
	}
	
	
    @GetMapping("/displayImage")
    public String displayImage(HttpSession session, Model model) {
        String uploadedImageUrl = (String) session.getAttribute("uploadedImageUrl");
        if (uploadedImageUrl == null) {
            model.addAttribute("message", "No image uploaded yet!");
            return "errorPage";  // URI가 없을 경우 에러페이지로, 테스트용 주소임.
        }
        model.addAttribute("uploadedImageUrl", uploadedImageUrl);
        System.out.println(uploadedImageUrl);
        return "board/displayImage";
    }

	private static String getUuidFileName(String originalFileName) {
		return UUID.randomUUID().toString() + "_" + originalFileName;
	}

}
