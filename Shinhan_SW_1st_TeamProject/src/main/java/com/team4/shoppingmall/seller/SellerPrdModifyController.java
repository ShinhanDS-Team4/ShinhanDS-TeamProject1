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

import javax.servlet.http.HttpSession;

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
import com.team4.shoppingmall.member.MemberDTO;
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

	//String member_id = "573-50-00882";// �ӽ÷� ����� �Ǹ���ID(����ڵ�Ϲ�ȣ)

	// ��ǰ �̹��� ���� ���ε� ���丮
	// 1.���� �̹��� ����
	@Value("${file.main-img-upload-dir}")
	private String mainIMG_uploadDir;

	// 2.���� �̹��� ����
	@Value("${file.desc-img-upload-dir}")
	private String descIMG_uploadDir;

	@PostMapping("/resetMainProdImg")
	@ResponseBody
	public String resetMainProdImg(@RequestBody Map<String, Object> request) throws IOException {
		System.out.println("메인이미지 삭제 작업 시작");
		String prod_id = (String) request.get("prodid");
		System.out.println("상품ID:" + prod_id);

		Prod_ImageDTO imageDTO = new Prod_ImageDTO();
		imageDTO.setImg_id("imageDTOforSearch");
		imageDTO.setProd_id(prod_id);
		imageDTO.setImg_type(0);

		List<String> imgIdList = imageService.findMainImgFileNameByProdID(imageDTO);
		System.out.println("메인이미지 목록:"+imgIdList);

		System.out.println("���� �Ϸ�");

		for (String imgID : imgIdList) {
			int imgDeleteResult = imageService.prod_imageDelete(imgID);
			Path filePath = Paths.get(mainIMG_uploadDir).resolve(imgID);
			System.out.println("파일경로:" + filePath);
			Files.delete(filePath);

			System.out.println(imgID + "삭제됨");
		}

		return "resetImgSuccess";
	}

	@PostMapping("/resetDescProdImg")
	@ResponseBody
	public String resetDescProdImg(@RequestBody Map<String, Object> request) throws IOException {
		System.out.println("설명이미지 삭제 시작");
		String prod_id = (String) request.get("prodid");
		System.out.println("상품ID:" + prod_id);

		Prod_ImageDTO imageDTO = new Prod_ImageDTO();
		imageDTO.setImg_id("imageDTOforSearch");
		imageDTO.setProd_id(prod_id);
		imageDTO.setImg_type(1);

		List<String> imgIdList = imageService.findDescImgFileNameByProdID(imageDTO);
		System.out.println(imgIdList);

		System.out.println("���� �Ϸ�");

		for (String imgID : imgIdList) {
			int imgDeleteResult = imageService.prod_imageDelete(imgID);
			Path filePath = Paths.get(descIMG_uploadDir).resolve(imgID);
			System.out.println("파일경로:" + filePath);
			Files.delete(filePath);

			System.out.println(imgID + "삭제됨");
		}

		return "resetImgSuccess";
	}

	@PostMapping("/modifyPrdouct")
	public String updateStockInfo(
			@RequestParam("prdId") String prdID,
			@RequestParam("prdPrice") int prdPrice,
			@RequestParam(value = "finalCategory", required = false) Integer prdCategory,
			@RequestParam(value = "mainImgFile", required = false) List<MultipartFile> mainFiles,
			@RequestParam(value = "descImgFile", required = false) List<MultipartFile> descFiles,
			@RequestParam("prdDescription") String prdDescription, @RequestParam("stockid") String stockid,
			@RequestParam("prdStock") int prdStock, RedirectAttributes redirectAttributes, HttpSession session)
			throws UnsupportedEncodingException {
		MemberDTO mem = (MemberDTO)session.getAttribute("member");
		String sellerID = mem.getMember_id();
		//String member_id = "573-50-00882";

		String prod_id = URLDecoder.decode(prdID, "UTF-8");// ��ǰID
		String prd_desc = URLDecoder.decode(prdDescription, "UTF-8");// ��ǰ����
		ProdDTO prodDTO = prodService.selectByProdId(prod_id);

		prodDTO.setProd_id(prod_id);
		prodDTO.setProd_desc(prd_desc);
		
		if(!Objects.isNull(prdCategory)) {
			prodDTO.setCategory_id(prdCategory);
		}
		
		
		prodDTO.setProd_price(prdPrice);

		int prdUpdateResult = prodService.prodModify(prodDTO);

		// ��ǰ�̹��� ����� ���� �̹��� ��� ��� >> ���� �̹��� ��� ��� ������ ����
		int mainfileIndex = 1; // ���� �̹��� ���� �ε����� 1�� �ʱ�ȭ
		int descfileIndex = 1; // ���� �̹��� ���� �ε����� 1�� �ʱ�ȭ

		// ���� ���� �ʱ�ȭ �� ����
		if (!Objects.isNull(mainFiles)) {
			for (MultipartFile mainfile : mainFiles) {
				// ���� Ÿ�� üũ
				String contentType = mainfile.getContentType();
				System.out.println(contentType);
				if (!"image/jpeg".equals(contentType) && !"image/png".equals(contentType)) {
					redirectAttributes.addFlashAttribute("PrdRegisterResult", "�̹��� ������ �ƴմϴ�.");
					return "/seller/sellerPrdList";// ������������ �����̷���(��������Ʈ������ alert���� ������ ���� �Ǹ���-��ǰ ����Ʈ�� �����̷�Ʈ)
				}

				// ���� ��ǻ���� ���丮�� ���� ����

				// (1)�����̹��� ����
				try {
					// ���ϸ��� '��ǰ��_�Ǹ���ID_mainimage_x'(x�� sequence)
					String filename = prod_id + "_image_" + mainfileIndex + ".png";
					Path filePath = Paths.get(mainIMG_uploadDir).resolve(filename);
					Files.createDirectories(filePath.getParent()); // ���丮�� �������� ������ ����
					Files.write(filePath, mainfile.getBytes()); // ���� ����

					// DB�� ����
					Prod_ImageDTO imageDTO = new Prod_ImageDTO();

					imageDTO.setImg_id(filename);// ��ǰ��_�Ǹ���ID_image_fileindex
					imageDTO.setProd_id(prod_id);// ��ǰ_�Ǹ���ID
					imageDTO.setImg_type(0);

					System.out.println(imageDTO);

					int prdMainImgRegResult = imageService.prod_imageInsert(imageDTO);

					mainfileIndex++;

				} catch (IOException e) {
					e.printStackTrace();
					redirectAttributes.addFlashAttribute("PrdRegisterResult", "��ǰ ���� ���ε忡 �����Ͽ����ϴ�.");
					return "/seller/sellerPrdList";// ������������ �����̷���(��������Ʈ������ alert���� ������ ���� �Ǹ���-��ǰ ����Ʈ�� �����̷�Ʈ)
				}
			}
		}

		if (!Objects.isNull(descFiles)) {
			for (MultipartFile descfile : descFiles) {
				// ���� Ÿ�� üũ
				String contentType = descfile.getContentType();
				System.out.println(contentType);
				if (!"image/jpeg".equals(contentType) && !"image/png".equals(contentType)) {
					redirectAttributes.addFlashAttribute("PrdRegisterResult", "�̹��� ������ �ƴմϴ�.");
					return "/seller/sellerPrdList";// ������������ �����̷���(��������Ʈ������ alert���� ������ ���� �Ǹ���-��ǰ ����Ʈ�� �����̷�Ʈ)
				}

				// ���� ��ǻ���� ���丮�� ���� ����
				try {
					// ���ϸ��� '��ǰ��_�Ǹ���ID_descimage_x'(x�� sequence)
					String filename = prod_id + "_descimage_" + descfileIndex + ".png";
					Path filePath = Paths.get(descIMG_uploadDir).resolve(filename);
					Files.createDirectories(filePath.getParent()); // ���丮�� �������� ������ ����
					Files.write(filePath, descfile.getBytes()); // ���� ����

					// DB�� ����
					Prod_ImageDTO imageDTO = new Prod_ImageDTO();

					imageDTO.setImg_id(filename);// ��ǰ��_�Ǹ���ID_image_fileindex
					imageDTO.setProd_id(prod_id);// ��ǰ_�Ǹ���ID
					imageDTO.setImg_type(1);

					System.out.println(imageDTO);

					int prdDescImgRegResult = imageService.prod_imageInsert(imageDTO);

					descfileIndex++;

				} catch (IOException e) {
					e.printStackTrace();
					redirectAttributes.addFlashAttribute("PrdRegisterResult", "��ǰ ���� ���ε忡 �����Ͽ����ϴ�.");
					return "/seller/sellerPrdList";// ������������ �����̷���(��������Ʈ������ alert���� ������ ���� �Ǹ���-��ǰ ����Ʈ�� �����̷�Ʈ)
				}
			}
		}

		// ���ID-��� ����
		String stock_id = URLDecoder.decode(stockid, "UTF-8");

		System.out.println("���ID:" + stock_id);

		if (stock_id.contains("_SELL_")) {// �Ǹ������ ���
			Seller_Prod_StockDTO seller_Prod_StockDTO = new Seller_Prod_StockDTO();
			seller_Prod_StockDTO.setS_stock_id(stock_id);
			seller_Prod_StockDTO.setStock(prdStock);

			System.out.println("�Ǹ���� ����������:" + seller_Prod_StockDTO);

			int changeSellStock = seller_Prod_StockService.sellStockUpdate(seller_Prod_StockDTO);

		} else if (stock_id.contains("_RENT_")) {// �뿩����� ���
			RentProdStockDTO rentProdStockDTO = new RentProdStockDTO();

			rentProdStockDTO.setR_stock_id(stock_id);
			rentProdStockDTO.setStock(prdStock);

			System.out.println("�뿩��� ����������:" + rentProdStockDTO);

			int changeRentStock = rentProdStockService.rentStockUpdate(rentProdStockDTO);
		}

		redirectAttributes.addFlashAttribute("PrdRegisterResult", "��ǰ ���� �ֽ�ȭ�� �����Ͽ����ϴ�.");
		return "redirect:/seller/PrdList.do";// ���� �������� �����̷���(��������Ʈ������ �Ǹ���-��ǰ ����Ʈ�� �����̷�Ʈ)
	}
}
