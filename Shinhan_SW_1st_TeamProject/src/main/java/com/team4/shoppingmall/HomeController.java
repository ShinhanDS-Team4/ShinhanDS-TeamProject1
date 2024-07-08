package com.team4.shoppingmall;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.amazonaws.services.elasticloadbalancingv2.model.RedirectActionConfig;
import com.team4.shoppingmall.coupon.CouponDTO;
import com.team4.shoppingmall.coupon.CouponService;
import com.team4.shoppingmall.event.EventService;
import com.team4.shoppingmall.member.MemberDTO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	@Autowired
	EventService eService = new EventService();

	@Autowired
	CouponService cService = new CouponService();

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		// 이벤트와 쿠폰정보 담기 
		model.addAttribute("event", eService.selectFirst()); 
		MemberDTO member = (MemberDTO) session.getAttribute("member");   
		
		String message = "";

		CouponDTO coupon = cService.selectFirst();
		if(member != null) {
			coupon.setMember_id(member.getMember_id()); 
		} else {
			message = "로그인이 필요합니다."; 
		} 

		model.addAttribute("message", message);
		model.addAttribute("coupon", coupon);

		return "home";
	}

}
