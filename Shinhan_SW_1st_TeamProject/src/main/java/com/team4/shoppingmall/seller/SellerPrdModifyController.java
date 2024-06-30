package com.team4.shoppingmall.seller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team4.shoppingmall.admin_inq.Admin_InqService;
import com.team4.shoppingmall.buyer_inq.Buyer_InqService;
import com.team4.shoppingmall.member.MemberService;
import com.team4.shoppingmall.prod.ProdService;
import com.team4.shoppingmall.prod_image.Prod_ImageService;
import com.team4.shoppingmall.prod_option.Prod_OptionService;
import com.team4.shoppingmall.rent_prod_stock.RentProdStockService;
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
	
	
}
