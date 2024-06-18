package com.team4.shoppingmall.buyer_inq;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/?")
public class Buyer_InqController {
	
	@Autowired
	Buyer_InqService buyer_inqService;
	
}
