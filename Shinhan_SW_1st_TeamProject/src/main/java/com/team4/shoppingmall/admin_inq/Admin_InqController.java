package com.team4.shoppingmall.admin_inq;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/?")
public class Admin_InqController {
	
	@Autowired
	Admin_InqService admin_inqService;

}
