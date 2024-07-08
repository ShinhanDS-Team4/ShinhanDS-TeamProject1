
package com.team4.shoppingmall.coupon;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team4.shoppingmall.member.MemberDTO;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/coupons")
public class CouponController {

	@Autowired
	CouponService couponService;

	@PostMapping("/receive")
	@ResponseBody
	public Map<String, String> receiveCoupon(CouponDTO coupon, HttpSession session) {
		Map<String, String> response = new HashMap<>();
		MemberDTO member = (MemberDTO) session.getAttribute("member");

		if (member == null) {
			response.put("status", "error");
			response.put("message", "로그인 후 쿠폰을 받을 수 있습니다.");
			return response;
		}

		coupon.setMember_id(member.getMember_id());
		coupon.setQuantity(1);

		// 사용자가 이미 쿠폰을 가지고 있는지 확인
		if (couponService.hasCoupon(coupon) > 0) {
			System.out.println("이미 발급받은 쿠폰입니다.");
			response.put("status", "error");
			response.put("message", "이미 발급받은 쿠폰입니다.");
			return response;
		}

		int success = couponService.assignCouponToMember(coupon);

		if (success == 1) {
			response.put("status", "success");
			response.put("message", "쿠폰이 성공적으로 발급되었습니다.");
		} else {
			response.put("status", "error");
			response.put("message", "쿠폰 발급에 실패했습니다.");
		}

		return response;
	}

	@PostMapping("/checkLogin")
	@ResponseBody
	public boolean checkLogin(HttpSession session) {
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		System.out.println("로그인한 멤버: " + member);
		return member != null;
	}

	@PostMapping("/checkCouponAvailability.do")
	@ResponseBody
	public int checkCouponAvailability(@RequestParam("couponid") int couponId) {

		CouponDTO couponDTO = couponService.selectById(couponId);

		if (!Objects.isNull(couponDTO)) {
			int couponRemain = couponDTO.getQuantity();
			return couponRemain;
		} else {
			return -1;
		}

	}
}
