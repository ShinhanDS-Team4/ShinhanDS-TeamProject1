
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
@RequestMapping("/coupon") 
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
            response.put("message", "濡쒓렇�씤 �썑 荑좏룿�쓣 諛쏆쓣 �닔 �엳�뒿�땲�떎.");
            return response;
        }

        coupon.setMember_id(member.getMember_id()); 

//        CouponDTO coupon2 = new CouponDTO();
//        coupon2.setCoupon_id(coupon.getCoupon_id());
//        coupon2.setMember_id(member.getMember_id());
//        coupon2.setCoupon_name(coupon.getCoupon_name());
//        coupon2.setDiscount_rate((double)coupon.getDiscount_rate());
        coupon.setQuantity(1);

		
	  // �궗�슜�옄媛� �씠誘� 荑좏룿�쓣 媛�吏�怨� �엳�뒗吏� �솗�씤  
	  if (couponService.hasCoupon(coupon) > 0 ) {
		  System.out.println("�씠誘� 諛쒓툒諛쏆� 荑좏룿�엯�땲�떎."); response.put("status", "error");
		  response.put("message", "�씠誘� 諛쒓툒諛쏆� 荑좏룿�엯�땲�떎.");
		  return response; 
	  }
			 
		 

        int success = couponService.assignCouponToMember(coupon);

        if (success == 1) {
            response.put("status", "success");
            response.put("message", "荑좏룿�씠 �꽦怨듭쟻�쑝濡� 諛쒓툒�릺�뿀�뒿�땲�떎.");
        } else { 
        	response.put("status", "error"); 
        	response.put("message", "荑좏룿 諛쒓툒�뿉 �떎�뙣�뻽�뒿�땲�떎."); 
        } 

        return response;
    }



    @PostMapping("/checkLogin")
    @ResponseBody
    public boolean checkLogin(HttpSession session) {
        MemberDTO member = (MemberDTO) session.getAttribute("member");
        return member != null;
    }
    
    
	@PostMapping("/checkCouponAvailability.do")
	@ResponseBody
	public int checkCouponAvailability(@RequestParam("couponid") int couponId) {
		
		CouponDTO couponDTO = couponService.selectById(couponId);
		
		if(!Objects.isNull(couponDTO)) {
			int couponRemain = couponDTO.getQuantity();
			return couponRemain;
		}else {
			return -1;
		}
		
	} 
}
