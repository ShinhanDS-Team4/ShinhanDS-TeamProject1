package com.team4.shoppingmall.wish_list;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/?")
public class Wish_ListController {
	
	@Autowired
	Wish_ListService wish_listService;
	
}
