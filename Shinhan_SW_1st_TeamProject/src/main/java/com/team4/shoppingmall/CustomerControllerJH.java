package com.team4.shoppingmall;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team4.shoppingmall.addr_list.Addr_ListService;
import com.team4.shoppingmall.addr_list.Addr_ListDTO;
import com.team4.shoppingmall.member.MemberService;

@Controller
@RequestMapping("/customer")
public class CustomerControllerJH {
	
	@Autowired
	Addr_ListService addrService;
	
	/*��� �޴� - ��ǰ ��� ��ȸ */
	@GetMapping("/productlist")
	public String productlist() {
		
		return "customer/productlist";
	}
	
	/*���������� ����*/
	@GetMapping("/myPage.do")
	public String myPage() {
		//1.���� �ֹ� ��� �ҷ�����
		
		//2.���� �뿩 ��� �ҷ�����
		
		return "customer/myPage";
	}

	//���� �ֹ� ����Ʈ
	@GetMapping("/orderlist")
	public String orderlist() {
		
		return "customer/orderlist";
	}
	
	//���� �뿩 ����Ʈ
	@GetMapping("/rentlist")
	public String rentlist() {
		//�뿩 ��� ��ȸ
		
		return "customer/rentlist";
	}

	
	/* ȸ���������� */
	//step1
	@GetMapping("/myInfoUpdate.do")
	public String myInfoUpdate(Model model) {
		
		//����� ��� ��ȸ �׽�Ʈ ��
		List<Addr_ListDTO> addrlist = addrService.selectAll();
		model.addAttribute("addrlist", addrlist);
		
		System.out.println("--���� ����� ��ȸ" + addrlist);
		
		return "customer/myInfoUpdate";
	}
	
	//step2 - ��й�ȣ Ȯ�� â
	@GetMapping("/myInfoUpdatePw.do")
	public String myInfoUpdatePw() {
		
		return "customer/myInfoUpdate_step2";
	}
	
	
	//��й�ȣ üũ �� ���� ����(step3)
	@GetMapping("/myInfoUpdatePwCheck.do")
	public String myInfoUpdatePwCheck(@RequestParam("password") String password) {
		//�α��� ȸ�� ��й�ȣ üũ
		if(password.equals("aaa")) {
			return "customer/myInfoUpdate_step3";
		}else {
			System.out.println("���������� ȸ�� ��й�ȣ Ȯ�� ����");
			return "redirect:customer/myInfoUpdate_step2";
		}
		
	}
	
	//step3 - ������ ȸ�� ���� �Է�â	
	@PostMapping("/myInfoUpdateForm.do")
	public String myInfoUpdateForm() {
		System.out.println("����� ��ȸ");
		
		return "customer/myPage";
	}
	
	
	/* ȸ�� Ż�� */
	@GetMapping("/memberDelete.do")
	public String memberDelete() {
		
		return "customer/memberDelete";
	}
	//��й�ȣ üũ �� ȸ�� Ż��
	@GetMapping("/memberDeletePwCheck.do")
	public String memberDeletePwCheck(@RequestParam("password") String password) {
		//�α��� ȸ�� ��й�ȣ üũ
		if(password.equals("aaa")) {
			return "customer/myPage";
		}else {
			System.out.println("ȸ�� Ż�� ����");
			return "redirect:customer/memberDelete";
		}
		
	}
	
}
