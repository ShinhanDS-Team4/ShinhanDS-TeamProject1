package com.team4.shoppingmall.prod;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ProdController {
	
	/* 상품 상세 페이지 */
	//@GetMapping("/customer/product_detail")
	public void productDetail() {
		
	}
	
	//상품 선택한 옵션 값 저장하기
	//@GetMapping("/customer/productOption")
	public void productInsert(@RequestParam("product-size") String productSize,
							  @RequestParam("product-color") String productColor) {
		
		// 선택된 옵션 값 확인 
        System.out.println("Selected option1: " + productSize);
        System.out.println("Selected option2: " + productColor);
	}
}
