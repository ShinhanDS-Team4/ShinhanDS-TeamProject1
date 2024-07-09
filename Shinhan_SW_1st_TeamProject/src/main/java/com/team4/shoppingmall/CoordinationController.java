package com.team4.shoppingmall;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team4.shoppingmall.cart.CartDTO;
import com.team4.shoppingmall.cart.CartService;
import com.team4.shoppingmall.customer.CustomerService;
import com.team4.shoppingmall.member.MemberDTO;
import com.team4.shoppingmall.member.MemberService;
import com.team4.shoppingmall.order_prod.OrderProdService;
import com.team4.shoppingmall.prod.ProdDTO;
import com.team4.shoppingmall.prod.ProdService;
import com.team4.shoppingmall.prodTest.ProdTestDTO;
import com.team4.shoppingmall.prodTest.ProdTestService;
import com.team4.shoppingmall.prod_image.Prod_ImageService;
import com.team4.shoppingmall.prod_option.Prod_OptionService;
import com.team4.shoppingmall.rent.RentService;

@Controller
@RequestMapping("/customer")
public class CoordinationController {
	
	@Autowired
	CartService cartService;

	@Autowired
	MemberService memberService;

	@Autowired
	OrderProdService orderProdService;

	@Autowired
	Prod_OptionService prod_OptionService;

	@Autowired
	RentService rentService;

	@Autowired
	CustomerService customerService;
	
	@Autowired
	Prod_ImageService imageService;
	
	@Autowired
	ProdTestService prodService;

	public Double scoring(String prod_id1, String prod_id2) throws IOException, ParseException {
		JSONParser parser = new JSONParser();
		Reader wght_reader = new FileReader("C:\\uploaded_files/recm_weights.json");
		Reader wghtf_reader = new FileReader("C:\\uploaded_files/recm_weights_for.json");
		Reader wghtff_reader = new FileReader("C:\\uploaded_files/recm_weights_for_for.json");
		
		File file1 = new File("C:\\uploaded_files\\main\\json/"+prod_id1+".json");
		File file2 = new File("C:\\uploaded_files\\main\\json/"+prod_id2+".json");
		
		if(!file1.exists() || !file2.exists()) return 0.0;
		
		Reader prod1_reader = new FileReader("C:\\uploaded_files\\main\\json/"+prod_id1+".json");
		Reader prod2_reader = new FileReader("C:\\uploaded_files\\main\\json/"+prod_id2+".json");
		
		JSONObject wght = (JSONObject) parser.parse(wght_reader);
		JSONObject wghtf = (JSONObject) parser.parse(wghtf_reader);
		JSONObject wghtff = (JSONObject) parser.parse(wghtff_reader);
		
		JSONObject prod1 = (JSONObject) parser.parse(prod1_reader);
		JSONObject prod2 = (JSONObject) parser.parse(prod2_reader);
		
		Double clsScore;
		Double score = 0.0;
		int count = 0;
		JSONArray prod1_d;
		JSONArray prod2_d;
		
		JSONObject wght_d;
		JSONObject wght_dd;
		JSONObject wght_ddd;
		Double wght_dddd;
		
		JSONObject wghtf_d;
		JSONObject wghtf_dd;
		Double wghtf_ddd;
		
		JSONObject wghtff_d;
		Double wghtff_dd;
		
		Long tmp;
		
		for(Object cls1 :prod1.keySet()) {
			prod1_d = (JSONArray) prod1.get(cls1);
			wght_d = (JSONObject) wght.get(cls1);
			wghtf_d = (JSONObject) wghtf.get(cls1);
			wghtff_d = (JSONObject) wghtff.get(cls1);
			
			for(Object attr1:prod1_d) {
				
				if(wght_d.containsKey(attr1)) {
					wght_dd = (JSONObject) wght_d.get(attr1);
					wghtf_dd = (JSONObject) wghtf_d.get(attr1);
					tmp = (Long) wghtff_d.get(attr1);
					wghtff_dd = tmp.doubleValue();
					
					for(Object cls2 :prod2.keySet()) {
						
						if(wght_dd.containsKey(cls2)) {
							prod2_d = (JSONArray) prod2.get(cls2);
							wght_ddd = (JSONObject) wght_dd.get(cls2);
							tmp = (Long) wghtf_dd.get(cls2);
							wghtf_ddd = tmp.doubleValue();
						
							for(Object attr2 :prod2_d) {
								
								if(wght_ddd.containsKey(attr2)) {
									tmp = (Long) wght_ddd.get(attr2);
									wght_dddd = tmp.doubleValue();
									
									clsScore = (Double) (wghtf_ddd/wghtff_dd);
									score += (1/(1-clsScore))*wght_dddd;
									count += 1;									
								}
							}
						}
					}
				}
					
			}
		}
		
		score /= count;
		
		return score;
	}
	
	@GetMapping("/coordination.do")
	public String coordinationPage(HttpSession session, Model model) {
		//session
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		String member_id = member.getMember_id();
		
		
		//판매 장바구니 상품 정보 모두 조회
		List<Map<String,Object>> cartProdInfo = cartService.selectSellCartProdInfo(member_id);
		model.addAttribute("cartProdInfo", cartProdInfo);
		
        
		return "customer/coordination";
	}
	
	//id 리턴 시 리턴 타입 변경하기
	@GetMapping("/recommend.do")
    public String coordination2Page(HttpSession session, 
                                    Model model,
                                    String prod_id) throws IOException, ParseException {
		List<Integer> ctgList = new ArrayList<Integer>();
		ctgList.add(11140000);
		ctgList.add(11100000);
		ctgList.add(11120000);
		ctgList.add(11130000);
		ctgList.add(11150000);
		ctgList.add(11180000);
		ctgList.add(11170000);
        // session 
        MemberDTO member = (MemberDTO)session.getAttribute("member");
        String gender = member.getGender();
        
        ProdDTO this_prod = prodService.selectByProdId(prod_id);
        Integer this_category_id = this_prod.getCategory_id();
        this_category_id = Integer.parseInt(String.valueOf(this_category_id).substring(0, 4) + "0000");
        
        Map<String, ProdDTO> prods = new HashMap<String, ProdDTO>();
        
        Map<Integer, String> mapper = new HashMap<Integer, String>();
        mapper.put(11140000, "outer");
        mapper.put(11100000, "jacket");
        mapper.put(11120000, "neat");
        mapper.put(11130000, "shirt");
        mapper.put(11150000, "tshirt");
        mapper.put(11180000, "pants");
        mapper.put(11170000, "skirt");
        
        Map<Integer, List<ProdDTO>> candi = new HashMap<Integer, List<ProdDTO>>();

        for(Integer ctgid :ctgList) {
        	if(ctgid.equals(this_category_id)) {
        		prods.put(mapper.get(ctgid), this_prod);
        	} else {
        		candi.put(ctgid, prodService.selectAllByCtgWhenRcmd(ctgid));
        		
        		prods.put(mapper.get(ctgid), null);
        	}
        }
        int cnt;
        ProdDTO candi_prd;
        for(Integer ctgid :ctgList) {
        	double score=0.0;
        	cnt = 0;
        	if(!ctgid.equals(this_category_id)) {
        		
        		for(int i=0;i<candi.get(ctgid).size();i++) {
        			double new_score=0.0;
        			if(cnt==5) break;
        			candi_prd = candi.get(ctgid).get((int) (Math.random()*candi.get(ctgid).size()));
        			
        			new_score = scoring(this_prod.getProd_id(), candi_prd.getProd_id()) + scoring(candi_prd.getProd_id(), this_prod.getProd_id());
        			
        			if(new_score > score) {
        				score = new_score;
        				prods.put(mapper.get(ctgid), candi_prd);
        			}
        			
        			cnt+=1;
        	}
        	}
        }
        
        
        // cart_id 읽어오기 (테스트용)
        // Integer cart_id = 44;
        System.out.println(prods);
        model.addAttribute("prods", prods);
        model.addAttribute("selected", mapper.get(this_category_id));
        model.addAttribute("gender", gender);

        return "customer/recommend"; // cart_id를 리턴
    }
}