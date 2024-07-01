package com.team4.shoppingmall.addr_list;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Addr_ListController {
	
	@Autowired
	Addr_ListService addrService;
	
	/* ����� */
	//���� ����� ��ȸ
	@GetMapping("/customer/myAddrSelectAll")
	public String myAddrSelectAll(Model model, HttpServletRequest request) {
		
		//1-�α��� ȸ�� ����
		//List<MemberDTO> memberlist = MemberService.selectAll();
		//model.addAttribute("memberlist", memberlist);
		
		//2-�ּ� ���
		//List<Addr_ListDTO> addrlist = addrService.selectByMember_Id(member_id);
		//model.addAttribute("addrlist", addrlist);
		
		//System.out.println("--���� ����� ��ȸ" + addrlist);
		
		//return "redirect:customer/myInfoUpdate";
		
		return null;
	}
	
	//����� �߰�
	@GetMapping("/customer/myAddrInsert")
	public String myAddrInsert() {
		
		System.out.println("�ּ� �ְ�");
		
		return "redirect:customer/myInfoUpdate";
	}
	
	//����� ����
	@GetMapping("/customer/myAddrDelete")
	public String myAddrDelete() {
		
		
		return "redirect:customer/myInfoUpdate";
	}
	
	//����� ����
	@GetMapping("/customer/myAddrUpdate")
	public String myAddrUpdate() {
		
		System.out.println("�ּ� ����");
		
		return "redirect:customer/myInfoUpdate";
	}
	
}
