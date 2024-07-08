package com.team4.shoppingmall.coupon;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/coupon")
public class CouponController {
	
	@Autowired
	private CouponService couponService;

	@PostMapping("/checkCouponAvailability.do")
	@ResponseBody
	public int checkCouponAvailability(@RequestParam("couponid") int couponId) {
		
		CouponDTO couponDTO = couponService.selectById(couponId);
		
		int couponRemain = couponDTO.getQuantity();
		return couponRemain;
	}
}
