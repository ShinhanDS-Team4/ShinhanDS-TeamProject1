package com.team4.shoppingmall.buyer_inq;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team4.shoppingmall.admin_inq.Admin_InqDTO;
import com.team4.shoppingmall.admin_inq.Admin_InqService;
import com.team4.shoppingmall.member.MemberDTO;
import com.team4.shoppingmall.member.MemberService;

@Controller
@RequestMapping("/qna")
public class Buyer_InqController {
	
	@Autowired
	Buyer_InqService buyer_inqService;
	
}