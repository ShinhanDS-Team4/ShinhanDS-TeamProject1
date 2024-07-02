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

	@Value("${file.main-img-upload-dir}")
	private String uploadDir;

	@PostMapping("/uploadPrd")
	public String handleFileUpload(@RequestParam("prdType") String prdType, @RequestParam("prdName") String prdName,
			@RequestParam("prdPrice") int prdPrice, @RequestParam("prdCategory") int prdCategory,
			@RequestParam("file") List<MultipartFile> files, @RequestParam("prdDescription") String prdDescription,
			@RequestParam("optName") List<String> optNames, @RequestParam("optValue") List<String> optValues,
			@RequestParam("prdStock") int prdStock, RedirectAttributes redirectAttributes)
			throws UnsupportedEncodingException {

		String member_id = "573-50-00882";// �ӽ÷� ����� �Ǹ���ID(����ڵ�Ϲ�ȣ) >> �̰� �α��� ����� �������� ����Ǹ� Session���� ������ ����

		// �ѱ� ������ ���� �ذ�
		String productType = URLDecoder.decode(prdType, "UTF-8");
		String productName = URLDecoder.decode(prdName, "UTF-8");
		// String productCategory = URLDecoder.decode(prdCategory,"UTF-8");
		String productDescription = URLDecoder.decode(prdDescription, "UTF-8");

		System.out.println(productType);
		System.out.println(productName);
		// System.out.println(productCategory);
		System.out.println(productDescription);

		List<String> fileUrls = new ArrayList<>();// �������� URL���� ������ ����Ʈ

		/*----------������ʹ� ��ǰ �����͸� DB�� �����ϴ� ������ ����----------*/

		// ���ε� ��¥
		// ���� ��¥�� LocalDate�� ������
		LocalDate localDate = LocalDate.now();

		// LocalDate�� java.sql.Date�� ��ȯ
		Date sqlDate = Date.valueOf(localDate);

		// 1.��ǰ(Product) ���̺� ���� : ���� ��ǰ ID ���� ���� Ȯ�� �ʿ�
		String prod_id = productName + "_" + member_id; // ��ǰID : ��ǰ��_�Ǹ���ID

		System.out.println("��ǰID : " + prod_id);

		// PROD���� ��ǰ ID�� �˻��Ͽ� ������ ���� �����ϴ��� �켱 Ȯ��
		// if(�������� ������) ��ǰ ��� & ���� ��� �� ��� ���
		// else(�����ϸ�) => ���(Stock) �����͸� ����� ��
		ProdDTO prodDTO = new ProdDTO();
				
		prodDTO = prodService.selectByProdId(prod_id);
		
		System.out.println(prodDTO);

		if (Objects.isNull(prodDTO)) {
			// ��ǰ ���
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

			// ��ǰ ���̺� ��� ����

			// 2.��ǰ �̹���(PROD_IMAGE) ���̺� ������ ����
			int fileIndex = 1; // ���� �ε����� 1�� �ʱ�ȭ

			for (MultipartFile file : files) {
				// ���� Ÿ�� üũ
				String contentType = file.getContentType();
				System.out.println(contentType);
				if (!"image/jpeg".equals(contentType) && !"image/png".equals(contentType)) {
					redirectAttributes.addFlashAttribute("PrdRegisterResult", "�̹��� ������ �ƴմϴ�.");
					return "/seller/sellerPrdList";// ������������ �����̷���(��������Ʈ������ alert���� ������ ���� �Ǹ���-��ǰ ����Ʈ�� �����̷�Ʈ)
				}

				// ���� ó��(URL�� ��ȯ)
				try {
					// ���ϸ��� '��ǰ��_�Ǹ���ID_image_x'(x�� sequence)
					String filename = prod_id + "_image_" + fileIndex+".png";
					Path filePath = Paths.get(uploadDir).resolve(filename);
					Files.createDirectories(filePath.getParent()); // ���丮�� �������� ������ ����
					Files.write(filePath, file.getBytes()); // ���� ����

					// ���� URL ���� >> ����!!) �ش� ����URL�� ���� �������� ��� ���� ���������� ��ȿ��
					String fileUrl = "/images/" + filename;
					System.out.println("�̹�������URL : " + fileUrl);
					fileUrls.add(fileUrl);

					// DB�� ����
					Prod_ImageDTO imageDTO = new Prod_ImageDTO();

					imageDTO.setImg_id(filename);//��ǰ��_�Ǹ���ID_image_fileindex
					imageDTO.setProd_id(prod_id);//��ǰ_�Ǹ���ID
					
					System.out.println(imageDTO);

					int prdImgRegResult = imageService.prod_imageInsert(imageDTO);

					fileIndex++;

				} catch (IOException e) {
					e.printStackTrace();
					redirectAttributes.addFlashAttribute("PrdRegisterResult", "��ǰ ���� ���ε忡 �����Ͽ����ϴ�.");
					return "/seller/sellerPrdList";// ������������ �����̷���(��������Ʈ������ alert���� ������ ���� �Ǹ���-��ǰ ����Ʈ�� �����̷�Ʈ)
				}
			}
		}

		// 3.���(Stock) ���
		// ���⼭���� productType ���� StockDTO�� ���ε��� �����ؼ� ó���Ѵ�
		if (productType.equals("�Ǹ�")) {// �Ǹſ� ��� ���� �ϴ� ���(SELLER_PROD_STOCK)
			// ����Ϸ��� ���� ��ġ�ϴ� ��ǰID�� ���� �Ǹ� ���� �� ���ID ���ڸ� ���ڰ� ���� ū ���ID�� ���ڸ� ���� �����´�.
			// ex)����Ű ����_550-398-22934_1~5 >> 5
			Integer maxSellStockNum=seller_Prod_StockService.findMaxStockNumber(prod_id);
			System.out.println(maxSellStockNum);
			if(Objects.isNull(maxSellStockNum)) maxSellStockNum=0;
			maxSellStockNum++;// ex) 6���� �ø�
			
			System.out.println(maxSellStockNum);
			
			String stockID = prod_id + "_SELL_" + maxSellStockNum;
			Seller_Prod_StockDTO seller_Prod_StockDTO = new Seller_Prod_StockDTO();
			seller_Prod_StockDTO.setS_stock_id(stockID);
			seller_Prod_StockDTO.setStock(prdStock);
			seller_Prod_StockDTO.setTotal(0);
			seller_Prod_StockDTO.setProd_id(prod_id);

			// �ɼǸ� & �ɼǰ� ó��
			// for���� �̿��� opt_id �߰�
			for (int i = 0; i < optNames.size(); i++) {
				String optionName = URLDecoder.decode(optNames.get(i), "UTF-8");
				String optionValue = URLDecoder.decode(optValues.get(i), "UTF-8");
				
				System.out.println(optionName);
				System.out.println(optionValue);

				// ���� DB�� ��ǰ�ɼ�(PROD_OPTION) ���̺��� ���� ū �ɼ� ID�� �����´�
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

		} else if(productType.equals("�뿩")){// �뿩 ��� ���� �ϴ� ���(RENT_PROD_STOCK)
			// ����Ϸ��� ���� ��ġ�ϴ� ��ǰID�� ���� �뿩 ���� �� ���ID ���ڸ� ���ڰ� ���� ū ���ID�� ���ڸ� ���� �����´�.
			// ex)����Ű ����_550-398-22934_1~5 >> 5
			Integer maxSellStockNum = rentProdStockService.findMaxStockNumber(prod_id);
			if(Objects.isNull(maxSellStockNum)) maxSellStockNum=0;
			maxSellStockNum++;// ex) 6���� �ø�
			
			System.out.println("�뿩��� �ִ밪:"+maxSellStockNum);

			String stockID = prod_id + "_RENT_" + maxSellStockNum;
			RentProdStockDTO rentProdStockDTO = new RentProdStockDTO();
			rentProdStockDTO.setR_stock_id(stockID);
			rentProdStockDTO.setStock(prdStock);
			rentProdStockDTO.setTotal(0);
			rentProdStockDTO.setProd_id(prod_id);

			// �ɼǸ� & �ɼǰ� ó��
			// for���� �̿��� opt_id �߰�
			for (int i = 0; i < optNames.size(); i++) {
				String optionName = URLDecoder.decode(optNames.get(i), "UTF-8");
				String optionValue = URLDecoder.decode(optValues.get(i), "UTF-8");

				// ���� DB�� ��ǰ�ɼ�(PROD_OPTION) ���̺��� ���� ū �ɼ� ID�� �����´�
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

		redirectAttributes.addFlashAttribute("PrdRegisterResult", "��ǰ ���� ���ε忡 �����Ͽ����ϴ�.");
		return "/seller/PrdList.do";// ���� �������� �����̷���(��������Ʈ������ �Ǹ���-��ǰ ����Ʈ�� �����̷�Ʈ)
	}
}
