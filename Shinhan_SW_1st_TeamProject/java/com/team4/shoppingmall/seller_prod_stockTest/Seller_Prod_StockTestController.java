package com.team4.shoppingmall.seller_prod_stockTest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/?")
public class Seller_Prod_StockTestController {
	
	@Autowired
	Seller_Prod_StockTestService seller_prod_stockService;
}
