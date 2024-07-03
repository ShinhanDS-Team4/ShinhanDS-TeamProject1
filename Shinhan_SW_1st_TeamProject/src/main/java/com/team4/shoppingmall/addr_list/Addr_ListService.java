package com.team4.shoppingmall.addr_list;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class Addr_ListService {
	
	@Autowired
	Addr_ListDAOInterface addr_ListDAOMybatis;
	
	
	public List<Addr_ListDTO> selectAll() {
		return addr_ListDAOMybatis.selectAll();
	}
	
	public List<Map<String,Object>> selectByMember_Id(String member_id) {
		return addr_ListDAOMybatis.selectByMember_Id(member_id);
	}

	@Transactional
	public int addressInsert(Addr_ListDTO addr_list) {
		
		// 기존 is_master_addr 값을 N으로 업데이트
		int updateToNresult = addr_ListDAOMybatis.updateMasterAddrToN();
		
        // 새로운 주소 삽입
        int result = addr_ListDAOMybatis.addressInsert(addr_list);

        return result;
	}
	
	public int addressUpdate(Addr_ListDTO addr_list) {
		return addr_ListDAOMybatis.addressUpdate(addr_list);
	}

	public int addressDelete(int addr_num) {
		return addr_ListDAOMybatis.addressDelete(addr_num);
	}

	//나의 주소 개수 
	public int countAddresses(String member_id) {
		return addr_ListDAOMybatis.countAddresses(member_id);
	}
	
}
