package com.team4.shoppingmall.category;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team4.shoppingmall.admin.AdminService;
import com.team4.shoppingmall.member.MemberDTO;
import com.team4.shoppingmall.member.MemberService;
import com.team4.shoppingmall.prod.ProdDTO;
import com.team4.shoppingmall.prod.ProdService;
import com.team4.shoppingmall.prod_option.Prod_OptionDTO;
import com.team4.shoppingmall.prod_option.Prod_OptionService;
import com.team4.shoppingmall.seller_prod_stock.Seller_Prod_StockDTO;
import com.team4.shoppingmall.seller_prod_stock.Seller_Prod_StockService;
import com.team4.shoppingmall.seller_prod_stockTest.Seller_Prod_StockTestService;
import com.team4.shoppingmall.util.DateUtil;

@Controller
@RequestMapping("/category")
public class CategoryController {
	
	@Autowired
	CategoryService categoryService;
	@Autowired
	ProdService prodService;
	@Autowired
	MemberService memberService;
	@Autowired
	Seller_Prod_StockService spsService;
	@Autowired
	Prod_OptionService prod_optionService;
	@Autowired
	AdminService adminService;
	
	@GetMapping("/dbset")
	public void dbSet() throws IOException, ParseException {
		String[] sizes = new String[] {"S", "M", "L"};
		String[] names = new String[] {"김정현", "백상호", "이종경", "백인혁", "이재환", "조윤재"};
		String[] emails = new String[] {"jh441122jh@gmail.com", "baeksh0118@gmail.com", " ljk5252525@gmail.com", "baekinhyeok998@gmail.com", "1nth2bleakmidwinter@gmail.com", "dbrmfgks@gmail.com"};
		String[] phones = new String[] {"010-6349-3464", "010-9723-4740", "010-2717-9614", "010-7552-8293", "010-4590-9812", "010-7137-8144"};
		
		JSONParser parser = new JSONParser();
		Reader pl_reader = new FileReader("C:/Users/jh981/Desktop/products_list.json");
		Reader bm_reader = new FileReader("C:/Users/jh981/Desktop/business_mans.json");
		Reader ctg_reader = new FileReader("C:/Users/jh981/Desktop/ctg_url_matching.json");
		JSONObject prod_list = (JSONObject) parser.parse(pl_reader);
		JSONObject bm_list = (JSONObject) parser.parse(bm_reader);
		JSONObject ctg_list = (JSONObject) parser.parse(ctg_reader);
		JSONObject prod_detail;
		
		ProdDTO prod;
		Seller_Prod_StockDTO sps;
		Prod_OptionDTO prod_option;
		MemberDTO member;
		CategoryDTO category;
		
		Long tmp;
		int stock;
//		for(Object prod_id :prod_list.keySet()) {
//			prod = new ProdDTO();
//			prod_detail = (JSONObject) prod_list.get((String) prod_id);
//			
//			prod.setProd_id((String) prod_id);
//			prod.setMember_id((String) prod_detail.get("bm_num"));
//			prod.setProd_name((String) prod_detail.get("img_name"));
//			tmp = (Long) prod_detail.get("category");
//			prod.setCategory_id(tmp.intValue());
//			prod.setProd_price(Integer.parseInt((String) prod_detail.get("price")));
//			prod.setProd_added_date(DateUtil.getSQLDate("2023-1"+String.valueOf((int) (Math.random()*3)) + "-" + String.valueOf((int) (Math.random()*17+10))));
//			
//			prodService.prodInsert(prod);
//			
//			for(String size :sizes) {
//				prod_option = new Prod_OptionDTO();
//				prod_option.setOpt_name("사이즈");
//				prod_option.setOpt_value(size);
//				prod_option.setProd_id((String) prod_id);
//				prod_optionService.optionInsert(prod_option);
//			}
//			
//		}
		
//		System.out.println("prod, prod_option table set end.");
//		
//		for(Prod_OptionDTO po :prod_optionService.selectAll()) {
//			sps = new Seller_Prod_StockDTO();
//			sps.setS_stock_id(po.getProd_id() + "_SELL_" + po.getOpt_id());
//			stock = (int) (Math.random()*300);
//			sps.setStock(stock);
//			sps.setTotal((int) (Math.random()*stock));
//			sps.setProd_id(po.getProd_id());
//			sps.setOpt_id1(po.getOpt_id());
//			spsService.seller_prod_stockInsert(sps);
//		}
//		
//		System.out.println("sell_prod_stock table set end.");
//
		for(Object brand :bm_list.keySet()) {
			member = new MemberDTO();
			member.setMember_id((String) bm_list.get(brand));
			member.setMember_pw("0000");
			member.setMember_name(names[(int) (Math.random()*6)]);
			member.setEmail(emails[(int) (Math.random()*6)]);
			member.setPhone(phones[(int) (Math.random()*6)]);
			member.setBrand((String) brand);
			member.setBirth_date(DateUtil.getSQLDate("199"+String.valueOf((int) Math.random()*9)+"-0"+String.valueOf((int) (Math.random()*9+1)) + "-" + String.valueOf((int) (Math.random()*17+10))));
			member.setLast_access(DateUtil.getSQLDate("2024-0"+String.valueOf((int) (Math.random()*3+1)) + "-" + String.valueOf((int) (Math.random()*17+10))));
			member.setMember_type(2);
			member.setGender(Math.random() > 0.5 ? "M":"W");
			member.setSeller_authority("Y");
			member.setCreate_date(DateUtil.getSQLDate("2023-0"+String.valueOf((int) (Math.random()*9+1)) + "-" + String.valueOf((int) (Math.random()*17+10))));
			memberService.memberInsert(member);
		}
		
		System.out.println("member(seller) table set end.");
		
//		String parent;
//		for(CategoryEnum ce :CategoryEnum.values()) {
//			if(ce.name().equals("highest")) continue;
//			category = new CategoryDTO();
//			tmp = (Long) ctg_list.get(ce.name());
//			category.setCategory_id(tmp.intValue());
//			category.setCategory_depth(ce.name().split("_").length);
//			category.setCategory_name(ce.getNameKor().split("_")[0]);
//			
//			parent = ce.getParent();
//			
//			tmp = parent!=null ? ((Long) ctg_list.get(parent)) : null;
//			category.setParent_category_id(tmp!=null ? tmp.intValue() : null);
//			categoryService.categoryInsert(category);
//		}
//		
//		System.out.println("category table set end.");
	}
	
}
