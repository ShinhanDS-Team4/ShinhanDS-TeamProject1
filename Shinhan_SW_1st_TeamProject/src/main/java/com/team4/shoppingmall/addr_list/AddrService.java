package com.team4.shoppingmall.addr_list;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AddrService {
	
	@Autowired
	Addr_ListDAOInterface addr_ListDAOMybatis;
	
	
	public List<Addr_ListDTO> selectAll() {
		return addr_ListDAOMybatis.selectAll();
	}
	
	public List<Addr_ListDTO> selectByMember_Id(String member_id) {
		return addr_ListDAOMybatis.selectByMember_Id(member_id);
	}

	public int addressInsert(Addr_ListDTO addr_list) {
		return addr_ListDAOMybatis.addressInsert(addr_list);
	}
	
	public int addressUpdate(Addr_ListDTO addr_list) {
		return addr_ListDAOMybatis.addressUpdate(addr_list);
	}

	public int addressDelete(int addr_num) {
		return addr_ListDAOMybatis.addressDelete(addr_num);
	};
	
}
