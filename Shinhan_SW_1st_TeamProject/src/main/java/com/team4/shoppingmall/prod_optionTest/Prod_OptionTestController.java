package com.team4.shoppingmall.prod_optionTest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/?")
public class Prod_OptionTestController {
	
	@Autowired
	Prod_OptionTestService prod_optionService;
	
}
